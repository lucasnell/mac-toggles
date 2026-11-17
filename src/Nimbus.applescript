-- Toggle cloud sync apps: if any listed app is running, quit them all; otherwise open them all.
property cloudApps : {"Google Drive", "OneDrive", "Box"}

on isRunning(appName)
	tell application "System Events" to return (exists (processes whose name is appName))
end isRunning

set anyRunning to false
repeat with a in cloudApps
	if my isRunning(a as text) then set anyRunning to true
end repeat

if anyRunning then
	repeat with a in cloudApps
		if my isRunning(a as text) then
			try
				tell application (a as text) to quit
			end try
		end if
	end repeat
	delay 3
	set stillUp to {}
	repeat with a in cloudApps
		if my isRunning(a as text) then set end of stillUp to (a as text)
	end repeat
	if stillUp is {} then
		display notification "Google Drive, OneDrive, and Box quit." with title "Cloud services OFF"
	else
		set AppleScript's text item delimiters to ", "
		display notification "Still running: " & (stillUp as text) with title "Cloud services"
	end if
else
	repeat with a in cloudApps
		try
			do shell script "open -g -a " & quoted form of (a as text)
		end try
	end repeat
	display notification "Google Drive, OneDrive, and Box launched." with title "Cloud services ON"
end if
