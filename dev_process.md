# Dev process

 - [ ] Trouver un nom pour le fichier texte dans lequel sera stocké les raccourcis
 - [ ] Déterminer si les options seront définies dans ce même fichier texte ou dans un fichier type settings.ini
 - [ ] Apprendre comment manipuler précisément les entrées sorties de fichier en C++

## Objectifs

 - Pouvoir être accessible depuis la console
    - La base: pouvoir faire ``git-shrt --help``
    -
 - Indiquer les erreurs de syntaxe dans le fichier (si il y a un espace, si il manque quelque chose, etc)
 - Pouvoir créer (ou mettre à jour, mais c'est la même commande) des raccourcis depuis la console (donc faire les options qui vont avec)
 - Avoir une bonne doc de type: ``git-shrt [--version] [--help] [<shortcut> (-e | --add)]`` (ouais bon c'est hyper moche et ça veut rien dire mais l'idée est de s'inspirer de la doc de git)

## Possibilités

Balancer les trucs qu'on aimerait pouvoir faire avec:

 - ``git-shrt <shortcut>``: Ouvre git-bash dans le répertoire associé au raccourci

 - ``git-shrt <shortcut> [-e | --explorer]``: Ouvre le répertoire associé au raccourci avec l'explorateur de fichiers

 - ``git-shrt <shortcut> [-s | --set=] "<path>"``: Associe le raccourci au chemin spécifié

 - ``git-shrt <shortcut> [-rm | --remove]``: Supprime le raccourci et son chemin associé

 - ``git-shrt --help``: Affiche l'aide

 - ``git-shrt --version``: Affiche la version et les crédits (oe c'est débile mais ya des vrais objectifs dans la vie)
