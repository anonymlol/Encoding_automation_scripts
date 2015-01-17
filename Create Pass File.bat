@echo off

REM Press Win+R, type "shell:sendto" and put it there. Now you can just right-click and select "Create Pass File"
REM Make sure your xvid_encraw path is correct. You can find xvid_encraw in your megui folder or in your xvid folder (download and install xvid from xvid.org)

if not exist pass.avs @echo DirectShowSource(%1) > pass.avs
xvid_encraw -i pass.avs -type 2 -pass1 passfile.pass -full1pass -progress 21

REM If you don't want to keep the pass.avs after the passfile has been created, uncomment the line below
REM if exist pass.avs del pass.avs

REM pause