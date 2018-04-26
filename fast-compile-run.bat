REM REM REM REM REM REM REM REM REM REM REM REM REM REM REM
REM                                                     REM
REM     Petit utilitaire pour compiler des petits       REM
REM   projet en C++. Script libre. Pour une question,   REM
REM     me contacter à: amayun.houery@e.rascol.net      REM
REM                                                     REM
REM      (Dernière modification: 26/04/2018 19h30)      REM
REM                                                     REM
REM REM REM REM REM REM REM REM REM REM REM REM REM REM REM

:init
echo off
title Fast compile + run
color 0f
cls
mode con cols=96 lines=98302

REM ---------- Organisation des fichiers ---------- LES NOMS DE DOSSIER DOIVENT ÊTRE CONFORMES (il DOIT y avoir un '/' à la fin)
REM Nom du fichier de sortie
set out=git-shrt.exe
REM Nom du dossier contenant les fichiers sources (répertoire d'entrée) (laisser vide pour repertoire courant)
set src=src/
REM Nom du dossier contenant l'executable compilé (répertoire de sortie) (laisser vide pour repertoire courant)
set bin=bin/

goto search


:search
	set cn=0
	echo.
	echo Preparation des fichiers...
	
	REM Vérification de l'existence du dossier contenant les fichiers sources
	if defined src (goto :check_src) else (goto :not_check_src)
	:check_src
		IF NOT EXIST %src% (
			echo Le dossier "%src%" suppose contenir les sources n'existe pas !
			goto :exit
		)
	:not_check_src
	
	for %%F in (%src%*.cpp) do (
		set /a cn+=1
		echo Fichier %%~nF selectionne
	)
	
	IF %cn% EQU 0 (
		echo Aucun fichier n'a ete trouve !
		echo Fin du programme.
		goto :exit
	) ELSE (IF %cn% EQU 1 (
		set s=
	) ELSE (IF %cn% GTR 1 (
		set s=s
	)))
	
	echo Preparation terminee: %cn% fichier%s% trouve%s%
	goto :compile


:compile
	REM Vérification du nom de dossier et création si non existant
	if defined bin (
		IF NOT EXIST %bin% mkdir %bin:~0,-1%
	)
	
	REM Vérification du nom de l'executable qui sera créé
	if defined out (
		if "%out:~-4%" NEQ ".exe" (
			echo Attention ! L'extension du fichier de sortie %out% n'est pas conforme a Windows, ce qui pourrait causer des problemes. Vous etes prevenus.
		)
	)
	
	echo.
	echo.
	echo ------ Compilation en cours...
	echo.
	
	REM ----- Compilation -----
	g++ %src%*.cpp -o %bin%%out% -Wall
	set succ=%errorlevel%
	REM -----    -----    -----
	
	echo.
	IF %succ% EQU 0 (
		echo ------ Compilation terminee !
		goto :exec
	)
	REM else
	echo ------ Une erreur est survenue lors de la compilation...
	goto :exit


:exec
	echo.
	echo.
	echo Appuyez sur une touche pour lancer l'executable...
	pause >nul
	echo Execution de %out%
	cd %bin%
	start %out%
	goto :eof


:exit
	echo.
	echo.
	echo Appuyez sur une touche pour terminer...
	pause >nul
	goto :eof
