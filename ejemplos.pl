 cardsSetIsDobble([[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]]).
cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet), cardsSetIsDobble(CardsSet).
cardsSet([1,2,3,4,5,6,7],3,6,2,CardsSet),cardsSetMissingCards(CardsSet,Cards).
cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetToString(CardsSet,X).
 
 
 dobbleGame(4,[[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]],"stack",2,Game), 
 dobbleGameRegister("Cristopher",Game,GameOut),
 dobbleGameRegister("Cristian",GameOut,Game2),dobbleGameRegister("Cristisan",Game2,Game3).
 dobbleGameRegister("cristopher",[2, ["ss"], [[1, 2, 3], [1, 4, 5], [1, 6, 7],
  [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]], 'Modo'],GameOut)