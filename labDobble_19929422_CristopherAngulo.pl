:- use_module(library(lists)).

% TDA CardsSet 
% Representación Lista de Cartas:  Elements X NumberElementPerCard X MaxNumberOfCards X Seed X CardsSet
% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, MaxNumberOfCards, Seed: Entero+
% CardsSet: Lista de Cartas
% -- Predicados --
% cardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Seed,CardsSet)
% getOrder(NumberElementPerCard,Order)
% isValidOrder(Order)
% isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards)
% getMaxNumberOfCards(Order,MaxNumberOfCardsPosible)
% createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet)
% createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,CardsSet)
% -- Metas --
% Principales: CardsSet
% Secundarias: getOrder,isValidOrder,isAValidCardsSetToCreate,getMaxNumberOfCards
%              createCompleteCardsSet,createIncompleteCardsSet
% -- Cláusulas --
% Regla: Constructor Mazo de Cartas 
cardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Seed,CardsSet):-
  getOrder(NumberElementPerCard,Order),
  isValidOrder(Order),
  isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards),
  getMaxNumberOfCards(Order,MaxNumberOfCardsPosible),
  MaxNumberOfCardsPosible = MaxNumberOfCards ->
    createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet);
    getOrder(NumberElementPerCard,Order),
    createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,CardsSet).

% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, Order: Entero+
% CardsSet: Lista de Cartas
% -- Predicados --
% createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet)
%  createFirstCard(Elements,NumberElementPerCard,FirstCard)
%  createNCards(Elements,Order,[FirstCard],0,NCards)
%  createNSquareCards(Elements,NCards,Order,0,CardsSet)
% -- Metas --
% Principales: createCompleteCardsSet
% Secundarias: createFirstCard,createNCards,createNSquareCards
% --Cláusulas 
% Regla: Helper Constructor Crea Mazo de Cartas Completo
createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet):-
  createFirstCard(Elements,NumberElementPerCard,FirstCard),
  createNCards(Elements,Order,[FirstCard],0,NCards),
  createNSquareCards(Elements,NCards,Order,0,CardsSet).

% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, Order,MaxNumberOfCards: Entero+
% IncompleteCardsSet: Lista de Cartas
% -- Predicados --
% createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet)
% createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,IncompleteCardsSet)
% createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet)
% -- Metas --
% Principales: createIncompleteCardsSet
% Secundarias: createCompleteCardsSet,createIncompleteCardsSetAuxiliar
% -- Cláusulas --
% Regla: Helper Constructor Crea Mazo de Cartas Incompleto
createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,IncompleteCardsSet):-
 createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet),
 createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet).


% -- Dominios --
% CardsSet,IncompleteCardsSetAuxiliar,IncompleteCardsSet: Lista de Cartas
% Elements: Lista de Elementos
% NumberElementPerCard,Count,MaxNumberOfCards, Order: Entero+
% -- Predicados --
% createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet)
% addCardToCardsSet(FirstCard,IncompleteCardsSetAuxiliar,CardsSet),
% -- Metas --
% Principales: createIncompleteCardsSetAuxiliar
% Secundarias: addCardToCardsSet
% -- Cláusula --
% Regla: Helper para Crear Mazo de cartas Incompleto 
createIncompleteCardsSetAuxiliar(_,Count,Count,_,_,_,Cards,Cards):-!.
createIncompleteCardsSetAuxiliar([FirstCard|TailCards],Count,MaxNumberOfCards,Elements,
  NumberElementPerCard,Order,IncompleteCardsSetAuxiliar,IncompleteCardsSet):-
    FinalCount is Count + 1,
    addCardToCardsSet(FirstCard,IncompleteCardsSetAuxiliar,CardsSet),
    createIncompleteCardsSetAuxiliar(TailCards,FinalCount,MaxNumberOfCards,Elements,NumberElementPerCard,Order,CardsSet,IncompleteCardsSet).
  

% -- Dominios --
% CardsSet: Lista de Cartas
% -- Predicados --
% cardsSetIsDobble(CardsSet)
% validateAllCardsAreUniqueElements(CardsSet)
% validateAllCardsAreOneCommonElement(CardsSet)
% -- Metas --
% Principales: cardsSetIsDobble
% Secundarias: validateAllCardsAreUniqueElements,validateAllCardsAreOneCommonElement
% -- Cláusula --
% Regla: Pertenencia Validar si el mazo de cartas sirve para jugar
cardsSetIsDobble(CardsSet):-
  validateAllCardsAreUniqueElements(CardsSet),
  validateAllCardsAreOneCommonElement(CardsSet).


