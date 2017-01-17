#SingleInstance force

::dr::--dry-run
::gb::git branch
::gc::git commit -am ""{Left}
	
::glog::
	SendInput git log{Enter}
	Return