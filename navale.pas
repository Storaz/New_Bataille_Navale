{PROGRAMME Navale

 //BUT: Jouer au jeu "La bataille navalle"
 //ENTREE: Coordonnées des différents position
 //SORTIE: Indique si un bateau à ete touche ou non ainsi que le nombre de bateaux restants et si un joueur à gagne

//CONSTANTES
CONST
	NBBATEAU<-5:ENTIER
	MAXCASE<-5:ENTIER
	MINLIGNE<-1:ENTIER
	MAXLIGNE<-50:ENTIER
	MINCOLONNE<-1:ENTIER
	MAXCOLONNE<-50:ENTIER

//Type enregistrement

Type Case=enregistrement 
	
	l:ENTIER
	c:ENTIER

FINENREGISTREMENT

Type Bateau=enregistrement
	
	nCase:Tableau[1..MAXCASE]de Case

FINENREGISTREMENT

Type Flotte=enregistrement

	nBateau:Tableau[1..NBBATEAU]de Bateau

FINENREGISTREMENT

 //Type

Type positionBateau=(enLigne,enColonne,enDiag)

Type etatBateau=(toucher,couler)

Type etatFlottte=(aFlot,aSombrer)

Type etatJoueur=(gagne,perd)

  //Fonctions & Procedures

Procedure createCase(l,c:ENTIER;VAR nCase:case) //Creation du plateau

	DEBUT
		nCase.l<-l
		nCase.c<-c	
	FIN

Fonction cmpCase(nCase,tCase:case):BOOLEEN //Vérifie si la case se situe dans le plateau

	DEBUT
		SI((nCase.col=tCase.col)ET(nCase.ligne=tCase.ligne))ALORS
			cmpCase<-VRAI
		SINON
			cmpCase<-FAUX
		FINSI
	FIN

Fonction createBateau(nCase:case;taille:ENTIER):Bateau //Permet de creer les bateaux
	
	VAR
		res:Bateau
		posBateau:positionBateau
		i,pos:ENTIER

	DEBUT
		pos<-aleatoire[1..3]
		posBateau<-positionBateau(pos)
		POUR i de 1 A MAXCASE pas 1 FAIRE
			SI(i<taille)ALORS 
				DEBUT
					res.nCase[i].ligne<-nCase.ligne
					res.nCase[i].col<-nCase.col
				FIN
			SINON
				DEBUT
					res.nCase[i].ligne<-0
					res.nCase[i].col<-0
				FIN
			FINSI
			SI (posBateau=enLigne)ALORS
				nCase.col<-nCase.col+1
			SINON SI (posBateau=enColonne)ALORS
				nCase.ligne<-nCase.ligne+1
			SINON SI (posBateau=enDiag)ALORS
				DEBUT
					nCase.ligne:=nCase.ligne+1
					nCase.col:=nCase.col+1
				FIN
			FINSI
		FINPOUR
		createBateau<-res
FIN

Fonction ctrlCase(nBat:Bateau;nCase:case):BOOLEEN //Verifie si la case appartient à un bateau

	VAR
		i:ENTIER
		valtest:BOOLEEN
	DEBUT
		valtest<-FAUX
		POUR i DE 1 A MAXCASE pas 1 FAIRE
			DEBUT
				SI(cmpCase(nBat.nCase[i],nCase))ALORS
					valtest<-VRAI
				FINSI
		FINPOUR
		valtest<-FAUX
FIN

Fonction ctrlFlotte(nFlotte:Flotte;nCase:case):BOOLEEN //Verifie si la case appartient à une flotte de bateaux

	VAR
		i:ENTIER
		valtest:BOOLEEN

	DEBUT
		valtest<-FAUX
		POUR i DE 1 A NBBATEAU pas de 1 FAIRE
			DEBUT
				SI(ctrlCase(nFlotte.nBateau[i],nCase))ALORS
					valtest<-VRAI
				FINSI
			FIN
		FINPOUR
		ctrlFlotte<-valtest
	FIN 

Fonction initFlotte(positionLigneJ1,positionLigneJ2,positionColonneJ1,positionColonneJ2,tailleBateauJ1,tailleBateauJ2:ENTIER):Flotte //Initialise les flottes de chaque joueur avec des valeurs aleatoire

	VAR
		i:ENTIER

	DEBUT
		aleatoire 
		POUR i de 1 A NBBATEAU pas de 1 FAIRE
			DEBUT
				tailleBateauJ1<-aleatoire(MAXCASE)+1
				positionLigneJ1<-aleatoire(MAXLIGNE)+1
				positionColonneJ1<-aleatoire(MAXCOLONNE)+1
			FIN
		FINPOUR

		POUR i de 1 A NBBATEAU pas de 1 FAIRE
			DEBUT
				tailleBateauJ2<-aleatoire(MAXCASE)+1
				positionLigneJ2<-aleatoire(MAXLIGNE)+1
				positionColonneJ2<-aleatoire(MAXCOLONNE)+1
			FIN
		FINPOUR
	FIN

Fonction attaque(test:BOOLEAN;nBat:Bateau;nCase:cases):BOOLEAN;  //Vérifie si l'attaque a réussie ou non

	VAR
		x,y,i:ENTIER
		bateauRestantJ1,bateauRestantJ2:ENTIER

	DEBUT
	testflotte1<-FAUX
		ECRIRE"Joueur 1"
		ECRIRE "Veuillez entrer vos coordonnées en x"
		LIRE x
		ECRIRE "Veuillez entrer vos coordonnées en y"
		LIRE y
		ECRIRE"Resultat"
		SI(cmpCase(nBat[j].nCase[i]))=x ET (cmpCase(nBat[j].nCase[i]))=y ALORS
			test<-VRAI
			bateauRestantJ1:=NBBATEAU-1
			ECRIRE "Un bateau a ete touche"
		SINON ECRIRE"Aucun bateau n'a ete touché"
		testflotte1<-FAUX

	testflotte2<-FAUX
		ECRIRE"Joueur 2"
		ECRIRE "Veuillez entrer vos coordonnées en x"
		LIRE x
		ECRIRE "Veuillez entrer vos coordonnées en y"
		LIRE y
		ECRIRE"Resultat"
		SI(cmpCase(nBat[j].nCase[i]))=x ET (cmpCase(nBat[j].nCase[i]))=y ALORS
			test<-VRAI
			bateauRestantJ2:=NBBATEAU-1
			ECRIRE "Un bateau a ete touche"
		SINON ECRIRE"Aucun bateau n'a ete touché"
		testflotte2<-FAUX
	FIN


Fonction etatFlotte(etatBateau1,etatBateau2:etatBateau):BOOLEEN //Indique l'etat de la flotte
	
	VAR

	DEBUT
	etatBateau1<-couler
	SI bateauRestantJ1<>0 ALORS
		ECRIRE "Il vous reste",bateauRestant,"de bateau(x)restant(s)"
	SINON
		etatBateau1<-toucher
		ECRIRE "Vous avez toucher un bateau,il reste",bateauRestant,de bateau(x)restant(s)"

	etatBateau2<-couler
	SI bateauRestantJ2<>0 ALORS
		ECRIRE "Il vous reste",bateauRestant,"de bateau(x)restant(s)"
	SINON
		etatBateau1<-toucher
		ECRIRE "Vous avez toucher un bateau,il reste",bateauRestant,de bateau(x)restant(s)"
	FIN





Fonction etatJoueur(etatFlotte1,etatFlotte2:etatFlotte):BOOLEEN //Indique l'etat du joueur

	VAR

	DEBUT
	etatFlotte1<-gagne
		SI bateauRestantJ1=0 ALORS
			etatFlotte1<-perd
			ECRIRE "Vous avez perdu Joueur1"
			ECRIRE "Vous avez gagne Joueur2"
		SINON SI bateauRestantJ2=0 ALORS
			etatFlotte2<-perd
			ECRIRE "Vous avez gagne Joueur1"
			ECRIRE "Vous avez perdu Joueur2"
		FINSI
	FIN

DEBUT

createCase
cmpCase
createBateau
ctrlCase
ctrlFlotte
initFlotte
attaque
etatFlotte
etatJoueur

FIN.
	
}

