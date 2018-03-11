#SingleInstance force

::dr::--dry-run
::gb::git branch

::gc::git commit -m ""{Left 6}
:o:gcam::git commit -am ""{Left}

::glog::
	SendInput git log{Enter}
	Return
