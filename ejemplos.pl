% Requerimiento 1 
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet).
cardsSet([1,2,3,4,5,6,7],3,5,2,CardsSet).

% Requerimiento 2
cardsSetIsDobble([[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]]).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetIsDobble(CardsSet).
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet), cardsSetIsDobble(CardsSet).

% Requerimiento 3
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,1,Card)
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,2,Card)
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,3,Card)

% Requerimiento 4
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,1,Card),cardsSetFindTotalCards(Card,Total).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,2,Card),cardsSetFindTotalCards(Card,Total).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetNthCard(CardsSet,3,Card),cardsSetFindTotalCards(Card,Total).

% Requerimiento 5 
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),cardsSetMissingCards(CardsSet,Cards)
cardsSet([1,2,3,4,5,6,7],3,6,2,CardsSet),cardsSetMissingCards(CardsSet,Cards).
cardsSet([1,2,3,4,5,6,7],3,4,2,CardsSet),cardsSetMissingCards(CardsSet,Cards).

% Requerimiento 6
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetToString(CardsSet,X).
cardsSet([1,2,3,4,5,6,7],3,6,2,CardsSet),cardsSetToString(CardsSet,Y).
cardsSet([1,2,3,4,5,6,7],3,4,2,CardsSet),cardsSetToString(CardsSet,Z).
 
% Requerimiento 7 
 cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet), cardsSetIsDobble(CardsSet),
 dobbleGame(4,CardsSet,"stack",2,Game),
 dobbleGameRegister("Cristopher",Game,GameOut),
 dobbleGameWhoseTurnIsIt(GameOut,User).

 dobbleGame(4,[[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]],"stack",2,Game), 
 dobbleGameRegister("Cristopher",Game,GameOut),
 dobbleGameRegister("Cristian",GameOut,Game2),dobbleGameRegister("Cristisan",Game2,Game3).
 dobbleGameRegister("cristopher",[2, ["ss"], [[1, 2, 3], [1, 4, 5], [1, 6, 7],
  [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]], 'Modo'],GameOut)

cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet),
dobbleGame(4,CardsSet,"stack",2,Game), 
dobbleGameRegister("Cristopher",Game,GameOut),dobbleGameRegister("Rene",GameOut,Game2),dobbleGameRegister("Alexander",Game2,Game3),
dobbleGameWhoseTurnIsIt(Game3,Username).