program Navale;

uses crt;

 //BUT: Jouer au jeu "La bataille navalle"
 //ENTREE: Coordonnées des différents position
 //SORTIE: Indique si un bateau à ete touche ou non ainsi que le nombre de bateaux restants et si un joueur à gagne

//CONSTANTES
CONST
	NBBATEAU=5;
	MAXCASE=5;
	MINLIGNE=1;
	MAXLIGNE=50;
	MINCOLONNE=1;
	MAXCOLONNE=50;

//Type enregistrement

Type Cases=record
	
	l:INTEGER;
	c:INTEGER;

END;

Type Bateau=record
	
	nCase:Array[1..MAXCASE]of Cases;

END;

Type Flotte=record

	nBateau:Array[1..NBBATEAU]of Bateau;

END;

 //Type

Type positionBateau=(enLigne,enColonne,enDiag);

Type etatBateau=(toucher,couler);

Type etatFlottte=(aFlot,aSombrer);

Type etatJoueur=(gagne,perd);

  //Fonctions & Procedures

Procedure createCase(l,c:INTEGER;VAR nCase:cases); //Creation du plateau

	BEGIN
		nCase.l:=l;
		nCase.c:=c;
	END;

Function cmpCase(nCase,tCase:cases):BOOLEAN; //Vérifie si la case se situe dans le plateau

	BEGIN
		IF((nCase.c=tCase.c)AND(nCase.l=tCase.l))THEN
			BEGIN
			cmpCase:=TRUE;
			END
		ELSE
			BEGIN
			cmpCase:=FALSE;

		END;
	END;

