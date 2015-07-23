
CodeFlash 
---------

CodeFlash provides code completion for for loops, if statements and many more. Further: quick and simple installation. One program for all editors.

Just type in the command with paramters and hit the hotkey (capslock or shift + space). CodeFlash then completes the statement. Here a few examples. 

C++:

f 10 + capslock -> 

for( int i=0 ; i<10 ; ++i)
{
	
}

All code templates can be modified in the cmd folder. 

cmd_cpp.txt -> c++ templates e.g.

Syntax:

<shortcut> <parameter count> <cursor X> <cursor Y>
<replacement> , where $l$ is the indentation, $n$ is linefeed, $1$ parameter 1 .. $99$ parameter 99

Example:

fi 2 1 -1
$l$for( int i=$1$ ; i<$2$ ; ++i)$n$$l${$n$$l$	$n$$l$}

shortcut : fi
parameters : 2
move cursor in x after replacement: 1
move cursor in y after replacement: -1
replacement explained: 
<indent>for( int i=<param 1> ; i<<param 2> ; ++i)
<linefeed><indent>{<linefeed><indent>	<linefeed><indent>}
