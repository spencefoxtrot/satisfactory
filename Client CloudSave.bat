@echo off
color 0A
echo Version 1.1
echo Derniere mise a jour du script 10/03/2020 par Sf!
echo L'execution du script "client" implique un dossier de partage deja mis en place sur le poste client, avec les sauvegardes dedans
echo.

echo Ce script fonctionne avec un dossier de partage de l'application OneDrive
echo.

pause
cls

REM Auteur
echo Cette serie de sripts a ete cree par Sf! le 29 Fevrier 2020 
echo.
echo.

REM Informations
echo Avant d'aller plus loin, sachez que ce script a pour but de "montrer" au jeu des sauvegardes
echo qui se trouvent ailleurs que dans le dossier d'origine du jeu,
echo de facon invisible pour le jeu (grace a un lien symbolique)
echo.

echo 	- Un lien symbolique (commande mklink), est une sorte de reccourci,
echo 	  mais faisant "croire" au systeme que ce raccourci est un fichier original,
echo 	  alors qu'il se trouve ailleurs.

echo.

echo Les developpeurs ont annonce qu'ils se pencheraient sur une solution,
echo directement geree dans le jeu (serveur dedie typiquement).
echo.
echo Il se peut donc que ce script devienne inutile rapidement.
echo.

pause
cls

color 0C
echo En continuant, vous comprennez et acceptez que les modifications apportees,
echo peuvent ne plus fonctionner du jour au lendemain,
echo avec un risque de perte de vos sauvegardes.
echo.

echo Bien que le but soit de vous permettre plus de flexibilite,
echo vous vous engagez a supporter toutes les responsabilites de cette modification!
echo.

pause
cls

echo Pour fonctionner, ce script DOIT etre executé en tant qu'administrateur via un clic droit
echo Ce qui implique que vous allez lui donner tout les droits pour detruire votre poste si c'etait son but
echo.
echo Soyez TOUJOURS vigilants quant a la provenance des scripts, et a qui vous accorderez votre confiance,
echo car ils pourraient etre malicieux....
echo.

pause
cls

color 0D
echo La finalite :
echo Nous voulons deplacer cerains fichiers pour pouvoir les mettre dans un dossier en cloud qui sera partage entre plusieurs amis/joueurs,
echo de facon a toujours pouvoir jouer sans dependre d'un hote principal qui serait absent,
echo et en automatisant le fonctionnement de façon transparente!
echo.
echo Pour mieux comprendre, rdv sur le discord (Soit dans la partie dedie, soit avec le tag @Sf!)
echo.
echo Vous DEVEZ d'abord configurer votre logiciel de sauvegarde en cloud AVANT d'utiliser ce script (ou alors, vous savez ce que vous faites)
echo.

echo Nous utiliseront OneDrive (De Microsoft). Vous avez le droit a 5 Go si vous etes un nouvel utilisateur.
echo Vous pouvez creer un compte Microsoft en utilisant votre adresse mail deja existante (gmail, operateur grand public, etc...)
echo.
echo Vos amis/joueurs doivent l'avoir egalement, et avec leurs propres comptes,
echo ou un logiciel qui permet l'interconnexion entre deux editeurs differents (Mais vous savez ce que vous faites)
echo Mais c'est plus simple si vous avez tous le meme...
echo.

echo Si vous en creez un, vous pouvez, si vous le voulez, passer par mon lien de parrainage :
echo "https://onedrive.live.com?invref=1debf2becf7b1e9d&invscr=90"
echo (Pas d'argent gagne, juste de l'espace en plus, et 0,5 Go par neveu, pour lui et pour moi, Sf!)
echo.
pause
cls

color 0A
echo Pre-requis :
echo Vous avez un logiciel cloud qui fonctionne sur le poste ou vous utilisez ce script!
echo Ce script est prevu pour WINDOWS 10 64 bits, et n'a pas ete teste sur d'autres versions.
echo Il DEVRAIT (aucune garantie) etre compatible avec les versions 32 bits et jusqu'a windows 7
echo.
pause
cls

color 03
REM Identification du dossier de l'utilisateur
echo 1) Nous allons d'abord chercher le nom de votre dossier de sauvegarde (different pour chaque utilisateur)
echo    Il se trouve dans : "C:\Users\%username%\AppData\Local\FactoryGame\Saved\SaveGames\"
echo    Il doit y avoir 2 dossiers :
echo		- common
echo		- et un autre bizarre
echo.

	REM On liste le contenu du dossier "SaveGames"