Function createBateau(nCase:cases;taille:INTEGER):Bateau; //Permet de creer les bateaux
	
	VAR
		res:Bateau;
		posBateau:positionBateau;
		i,pos:INTEGER;

	BEGIN
		randomize;
		pos:=Random(3)+1;
		posBateau:=positionBateau(pos);
		FOR i:=1 TO MAXCASE DO
        	begin
			IF(i<taille)THEN
				BEGIN
					res.nCase[i].l:=nCase.l;
					res.nCase[i].c:=nCase.c;
				END
			ELSE
				BEGIN
					res.nCase[i].l:=0;
					res.nCase[i].c:=0;
				END;
			IF (posBateau=enLigne)THEN
				BEGIN
				nCase.c:=nCase.c+1;
				END
			ELSE IF (posBateau=enColonne)THEN
				BEGIN
				nCase.l:=nCase.l+1;
				END
			ELSE IF (posBateau=enDiag)THEN
				BEGIN
					nCase.l:=nCase.l+1;
					nCase.c:=nCase.c+1;
				END;
			
	END;
	createBateau:=res;
END;

Function ctrlCase(nBat:Bateau;nCase:cases):BOOLEAN; //Verifie si la case appartient à un bateau

	VAR
		i:INTEGER;
		valtest:BOOLEAN;
	BEGIN
		valtest:=FALSE;
		FOR i:=1 TO MAXCASE DO
			BEGIN
				IF(cmpCase(nBat.nCase[i],nCase))THEN
					valtest:=TRUE;
			END;
	valtest:=FALSE;
END;

Function ctrlFlotte(nFlotte:Flotte;nCase:cases):BOOLEAN; //Verifie si la case appartient à une flotte de bateaux

	VAR
		i:INTEGER;
		valtest:BOOLEAN;

	BEGIN
		valtest:=FALSE;
		FOR i:=1 TO NBBATEAU DO
			BEGIN
				IF(ctrlCase(nFlotte.nBateau[i],nCase))THEN
					valtest:=FALSE;
		END;
		ctrlFlotte:=valtest;
	END;

