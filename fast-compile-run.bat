REM REM REM REM REM REM REM REM REM REM REM REM REM REM REM
REM                                                     REM
REM     Petit utilitaire pour compiler des petits       REM
REM   projet en C++. Script libre. Pour une question,   REM
REM     me contacter à: amayun.houery@e.rascol.net      REM
REM                                                     REM
REM      (Dernière mise à jour: 29/04/2018 01h30)       REM
REM                                                     REM
REM REM REM REM REM REM REM REM REM REM REM REM REM REM REM

:init
echo off
title Fast compile + run
color 0f
cls
mode con cols=232 lines=98302

REM ---------- PARAMETRES DU COMPILATEUR (voir https://gcc.gnu.org/onlinedocs/gcc-6.4.0/gcc/Option-Summary.html#Option-Summary )
set param=-Wall -Wextra -Wpedantic -Og

REM ---------- Organisation des dossiers et fichiers ---------- LES NOMS DE DOSSIER DOIVENT ÊTRE CONFORMES (il DOIT y avoir un '/' à la fin, SAUF si il s'agit du répertoire courant)

REM Nom du dossier contenant les fichiers sources (répertoire d'entrée) (laisser vide pour repertoire courant)
set src=src/

REM Nom du dossier contenant les fichiers temporaires (laisser vide pour repertoire courant)
set obj=obj/

REM Nom du dossier contenant l'executable compilé (répertoire de sortie) (laisser vide pour repertoire courant)
set bin=bin/

REM Extension des fichiers sources (peut être: .cc .cp .cxx .cpp .CPP .c++ .C )
set ext=.cpp
REM Nom du fichier de sortie
set out=git-shrt.exe

goto search


:search
	set cn=0
	echo. & echo.
	echo ----------------------------------------------------------------------------------------------------
	echo Preparation des dossiers et des fichiers...
	
	REM Vérification de l'existence du dossier contenant les fichiers sources
	if defined src (goto :check_src) else (goto :not_check_src)
	echo.
	echo Verification de l'existence du dossier qui contient les fichiers sources (%src%)
	:check_src
		IF NOT EXIST %src% (
			echo Le dossier "%src%" suppose contenir les sources n'existe pas !
			goto :exit
		)
	:not_check_src
	
	REM Recherche et comptage des fichiers
	echo.
	echo Recherche et comptage des fichiers sources:
	for /r "%cd%\%src%" %%F in (*%ext%) do (
		set /a cn+=1
		echo Fichier  %%~nF  selectionne
	)
	
	IF %cn% EQU 0 (
		echo Aucun fichier n'a ete trouve !
		echo Fin du programme.
		goto :exit
	) ELSE (IF %cn% EQU 1 (
		set s=
		set av=a
	) ELSE (IF %cn% GTR 1 (
		set s=s
		set av=ont
	)))
	
	echo Fin de la recherche des sources: %cn% fichier%s% %av% ete trouve%s%
	
	REM Verification de l'existence du dossier intermediaire et création si non existant
	if defined obj (
		echo.
		echo Verification de l'existence du dossier intermediaire...
		IF NOT EXIST %obj% (
			echo Ce dossier n'existe pas: creation du dossier...
			mkdir %obj:~0,-1%
		)
	)
	
	REM Verification de l'existence du dossier de sortie et création si non existant
	if defined bin (
		echo.
		echo Verification de l'existence du dossier de sortie...
		IF NOT EXIST %bin% (
			echo Ce dossier n'existe pas: creation du dossier...
			mkdir %bin:~0,-1%
		)
	)
	
	REM Vérification du nom de l'executable qui sera créé
	if defined out (
		if "%out:~-4%" NEQ ".exe" (
			echo Attention ! L'extension du fichier de sortie %out% n'est pas conforme a Windows, ce qui pourrait causer des problemes. Vous etes prevenus.
		)
	)
	
	echo.
	echo Fin de la verification des fichiers et des dossiers.
	echo ----------------------------------------------------------------------------------------------------
	echo.
	
	goto :compile


:compile
	echo.
	echo ----------------------------------------------------------------------------------------------------
	echo Compilation des fichiers %ext% un par un
	echo.
	
	for /R "%cd%\%src%" %%F in (*%ext%) do (
		echo ------ Compilation du fichier %%~nxF
		
		REM ----- Compilation -----
		g++ %%~fF -c -o %obj%%%~nF.o %param%
		REM -----    -----    -----
		
		IF ERRORLEVEL 1 (
			echo ------ Une erreur est survenue lors de la compilation
			echo        Annulation de la procedure de compilation.
			goto :exit
		)
		
		IF ERRORLEVEL 0 echo ------ Compilation terminee
		
		echo. & REM ne pas effacer ce commentaire
	)
	
	echo ----------------------------------------------------------------------------------------------------
	echo.
	
	goto :link
	

:link
	echo.
	echo ----------------------------------------------------------------------------------------------------
	echo Linkage des fichiers objets compiles precedemment
	echo.
	echo ------ Linkage en cours...
	
	REM ------ Linkage ------
	g++ %obj%*.o -o %bin%%out%
	REM ------         ------
	
	IF %errorlevel% EQU 0 (
		echo ------ Linkage termine !
		echo.
		echo Fin de la procedure de linkage.
		echo ----------------------------------------------------------------------------------------------------
		goto :exec
	) else (
		echo ------ Une erreur est survenue lors du linkage...
		goto :exit
	)


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
