#SingleInstance force

::dr::--dry-run
::gb::git branch
::gc::git commit
:o:gcam::git commit -am ""{Left}

::glog::
	SendInput git log{Enter}
	Return
