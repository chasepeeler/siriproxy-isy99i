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
	configIsy(config)
  end

  class Rest
    include HTTParty
    format :xml
  end

  listen_for (/turn (on|off) (.*)/i) do |command, name|
	command_turn(command, name)
	request_completed
  end
  
  listen_for (/ring doorbell/i) do
	command_turn("on", "doorbell")
	request_completed
	sleep(2)
	command_turn("off", "doorbell")
  end
  
  listen_for (/alarm (disarm|stay|away)/i) do |command|
	command_alarm command
	request_completed
  end

  listen_for (/(open|close) garage/i) do |command|
	Rest.get(@isyIp + @nodeId["garage"] + @nodeCmd["on"], @isyAuth)
	command_garage command
	request_completed
	Rest.get(@isyIp + @nodeId["garage"] + @nodeCmd["off"], @isyAuth)
  end

  def command_turn(command, name)
	nodeid = @nodeId[name.downcase.strip]
	unless nodeid.nil?
		say "OK. I am turning #{command.downcase.strip} #{name.downcase.strip} now."
		Rest.get(@isyIp + nodeid + @nodeCmd[command.downcase.strip], @isyAuth) 
	else
		say "I'm sorry, but I am not programmed to control #{name.downcase.strip}."
	end
  end	
		
  def command_alarm(command)
	alarmcmd = @alarmCmd[command.downcase.strip]
	say "OK. I am changing alarm state to #{command}."
	Rest.get(@isyIp + @areaCmd["first floor"] + alarmcmd + @elkCode, @isyAuth)
	push_image("Arming Station", @webIp + "/#{command.downcase.strip}.png")
  end
  
  def command_garage(command)
	push_image("Garage Camera", @camUrl["garage"])
	voltage = status_zone("garage door")
	if (voltage < 7.0 && command.downcase.strip == "open")
		say "OK. I am opening your garage door."
		Rest.get(@isyIp + @outputCmd["garage door"], @isyAuth)
	elsif (voltage > 7.0 && command.downcase.strip == "close")
		response = ask "I would not want to cause injury or damage. Is the garage door clear?"
		if (response =~ /yes|yep|yeah|ok/i)
			say "Thank you. I am closing your garage door."
			Rest.get(@isyIp + @outputCmd["garage door"], @isyAuth)
		else
			say "OK. I will not close your garage door."
		end
	else
		say "Your garage door is already #{command.downcase.strip}, Cabrone."
  	end
  end
  
  def push_image(title, image)
	object = SiriAddViews.new
	object.make_root(last_ref_id)
	answer = SiriAnswer.new(title, [SiriAnswerLine.new('logo', image)])
	object.views << SiriAnswerSnippet.new([answer])
	send_object object
  end		

  def status_zone(zone)
  	get_status = Rest.get(@isyIp + @zoneSt[zone], @isyAuth).inspect
  	status = get_status.gsub(/^.*val\D+/, "")
   	status = status.gsub(/\D+\D+.*$/, "")
	voltage = status.to_f / 10
	return voltage
  end
  			
  
end
