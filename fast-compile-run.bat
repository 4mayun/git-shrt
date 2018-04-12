REM REM REM REM REM REM REM REM REM REM REM REM REM REM REM
REM                                                     REM
REM     Petit utilitaire pour compiler des petits       REM
REM   projet en C++. Script libre. Pour une question,   REM
REM     me contacter à: amayun.houery@e.rascol.net      REM
REM                                                     REM
REM REM REM REM REM REM REM REM REM REM REM REM REM REM REM

:init
@echo off
title Fast compile + run
color 0f
set out=git-shrt.exe
cls
mode con cols=96 lines=98302
goto search

:search
	set cn=0
	echo.
	echo Preparation des fichiers
	for %%F in (src/*.cpp) do (
		set /a cn+=1
		echo Fichier %%~nF selectionne
	)
	IF %cn% EQU 0 (
		echo Aucun fichier n'a ete trouve !
		echo Fin du programme.
		pause >nul
		goto :eof
	) ELSE (IF %cn% EQU 1 (
		set s=
	) ELSE (IF %cn% GTR 1 (
		set s=s
	)))
	echo Preparation terminee: %cn% fichier%s% trouve%s%
	goto :compile

:compile
	echo.
	echo.
	echo ------ Compilation en cours...
	echo.
	REM ----- Compilation -----
	g++ src/*.cpp -o bin/%out% -Wall
	REM -----    -----    -----
	echo.
	echo ------ Compilation terminee !
	goto :exec

:exec
	echo.
	echo.
	echo Appuyez sur une touche pour lancer l'executable...
	pause >nul
	echo Execution de %out%
	start bin/%out%
	goto :eof
