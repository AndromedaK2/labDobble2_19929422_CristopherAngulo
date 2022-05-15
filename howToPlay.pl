% Requerimiento 1 
random(2,Seed), cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,Seed,CardsSet).
random(3,Seed), cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet).
random(1,Seed), cardsSet([1,2,3,4,5,6,7],3,5,2,CardsSet).

% Requerimiento 2
cardsSetIsDobble([[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]]).
random(2,Seed),cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetIsDobble(CardsSet).
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet), cardsSetIsDobble(CardsSet).

% Requerimiento 3
random(2,Seed),cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,1,Card)
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,2,Card)
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,3,Card)

% Requerimiento 4
random(2,Seed),cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,1,Card),cardsSetFindTotalCards(Card,Total).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,2,Card),cardsSetFindTotalCards(Card,Total).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,3,Card),cardsSetFindTotalCards(Card,Total).

% Requerimiento 5 
random(2,Seed),cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),cardsSetMissingCards(CardsSet,Cards)
cardsSet([1,2,3,4,5,6,7],3,6,2,CardsSet),cardsSetMissingCards(CardsSet,Cards).
cardsSet([1,2,3,4,5,6,7],3,4,2,CardsSet),cardsSetMissingCards(CardsSet,Cards).

% Requerimiento 6
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetToString(CardsSet,X).
cardsSet([1,2,3,4,5,6,7],3,6,2,CardsSet),cardsSetToString(CardsSet,Y).
cardsSet([1,2,3,4,5,6,7],3,4,2,CardsSet),cardsSetToString(CardsSet,Z).
cardsSet(['Pedro',2,estrella,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),cardsSetToString(CardsSet,W).
 
% Requerimiento 7 
 cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
 dobbleGame(4,CardsSet,"stack",Seed,Game).
 
 cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),
 dobbleGame(2,CardsSet,"stack",Seed,Game1).

 cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,12,2,CardsSet),
 dobbleGame(3,CardsSet,"stack",Seed,Game2).

% Requerimiento 8 

cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(2,CardsSet,"stack",Seed,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2).

cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(3,CardsSet,"stack",Seed,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),dobbleGameRegister("Alexander",Game2,Game3).

cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",Seed,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),dobbleGameRegister("Alexander",Game2,Game3).


%Requerimiento 9
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),dobbleGameRegister("Alexander",Game2,Game3),
dobbleGameWhoseTurnIsIt(Game3,Username).

cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(3,CardsSet,"stack",Seed,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGameWhoseTurnIsIt(Game2,Username).


cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(2,CardsSet,"stack",Seed,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGameWhoseTurnIsIt(Game2,Username).


%Requerimiento 10

%Iniciar Juego
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGamePlay(Game2,null,NewDobbleGame).


%Spotit
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGamePlay(Game2,null,Game3),
dobbleGamePlay(Game3,[spotit,"Rene",2],X).


% Pasar
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGamePlay(Game2,null,Game3),
dobbleGamePlay(Game3,[pass],X)



%Finalizar 

cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGamePlay(Game2,null,Game3),
dobbleGamePlay(Game3,[finish],X).

%Requeriminto 11 y 12


cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),
dobbleGamePlay(Game2,null,Game3),
dobbleGamePlay(Game3,[spotit,"Rene",2],X),
dobbleGameStatus(X,State),
dobbleGameScore(X,"Cristopher",Score),
dobbleGameScore(X,"Rene",Score1).



%Requerimiento 13
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Rene",Game,Game1),dobbleGameRegister("Cristopher",Game1,Game2),
dobbleGamePlay(Game2,null,Game3),
dobbleGamePlay(Game3,[spotit,"Cristopher",1],Game4),
dobbleGamePlay(Game4,null,Game5),
dobbleGameToString(Game5,Y),
write(Y).

