siriproxy-isy99i
================

About
-----

Siriproxy-isy99i is a [SiriProxy] (https://github.com/plamoni/SiriProxy) plugin that allows you to control home automation devices using the [Universal Devices ISY-99i Series] (http://sales.universal-devices.com) controller through Apple's Siri interface on any iOS device that supports Siri. It does not require a jailbreak, nor do I endorse doing so.   

My fork of [Hoopty3’s plugin] (https://github.com/hoopty3/siriproxy-isy99i) is just that. The long term goal is to make the plugin self aware of the ISY and configuration, thus I do not intend to merge changes not consistent with that goal.  Aside from completely rewriting the plugin from scratch, the baseline functional changes I made from Hoopty3’s plugin include:
- Added Elk M1 Gold control for arming, disarming, and relay output control.
- Added ability to push IP camera and custom images to Siri.     
- Removed the Insteon thermostat control since I have a [Nest] (http://www.nest.com) thermostat which can also be controlled by SiriProxy thanks to [Chilitechno's plugin.] (https://github.com/chilitechno/SiriProxy-NestLearningThermostat)
- Removed dimmer control since I have mostly CFL’s in my home and already have visual feedback.  Seemed like a lot of extra code to maintain for little value added, not to mention I think there were some problems correctly parsing device status.    

First, you must have SiriProxy installed and working.  [HOW-TOs for SiriProxy] (https://github.com/plamoni/SiriProxy/wiki/Installation-How-Tos) 

Second, you must have an ISY-99i series home automation controller installed and configured to control your Insteon/X10/Zwave/Zigbee devices.  Optionally, you can control the [Elk Products](http://www.elkproducts.com) M1 Gold security panel and IP based security cameras.    

Third, in order push custom images and to support images from IP cameras requiring authentication, you need to have access to or set up a web server on your SiriProxy server to cache the camera image to push to Siri.  Simply type `apt-get install apache2 -y`.   The default configuration for APACHE will work.   SiriProxy will need write permission to the `/var/www/` folder, which if you are running SiriProxy as ROOT will be able to write the camera image. 

[Watch Demo Video](http://www.youtube.com/watch?v=PXmCiaRc9XU)  

[![Video](http://img.youtube.com/vi/PXmCiaRc9XU/hqdefault.jpg)](http://www.youtube.com/watch?v=PXmCiaRc9XU)

I have received offers to make a donation to help offset the cost of hardware and for my time.  If you feel so inclined you can donate thru PayPal.  

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HQMKLUZY23SEE)


Universal Devices ISY-99i
--------------------------

The Universal Devices ISY-99i series of home automation controllers have a REST API which can be used for monitoring and control of your home automation system, including the Elk M1 Gold security panel if you purchase the Universal Devices add-on module for two way communication.  

The [ISY Developers Manual and Elk Integration Manual](http://www.universal-devices.com/developers/wsdk/) documents the REST API for the ISY-99i series of controllers.

Here are some simple [BASH scripts] (https://gist.github.com/4052516) you use to experiment with ISY-99i REST API.    

There also is a very active user and developer [support forum.](http://forum.universal-devices.com)


Installation (New for SiriProxy 0.5.0+)
---------------------------------------


- Create a plugins directory  

`mkdir ~/plugins`  

`cd ~/plugins/` 

- Get the latest repo   

`git clone git://github.com/elvisimprsntr/siriproxy-isy99i`

- Add the example configuration to the master config.yml  

`cat siriproxy-isy99i/config-info.yml >> ~/.siriproxy/config.yml`

- Edit the config.yml as required.     **Note: Make sure to line up the column spacing.**

`vim ~/.siriproxy/config.yml`

- Edit the isyconfig.rb as you wish.  **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-isy99i/lib/isyconfig.rb`

- Edit the plugin as you wish.  **Note: Repeat all the following steps if you make additional changes.**    

`vim siriproxy-isy99i/lib/siriproxy-isy99i.rb`

- Bundle  

`siriproxy bundle`

- Run (Ref: https://github.com/plamoni/SiriProxy#set-up-instructions)  

`[rvmsudo] siriproxy server [-d ###.###.###.###] [-u username]`


Usage
-----

**Turn on|off (name)**

- Will turn on or off the device. 

**Alarm disarm|away|stay**

- Siri will change the alarm to the state requested and pushes a custom image to Siri.  
- Note: Siri has a lot of trouble with “S” sounds at the beginning and end of words, so you may have to alter your speech slightly.

**Open|close garage**

- Siri will push an image from your IP camera and check the status of the door.  If the door is already in the requested position, it will let you know.  
- If the garage door is closed it will open without any need for confirmation.
- If the door is open, Siri will ask you to confirm the door is clear before closing the door. Obviously, this was for safety reasons. 


To Do List
----------

If you want to collaborate, review the issues list for things to implement. Fork, modify, test, and submit a pull request.

Licensing
---------

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).

