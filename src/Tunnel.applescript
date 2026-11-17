-- Toggle GlobalProtect by loading/unloading its launch agents.
set isLoaded to true
try
	do shell script "launchctl list com.paloaltonetworks.gp.pangpa"
on error
	set isLoaded to false
end try

if isLoaded then
	do shell script "launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
	display notification "Launch agents unloaded." with title "WiscVPN OFF"
else
	do shell script "launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
	display notification "Launch agents loaded." with title "WiscVPN ON"
end if
