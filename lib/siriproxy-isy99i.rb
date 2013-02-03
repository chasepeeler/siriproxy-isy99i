require 'httparty'
require 'siri_objects'
require 'isyconfig'

class SiriProxy::Plugin::Isy99i < SiriProxy::Plugin
  attr_accessor :isyip
  attr_accessor :isyid
  attr_accessor :isypw
  attr_accessor :elkcode
  attr_accessor :camurls
  attr_accessor :camid
  attr_accessor :campw
  attr_accessor :webip
  
  def initialize(config = {})  
	@isyIp		= config["isyip"]
	@isyAuth	= {:basic_auth => {:username => config["isyid"], :password => config["isypw"]}}
	@elkCode	= config["elkcode"]
	@camUrl 	= Hash.new
	@camUrl 	= config["camurls"]
	@camAuth 	= nil
	@camAuth 	= {:http_basic_authentication => [config["camid"], config["campw"]]} if config["camid"] 
	@webIp 		= config["webip"] 

	configIsy(config)
  end

  class Rest
    include HTTParty
    format :xml
  end

  listen_for (/turn (on|off) (.*)/i) do |command, name|
	command_node(command.downcase.strip, name.downcase.strip)
	request_completed
  end
  
  listen_for (/ring doorbell/i) do
	command_node("on", "doorbell")
	request_completed
  end
  
  listen_for (/status (.*)/i) do |input|
  	command_status input.downcase.strip
	request_completed
  end
  	  
  listen_for (/alarm (disarm|stay|away)/i) do |command|
	command_alarm command.downcase.strip
	request_completed
  end

  listen_for (/(open|close) garage/i) do |command|
	command_garage command.downcase.strip
	request_completed
  end

  def command_node(command, name)
	nodeid = @nodeId[name]
	unless nodeid.nil?
		say "OK. I am turning #{command} #{name} now."
		Rest.get(@isyIp + nodeid + @nodeCmd[command], @isyAuth) 
	else
		say "I'm sorry, but I am not programmed to control #{name}."
	end
  end	
		
  def command_status(input)
  	inputst = @inputSt[input]
  	unless inputst.nil?
  		status = status_input(inputst)
  		say "#{input} is #{status}" 
  	else
  		say "I'm sorry, but I am not programmed to check #{input} status." 
  	end
  end	


  def command_alarm(command)
	alarmcmd = @alarmCmd[command]
	say "OK. I am changing alarm state to #{command}."
	Rest.get(@isyIp + @areaCmd["first floor"] + alarmcmd + @elkCode, @isyAuth)
	push_image("Arming Station", @webIp + "/#{command}.png")
  end
  
  def command_garage(command)
	Rest.get(@isyIp + @nodeId["garage"] + @nodeCmd["on"], @isyAuth)
	push_image("Garage Camera", @camUrl["garage"])
	status = status_zone("garage door")
	if (status == "closed" && command == "open")
		say "OK. I am opening your garage door."
		Rest.get(@isyIp + @outputCmd["garage door"], @isyAuth)
	elsif (status == "open" && command == "close")
		response = ask "I would not want to cause injury or damage. Is the garage door clear?"
		if (response =~ /yes|yep|yeah|ok/i)
			say "Thank you. I am closing your garage door."
			Rest.get(@isyIp + @outputCmd["garage door"], @isyAuth)
		else
			say "OK. I will not close your garage door."
		end
	else
		say "Your garage door is already #{status}, Cabrone."
  	end
	Rest.get(@isyIp + @nodeId["garage"] + @nodeCmd["off"], @isyAuth)
  end
  
  def status_input(input)
  	# Battery operated devices do not continuously reports status, thus will be blank until first change after an ISY reboot or power cycle.
	resp = Hash[Rest.get(@isyIp + input, @isyAuth).parsed_response]
	status = resp["properties"]["property"]["formatted"]
	return status.downcase.strip
  end
  			
  def status_zone(zone)
  	resp = Hash[Rest.get(@isyIp + @zoneSt[zone], @isyAuth).parsed_response]
  	voltage = resp["ze"]["val"].to_f / 10
	if (voltage > 10) 
		status = "open"
	else
		status = "closed"	
	end
	return status.downcase.strip
  end

  def push_image(title, image)
	object = SiriAddViews.new
	object.make_root(last_ref_id)
	answer = SiriAnswer.new(title, [SiriAnswerLine.new('logo', image)])
	object.views << SiriAnswerSnippet.new([answer])
	send_object object
  end		

  
end