echo Liste des dossiers du repertoire de sauvegarde :

DIR "C:\Users\%username%\AppData\Local\FactoryGame\Saved\SaveGames"

echo.
echo.
echo Relevez le nom du dossier "bizarre" avec des chiffres et des lettres
echo.
echo S'il y a plus de deux dossiers, arretez vous la, le script doit etre mis a jour.
echo Pour quitter, fermez la fenetre avec la croix en haut a droite
echo.
pause
echo.
echo.

REM Creation des variables
echo 2) Nous allons maintenant entrer les parametres des fichiers qui seront partages dans un cloud
echo.
echo Nous avons besoin du nom du dossier
SET /P FolderName=Copiez/Collez (ou recopiez) le nom de votre dossier PERSO (le dossier bizarre) ici (en respectant les majuscules) :
echo.
echo A present, nous avons besoin du nom du dossier de sauvegarde
SET /P CloudTarget=Tapez ou Collez le nom (par exemple "taratata" - sans les guillements -)  du dossier de PARTAGE ici :
echo.
SET /P WorldName=Entrez le nom de votre monde ici, SANS le .sav a la fin, juste le nom, en respectant les espaces :
echo.
echo.

REM Copie de securite du dossier d'origine
	REM Sur le bureau (j'utilise le bureau public au cas ou l'utilisateur n'aurait pas son \desktop dans le chemin par defaut, comme chez moi)
    REM Cela implique les droits d'admin necessaire, et egalement que l'utilisateur doive le deplacer... car tous les utilisateurs du poste y auront acces

    REM on cree le dossier et le sous-dossier sur le bureau public
mkdir "C:\Users\Public\Desktop\Sauvegardes Satisfactory"
mkdir "C:\Users\Public\Desktop\Sauvegardes Satisfactory\SaveGames"

    REM on fait une copie du dossier de sauvegarde vers un dossier du meme nom.
robocopy /e "C:\Users\%username%\AppData\Local\FactoryGame\Saved\SaveGames\%FolderName%" "C:\Users\Public\Desktop\Sauvegardes Satisfactory\SaveGames\%FolderName%"

echo Par mesure de securite, une copie du dossier de sauvegarde a ete faite
echo Elle est disponible sur votre bureau!
echo.
echo Attention, les autres utilisateurs du poste ont aussi acces au dossier du bureau et peuvent le supprimer!
echo Pensez a le deplacer ailleurs, a l'abris!
echo.
echo Si une erreur s'est produite, faites une prise d'ecran et arretez le script en fermant par la croix en haut a droite de cette fenetre, puis demandez de l'aide
pause
cls


color 04
echo 3) Mise en place
echo.
echo Attention, n'allez pas plus loin si quelque chose s'est mal passe, et demandez de l'aide!
echo.
echo Pour arreter le script, fermez la fenetre via la croix en haut a droite!
echo.
echo. 
echo Jusqu'ici, nous n'avons fait qu'une sauvegarde du dossier de jeu!
echo.
echo.
echo !!! Appuyez quand vous etes pret !!!
echo.
pause
cls

color 03
REM Création des liens
mklink "C:\Users\Admin\AppData\Local\FactoryGame\Saved\SaveGames\%FolderName%\%WorldName%.sav" "%OneDrive%\%WorldName%.sav"
mklink "C:\Users\Admin\AppData\Local\FactoryGame\Saved\SaveGames\%FolderName%\%WorldName%_autosave_0.sav" "%OneDrive%\%WorldName%_autosave_0.sav"
mklink "C:\Users\Admin\AppData\Local\FactoryGame\Saved\SaveGames\%FolderName%\%WorldName%_autosave_1.sav" "%OneDrive%\%WorldName%_autosave_1.sav"
mklink "C:\Users\Admin\AppData\Local\FactoryGame\Saved\SaveGames\%FolderName%\%WorldName%_autosave_2.sav" "%OneDrive%\%WorldName%_autosave_2.sav"

echo Verifiez s'il y a une erreur : Si oui, faites une prise d'ecran pour avoir de l'aide
pause
cls

echo Si vous etes un ami/joueur qui rejoint un monde existant, les manipulations s'arretent ici!
echo.
echo Appuyez sur une touche pour fermer!
echo.
pause