% -- Dominios --
% CardsSet: Lista de Cartas
% -- Predicados --
% validateAllCardsAreUniqueElements(CardsSet)
% isCardUniqueElements(Card)
% -- Metas --
% Principales: validateAllCardsAreUniqueElements
% Secundarias: isCardUniqueElements
% -- Cláusula --
% Regla: Helper Pertenencia Validar si todas las cartas tiene elementos o símbolos únicos
validateAllCardsAreUniqueElements([]).
validateAllCardsAreUniqueElements([_,[]]).
validateAllCardsAreUniqueElements([FirstCard|TailCards]):-
  isCardUniqueElements(FirstCard),
  validateAllCardsAreUniqueElements(TailCards).

% -- Dominios --
% Card: Lista de Elementos
% -- Predicados --
% isCardUniqueElements(Card)
% -- Metas --
% Principales: isCardUniqueElements
% -- Cláusula --
% Regla: Helper Pertenencia Validar si la carta tiene elementos únicos
isCardUniqueElements([]).
isCardUniqueElements([_,[]]).
isCardUniqueElements([FirstElement|TailElements]):-
  not(member(FirstElement,TailElements)),
  isCardUniqueElements(TailElements).
 
% -- Dominios --
% CardsSet: Lista de Cartas
% -- Predicados --
% validateAllCardsAreOneCommonElement(CardsSet):- 
% compareFirstCardWithTailCards(Card,CardsSet),
% -- Metas --
% Principales: validateAllCardsAreOneCommonElement
% Secundarias: compareFirstCardWithTailCards
% -- Cláusula --
% Regla: Helper Pertenencia Validar que todas las cartas tenga un elemento en común
validateAllCardsAreOneCommonElement([]).
validateAllCardsAreOneCommonElement([_,[]]).
validateAllCardsAreOneCommonElement([FirstCard|TailCards]):- 
  compareFirstCardWithTailCards(FirstCard,TailCards),
  validateAllCardsAreOneCommonElement(TailCards).
  
% -- Dominios --
% CardsSet: Lista de Cartas
% FirstCard,SecondCard: Lista de Elementos
% -- Predicados --
% compareFirstCardWithTailCards(Card,CardsSet)
% compareTwoCards(FirstCard,SecondCard)
% -- Metas --
% Principales: validateAllCardsAreOneCommonElement
% Secundarias: compareTwoCards
% -- Cláusula --
% Regla: Helper Pertenencia Comparar la primera carta con el resto de cartas
compareFirstCardWithTailCards(_,[]).
compareFirstCardWithTailCards(FirstCard,[SecondCard|TailCards]):-
 compareTwoCards(FirstCard,SecondCard),
 compareFirstCardWithTailCards(FirstCard,TailCards).

% -- Dominios --
% FirstCard,SecondCard: Lista de Elementos
% -- Predicados --
% compareTwoCards(FirstCard,SecondCard)
% -- Metas --
% Principales: compareTwoCards
% -- Cláusula --
% Regla: Helper Pertenencia Comparar la primera carta con la segunda carta
compareTwoCards(FirstCard,SecondCard):-
 intersection(FirstCard,SecondCard,Elements),
 length(Elements,Large),
 Large is 1.


% -- Dominios --
% CardsSet,MissingCards: Lista de Cartas
% -- Predicados --
%  cardsSetMissingCards(CardsSet,MissingCards):-
%  getElementsWithOutDuplicates(CardsSet,ElementsWithoutDuplicates),
%  getFirstCard(CardsSet,Card),
%  cardsSetFindTotalCards(Card,TotalCards),
%  getOrder(NumberElementPerCard,Order),
%  createCompleteCardsSet(ElementsWithoutDuplicates,NumberElementPerCard,Order,FullCardsSet),
% -- Metas --
% Principales: cardsSetMissingCards
% Secundarias: getElementsWithOutDuplicates,getFirstCard,cardsSetFindTotalCards,getOrder,createCompleteCardsSet
% -- Cláusula --
% Regla: Helper Busca las Cartas Faltantes
cardsSetMissingCards(CardsSet,MissingCards):-
 getElementsWithOutDuplicates(CardsSet,ElementsWithoutDuplicates),
 getFirstCard(CardsSet,Card),
 cardsSetFindTotalCards(Card,TotalCards),
 length(ElementsWithoutDuplicates,NumberOfElements),
 NumberOfElements = TotalCards,
 length(Card,NumberElementPerCard),
 getOrder(NumberElementPerCard,Order),
 createCompleteCardsSet(ElementsWithoutDuplicates,NumberElementPerCard,Order,FullCardsSet),
 subtract(FullCardsSet,CardsSet,MissingCards).
 
