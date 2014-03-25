echo off
cls
set i=0
set count=200

:loop

curl "http://url?chunk-index=%i%" > t%i%.html
ruby !md5.rb t%i%.html

set /a i= %i% + 1
if %i%==%count% goto close
goto loop

:close
exit
