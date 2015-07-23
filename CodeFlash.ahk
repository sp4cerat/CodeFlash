#SingleInstance force
#Persistent
bracketon := 0
Menu, Tray, NoStandard
Menu, Tray, Add , About, ButtonAbout
Menu, Tray, Add , Help, ButtonHelp
Menu, Tray, Add , Exit, ButtonExit 

l := 0
idmax := 1
AutoTrim, off

Loop, read, %A_WorkingDir%\cmd.txt
{
    if (l & 1) = 0
    {
	    Loop, parse, A_LoopReadLine, %A_Space%
	    {
		cmdarray%idmax% := A_LoopField
		idmax := idmax+1
	    }
    }
    if (l & 1) = 1
    {
        cmdarray%idmax% := A_LoopReadLine
	;MsgBox % cmdarray%id%	
	idmax := idmax+1
    }
    l := l+1
}
MsgBox, CodeFlash Active !
return

F12::
Send, ok{Return}
return


CapsLock::
+CapsLock::
keywait, Capslock
SetCapsLockState, Off

#x::

tmp = %clipboard%
Send, +{Home}+{Home}^x
Sleep 100

AutoTrim, off
cmdstrpure = %clipboard%
AutoTrim, on
cmdstr = %cmdstrpure%
AutoTrim, off

dstring := ""
delta := InStr(cmdstrpure, cmdstr , true, 1)
if delta>1
{ 
	dstring:=SubStr(cmdstrpure, 1 , delta-1)
	;MsgBox, %dstring% 
}

StringSplit, cmdarr, cmdstr , %A_Space%

idx  := 0 * 5 + 1
idx1 := 0 * 5 + 2
;

while idx < idmax && !(cmdarr1 = cmdarray%idx% && cmdarr0 = cmdarray%idx1%+1 ) 
{
	idx  := idx  + 5
	idx1 := idx1 + 5
}

if idx-idmax >= 0
{
	;MsgBox, break %idx% %idmax% %cmdstrpure%
	clipboard = %cmdstrpure%
	Sleep 100
	Send ^v
	Sleep 100
	clipboard = %tmp%
	return
}
	
cmd := cmdarray%idx%
idx := idx+1
numparams := cmdarray%idx%
idx := idx+1
cx := cmdarray%idx%
idx := idx+1
cy := cmdarray%idx%
idx := idx+1
cmdout := cmdarray%idx%
;MsgBox, a %dstring% b
StringReplace, cmdout, cmdout, $n$ ,`n, All
StringReplace, cmdout, cmdout, $l$ ,%dstring%, All

;MsgBox, %numparams%
Loop, %numparams%
{
	cmdidx := A_Index + 1
	repl := cmdarr%cmdidx%
	StringReplace, cmdout, cmdout, $%A_Index%$ ,%repl%, All
	;MsgBox, $%A_Index%$
}

clipboard := cmdout
Send ^v
Sleep 100
clipboard = %tmp%
Sleep 100

if cy > 0
Loop, %cy%
Send, {Down}

cy := -cy

if cy > 0
Loop, %cy%
Send, {Up}

if cx > 0
Loop, %cx%
Send, {Right}

cx := -cx

if cx > 0
Loop, %cx%
Send, {Left}

;Send, %cx% %cy%

return

ButtonHelp:

idx  := 0 * 5 + 1

hlp := "Loaded templates:`n`n"

while idx < idmax  
{
	idx1 := idx  + 1
	idx2 := idx  + 4
	hst := cmdarray%idx2%
	if cmdarray%idx1% < 0 
		break

	StringReplace, hst, hst, $n$ , , All
	StringReplace, hst, hst, $l$ , , All
	hlp .= cmdarray%idx% " " cmdarray%idx1% " parm(s) -> " hst "`n"
	idx  := idx  + 5
}

MsgBox ,0, Help, %hlp%
Return

ButtonAbout:
MsgBox ,0, CodeFlash, (c) in 2014 by AnySoft
Return

ButtonExit:
ExitApp