% -- Dominios --
% CardsSet: Lista de Cartas
% CardsSetToString: Representación en cadena de caracteres del mazo de cartas
% -- Predicados --
% cardsSetToString(CardsSet,CardsSetToString)
% cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString)
% -- Metas --
% Principales: cardsSetToString
% Secundarias: cardsToStringAuxiliar
% -- Cláusula --
% Regla: Helper que convierte un mazo de cartas a una representación en string 
cardsSetToString(CardsSet,CardsSetToString):-
  cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString).


% -- Dominios --
% CardsSet: Lista de Cartas
% Position: Entero+
% 
% -- Predicados --
% cardsSetToString(CardsSet,CardsSetToString)
% cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString)
% -- Metas --
% Principales: cardsSetToString
% Secundarias: cardsToStringAuxiliar
% -- Cláusula --
% Regla: Helper que convierte un mazo de cartas a una representación en string 
cardsToStringAuxiliar([],_,Cards,Cards).
cardsToStringAuxiliar([FirstCard|TailCards],Position,CardsSet,CardsSetToString):-
 FinalPosition is Position + 1,
 cardToString(FirstCard,FinalPosition,StringCard),
 string_concat(CardsSet,StringCard,StringCardFinal),
 cardsToStringAuxiliar(TailCards,FinalPosition,StringCardFinal,CardsSetToString).


cardToString(Card,Position,FinalStringCard):-
 atomics_to_string(Card,'-',StringCard),
 atomic_concat(Position,' : ',StringPosition),
 atomic_concat(' Carta ',StringPosition,StringCardFormat),
 atomic_concat(StringCardFormat,StringCard,FinalStringCard).


%Helper
createFirstCard(Elements,N,Card):- createFirstCardAuxiliar(Elements,N,[],0,Card).
createFirstCardAuxiliar(_,N,Card,N,Card):-!.
createFirstCardAuxiliar(Elements,N,FirstCard,Count,Card):-
  getFirstElement(Elements,Element),
  getTailElements(Elements,TailElements),
  addElementToCard(Element,FirstCard,FinalCard),
  FinalCount is Count + 1,
  createFirstCardAuxiliar(TailElements,N,FinalCard,FinalCount,Card).

%Helper
createNCards(_,N,Cards,N,Cards):-!.
createNCards(Elements,N,Cards,J,FinalCards):-
  getFirstElement(Elements,FirstElement),
  FinalJ is J + 1,
  createNCardAuxiliar(Elements,[FirstElement],N,FinalJ,0,Card),
  addCardToCardsSet(Card,Cards,NewCards),
  createNCards(Elements,N,NewCards,FinalJ,FinalCards).

%Helper
createNCardAuxiliar(_,Card,N,_,N,Card):-!.
createNCardAuxiliar(Elements,Card,N,J,K,FinalCard):- 
  calculateIndexToNCards(N,J,K,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,Card,NewCard),   
  FinalK is K + 1,
  createNCardAuxiliar(Elements,NewCard,N,J,FinalK,FinalCard).
  
  
%Helper
createNSquareCardsSecondAuxiliar(_,Card,N,_,_,K,Card):- K is N+1.
createNSquareCardsSecondAuxiliar(Elements,Card,N,J,I,K,FinalCard):-
  calculateIndexToNSquareCards(N,J,K,I,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,Card,NewCard),
  FinalK is K + 1,
  createNSquareCardsSecondAuxiliar(Elements,NewCard,N,J,I,FinalK,FinalCard).


%Helper
createNSquareCardsFirstAuxiliar(_,Cards,N,N,_,Cards):-!.
createNSquareCardsFirstAuxiliar(Elements,Cards,N,J,I,FinalCards):-Index is I,
  getElementByPosition(Index,Elements,FirstElement),
  FinalJ is J + 1,
  createNSquareCardsSecondAuxiliar(Elements,[FirstElement],N,FinalJ,I,1,Card),
  addCardToCardsSet(Card,Cards,NewCards),
  createNSquareCardsFirstAuxiliar(Elements,NewCards,N,FinalJ,I,FinalCards).

%Helper
createNSquareCards(_,Cards,N,N,Cards):-!.
createNSquareCards(Elements,Cards,N,I,CardsSet):-FinalI is I + 1,
  createNSquareCardsFirstAuxiliar(Elements,Cards,N,0,FinalI,NewCards),
  createNSquareCards(Elements,NewCards,N,FinalI,CardsSet).

