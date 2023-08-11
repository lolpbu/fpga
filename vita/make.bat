@ECHO OFF
SETLOCAL

SET EXE="coiso.exe"
SET SRCDIR="."
SET INCDIR="include"
SET BINDIR="out"
SET EXT="cpp"
SET CC="g++"
SET OBJS="%BINDIR%/*.o"

IF "%1"=="create" GOTO :CREATE 
IF "%1"=="clear" GOTO :CLEAR
IF "%1"=="help" GOTO :HELP
GOTO :MAKE 



:HELP
ECHO make        -^> compile
ECHO make run    -^> compile ^& run
ECHO make create -^> create bin, src ^& include dirs
ECHO make help   -^> ...
GOTO :EOF



:MAKE 
REM /p = path to search
REM /m = search mask (* wildcard)
REM /s = recurse into subfolders
REM /c = command to each file found 
FORFILES /P %SRCDIR% /M *.%EXT% /S /C "CMD /C ECHO compilando arquivo @file && %CC% -I %INCDIR% -c @relpath -o %BINDIR%\\@FNAME.o"
CALL ECHO linkando arquivos em %EXE%
%CC% %OBJS% -o %EXE%
ECHO pronto :3

IF "%2"=="run" (
    CLS
    %EXE%
)

GOTO :EOF



:CREATE
MKDIR %INCDIR% %BINDIR% %SRCDIR%
GOTO :EOF



:CLEAR
DEL /Q /S *.o *.exe %BINDIR%\*



:EOF
ENDLOCAL