Function initFlotte(positionLigneJ1,positionLigneJ2,positionColonneJ1,positionColonneJ2,tailleBateauJ1,tailleBateauJ2:INTEGER):Flotte; //Initialise les flottes de chaque joueur avec des valeurs aleatoire

	VAR
		i:INTEGER;

	BEGIN
		randomize;
		FOR i:=1 TO NBBATEAU DO
			BEGIN
				tailleBateauJ1:=random(MAXCASE)+1;
				positionLigneJ1:=random(MAXLIGNE)+1;
				positionColonneJ1:=random(MAXCOLONNE)+1;
			
		END;
		FOR i:=1 TO NBBATEAU DO
			BEGIN
				tailleBateauJ2:=random(MAXCASE)+1;
				positionLigneJ2:=random(MAXLIGNE)+1;
				positionColonneJ2:=random(MAXCOLONNE)+1;
			END;
	END;

Function attaque(test:BOOLEAN;nBat:Bateau;nCase:cases):BOOLEAN; //Verifie si l'attaque a réussie ou non

	VAR
		x,y,i,j:INTEGER;
		bateauRestantJ1,bateauRestantJ2:INTEGER;

	BEGIN
	test:=FALSE;
		Writeln('Joueur 1');
		Writeln('Veuillez entrer vos coordonnées en x');
		Readln(x);
		Writeln('Veuillez entrer vos coordonnées en y');
		Readln(y);
		Writeln('Resultat');
		IF(cmpCase(nBat[j].nCase[i]))=x AND(cmpCase(nBat[j].nCase[i]))=y THEN
			BEGIN
			test:=TRUE;
			bateauRestantJ1:=NBBATEAU-1;
			Writeln('Un bateau a ete touche');
			END;
		ELSE IF Writeln('Aucun bateau n''a ete touché');
		testflotte1:=FALSE;

	testf:=FALSE
		Writeln('Joueur 2');
		Writeln('Veuillez entrer vos coordonnées en x');
		Readln(x);
		Writeln('Veuillez entrer vos coordonnées en y');
		Readln(y);
		Writeln('Resultat');
		IF(cmpCase(nBat[j].nCase[i]))=x AND(cmpCase(nBat[j].nCase[i]))=y THEN
			BEGIN
			test:=TRUE;
			bateauRestantJ2:=NBBATEAU-1;
			Writeln('Un bateau a ete touche');
			END;
		ELSE Writeln('Aucun bateau n''a ete touché');
		testflotte2:=FALSE;
	END;


Function etatFlotte(etatBateau1,etatBateau2:etatBateau):Flotte //Indique l'etat de la flotte
	

	BEGIN
	etatBateau1:=couler;
	IF bateauRestantJ1<>0 THEN
		BEGIN
		Writeln('Il vous reste',bateauRestant,'de bateau(x)restant(s)');
		END
	ELSE
		etatBateau1:=toucher;
		Writeln('Vous avez toucher un bateau,il reste',bateauRestant,'de bateau(x)restant(s)');

	etatBateau2:=couler;
	IF bateauRestantJ2<>0 THEN
		BEGIN
		Writeln('Il vous reste',bateauRestant,'de bateau(x)restant(s)');
		END;
	ELSE
		etatBateau1:=toucher;
		Writeln('Vous avez toucher un bateau,il reste,'bateauRestant',de bateau(x)restant(s)');
	END;

Function etatJoueur(etatFlotte1,etatFlotte2:etatFlotte):BOOLEAN; //Indique l'etat du joueur

	BEGIN
	etatFlotte1:=gagne;
		IF bateauRestantJ1=0 THEN
			BEGIN
			etatFlotte1:=perd;
			Writeln ('Vous avez perdu Joueur1');
			Writeln ('Vous avez gagne Joueur2');
			END;
		ELSE IF bateauRestantJ2=0 THEN
			BEGIN
			etatFlotte2:=perd
			Writeln ('Vous avez gagne Joueur1');
			Writeln ('Vous avez perdu Joueur2');
			END;
		END;
	END;

BEGIN

createCase;
cmpCase;
createBateau;
ctrlCase;
ctrlFlotte;
initFlotte;
attaque;
etatFlotte;
etatJoueur;

END;.