%Selectores
getFirstElement([Element|_],Element).
getTailElements([_|Elements],Elements).
getOrder(N,Order):- Order is N-1.
getFirstCard([Card|_],Card).
getTailCards([_|Cards],Cards).
getElementByPosition(Index,Elements,Element):-nth0(Index,Elements,Element).
getMaxNumberOfCards(N,MaxNumberOfCards):-MaxNumberOfCards is  (N*N)+N+1.
getNumberOfElements(Elements,NumberOfElements):-length(Elements,NumberOfElements).
getElementsWithOutDuplicates(CardsSet,ElementsWithoutDuplicates):- flattenCardsSet(CardsSet,Elements),removeDuplicateElements(Elements,ElementsWithoutDuplicates).
cardsSetNthCard(CardsSet,Index,Card):-nth0(Index,CardsSet,Card).
cardsSetFindTotalCards(Card,TotalCards):-length(Card,Large),getOrder(Large,Order),
 TotalCards is (Order * Order) + Order + 1.



%Pertenencia
isElement(Element):- number(Element); string(Element); atom(Element).
isValidOrder(Order):- isPrime(Order).
isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).
isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards):-
  getMaxNumberOfCards(Order,MaxNumberOfCardsToCompare),
  length(Elements,ElementsLength), 
  MaxNumberOfCardsToCompare = MaxNumberOfCards,
  MaxNumberOfCards = ElementsLength.

%Helper
divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).
calculateIndexToNCards(N,J,K,Index):- Index is (N * J) + (K + 1).
calculateIndexToNSquareCards(N,J,K,I,Index):- Index is ((N+2)+N*(K-1) + (((I-1)*(K-1)+J-1) mod N)-1).
%Modificador
addElementToCard(Element,Card,CardUpdate):-isElement(Element),append(Card,[Element],CardUpdate).
addCardToCardsSet(Card,CardsSet,FinalCardsSet):-append(CardsSet,[Card],FinalCardsSet).
flattenCardsSet(CardsSet,FlatCardsSet):-flatten(CardsSet,FlatCardsSet).
removeDuplicateElements(Elements,ElementsWithoutDuplicates):- sort(Elements, ElementsWithoutDuplicates).

% cardsSetIsDobble([[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]]).
% cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet), cardsSetIsDobble(CardsSet).
% cardsSet([1,2,3,4,5,6,7],3,6,2,CardsSet),cardsSetMissingCards(CardsSet,Cards).
% cardsSet([1,2,3,4,5,6,7],3,7,2,CardsSet),cardsSetToString(CardsSet,X).


emptyPlayers([]).
emptyCardsZone([]).
emptyState([]).
emptyUserCards([]).
emptyTurns([]).

%TDA Player
player(Username,Player):- 
  string(Username),
  Cards  = [],
  Points = 0,
  Player = [Username,Cards,Points].

%TDA DobbleGame
dobbleGame(NumberOfPlayers,CardsSet,Mode,Seed,DobbleGame):-
 number(NumberOfPlayers),
 NumberOfPlayers > 1,
 cardsSetIsDobble(CardsSet),
 emptyPlayers(InitialPlayers),
 emptyCardsZone(InitialCardsZone),
 emptyState(InitialState),
 emptyTurns(InitialTurns),
 DobbleGame = [NumberOfPlayers,InitialPlayers,CardsSet,Mode,InitialCardsZone,InitialState,InitialTurns].
 

%Regla: Registrar Jugadores Nuevos, si ya existe retorna false.
dobbleGameRegister(Username,[N,Players|RestGame],[N,[Player|Players]| NewGame]):-
  length(Players,PlayersNumber),
  N > PlayersNumber,
  not(playerIsRegistered(Players,Username)),
  player(Username,Player),
  addTurn(Username,RestGame,NewGame).

%Regla: Helper Verifica si el usuario esta registrado, si existe retorna true, si no retorna false.
playerIsRegistered([],_):-false.
playerIsRegistered([[Username,_,_]|_],Username):-!.
playerIsRegistered([_|RestPlayers],Username):-
  playerIsRegistered(RestPlayers,Username).

addTurn(Username,[CardsSet,Mode,InitialCardsZone,InitialState,Turns],[CardsSet,Mode,InitialCardsZone,InitialState,UpdatedTurns]):-
  Turns = [] ->
    UpdatedTurns = [Username];
    append(Turns,Username,UpdatedTurns).
   


%Regla: Helper Obtener a quien le toca
% dobbleGameWhoseTurnIsIt(DobbleGame,Username):-
 




%trace, (dobbleGameRegister("cristopher",[2, ["ss"], [[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]], 'Modo'],GameOut)).

% dobbleGamePlay(Game).

% mode("stack",Game).
% mode("emptyhands",Game).

% llamo a la modalidad de juego
% action(null,Game,NewGame):-
% getGameMode(Game,Mode),

% action(pass,Game).
% action(spotit,Game).
% action(finish,Game).

% getGameMode([_,_,_,Mode],Mode):-
%   mode(Mode,_).



