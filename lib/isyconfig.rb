def configIsy(config)

# Node IDs
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
# Note: Eliminate leading zeros in device address.  
@nodeId = Hash.new
@nodeId["all lights"] 		= "/rest/nodes/8730"
@nodeId["attic"] 			= "/rest/nodes/18595"
@nodeId["away"] 			= "/rest/nodes/4597"
@nodeId["exterior"] 		= "/rest/nodes/32377"
@nodeId["porch"] 			= "/rest/nodes/32377"
@nodeId["driveway"] 		= "/rest/nodes/32377"
@nodeId["balcony"] 			= "/rest/nodes/32377"
@nodeId["garage"] 			= "/rest/nodes/27356"
@nodeId["home"] 			= "/rest/nodes/39198"
@nodeId["kitchen"] 			= "/rest/nodes/20304"
@nodeId["landing"] 			= "/rest/nodes/6489"
@nodeId["living"] 			= "/rest/nodes/19496"
@nodeId["master"] 			= "/rest/nodes/25061"
@nodeId["movie"] 			= "/rest/nodes/26974"
@nodeId["party"] 			= "/rest/nodes/25568"
@nodeId["stairwell"] 		= "/rest/nodes/32068"
@nodeId["theater"] 			= "/rest/nodes/44403"
@nodeId["theater ceiling"] 	= "/rest/nodes/59332"
@nodeId["theater drapes"] 	= "/rest/nodes/37131"
@nodeId["theater lamp"] 	= "/rest/nodes/61694"
@nodeId["theater valance"] 	= "/rest/nodes/8000"
@nodeId["doorbell"] 		= "/rest/nodes/1C%207%2049%202"

# Node commands
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@nodeCmd = Hash.new
@nodeCmd["on"] 	= "/cmd/DON"
@nodeCmd["off"] = "/cmd/DOF"

# ISY inputs
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
# Note: Eliminate leading zeros in device address.  
# Note: Battery operated devices do not continuously report status, thus will be blank until first change after an ISY reboot or power cycle.
@inputSt = Hash.new
@inputSt["attic moisture"] 		= "/rest/status/11%2073%2097%201"
@inputSt["deck box motion"] 	= "/rest/status/11%20A4%207A%201"
@inputSt["deck box open"] 		= "/rest/status/14%2048%20F9%201"
@inputSt["doorbell"] 			= "/rest/status/1C%207%2049%201" 
@inputSt["porch motion"] 		= "/rest/status/1C%205%20FF%201" 
@inputSt["stairwell motion"] 	= "/rest/status/14%207E%2049%201"

# Future use
@programId = Hash.new
@networkId = Hash.new

# Elk areas
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@areaCmd = Hash.new
@areaCmd["first floor"] 	= "/rest/elk/area/1/cmd"
@areaCmd["second floor"] 	= "/rest/elk/area/2/cmd"
@areaCmd["third floor"] 	= "/rest/elk/area/3/cmd"
@areaCmd["garage"] 			= "/rest/elk/area/4/cmd"

# Elk zones
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@zoneSt = Hash.new 
@zoneSt["garage door"] 		= "/rest/elk/zone/14/query/voltage"
@zoneSt["garage motion"] 	= "/rest/elk/zone/15/query/voltage"

# Elk outputs
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@outputCmd = Hash.new
@outputCmd["garage door"] 	= "/rest/elk/output/3/cmd/on?offTimerSeconds=2"
@outputCmd["garage record"] = "/rest/elk/output/7/cmd/on?offTimerSeconds=2"

# Elk alarm modes
# Note: Must all be lower case. Use multiple entries for variability in Siri response.
@alarmCmd = Hash.new
@alarmCmd["away"] 			= "/arm?armType=1&code="
@alarmCmd["disarm"] 		= "/disarm?code="
@alarmCmd["stay"] 			= "/arm?armType=2&code="

end