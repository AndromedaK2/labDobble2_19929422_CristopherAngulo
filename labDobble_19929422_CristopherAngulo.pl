:- use_module(library(lists)).

% Implementación TDA CardsSet 
% Representación Lista de Cartas:  Elements X NumberElementPerCard X MaxNumberOfCards X Seed X CardsSet

% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, MaxNumberOfCards, Seed: Entero+
% CardsSet: Lista de Cartas

% -- Predicados --
% cardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Seed,CardsSet)
% getOrder(NumberElementPerCard,Order)
% isValidOrder(Order)
% isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards),
% createFirstCard(Elements,NumberElementPerCard,FirstCard),
% createNCards(Elements,Order,[FirstCard],0,NCards),
% createNSquareCards(Elements,NCards,Order,0,CardsSet).

% -- Metas --
% Principales: CardsSet
% Secundarias: getOrder,isValidOrder,isAValidCardsSetToCreate,createFirstCard,createNCards,createNSquareCards


% -- Cláusulas --
% Regla 

cardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Seed,CardsSet):-
  getOrder(NumberElementPerCard,Order),
  isValidOrder(Order),
  isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards),
  getMaxNumberOfCards(Order,MaxNumberOfCardsPosible),
  MaxNumberOfCardsPosible = MaxNumberOfCards ->
    createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet);
    getOrder(NumberElementPerCard,Order),
    createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,CardsSet).
    

createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet):-
  createFirstCard(Elements,NumberElementPerCard,FirstCard),
  createNCards(Elements,Order,[FirstCard],0,NCards),
  createNSquareCards(Elements,NCards,Order,0,CardsSet).

createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,IncompleteCardsSet):-
 createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet),
 createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet).
 
createIncompleteCardsSetAuxiliar(_,Count,Count,_,_,_,Cards,Cards):-!.
createIncompleteCardsSetAuxiliar([FirstCard|TailCards],Count,MaxNumberOfCards,Elements,
  NumberElementPerCard,Order,IncompleteCardsSetAuxiliar,IncompleteCardsSet):-
    FinalCount is Count + 1,
    addCardToCardsSet(FirstCard,IncompleteCardsSetAuxiliar,CardsSet),
    createIncompleteCardsSetAuxiliar(TailCards,FinalCount,MaxNumberOfCards,Elements,NumberElementPerCard,Order,CardsSet,IncompleteCardsSet).
  

% Regla
cardsSetIsDobble(CardsSet):-
  validateAllCardsAreUniqueElements(CardsSet),
  validateAllCardsAreOneCommonElement(CardsSet).


%Helper
validateAllCardsAreUniqueElements([]).
validateAllCardsAreUniqueElements([_,[]]).
validateAllCardsAreUniqueElements([FirstCard|TailCards]):-
  isCardUniqueElements(FirstCard),
  validateAllCardsAreUniqueElements(TailCards).


%Helper
isCardUniqueElements([]).
isCardUniqueElements([_,[]]).
isCardUniqueElements([FirstElement|TailElements]):-
  not(member(FirstElement,TailElements)),
  isCardUniqueElements(TailElements).
 

%Helper
validateAllCardsAreOneCommonElement([]).
validateAllCardsAreOneCommonElement([_,[]]).
validateAllCardsAreOneCommonElement([FirstCard|TailCards]):- 
  compareFirstCardWithTailCards(FirstCard,TailCards),
  validateAllCardsAreOneCommonElement(TailCards).
  


compareFirstCardWithTailCards(_,[]).
compareFirstCardWithTailCards(FirstCard,[SecondCard|TailCards]):-
 compareTwoCards(FirstCard,SecondCard),
 compareFirstCardWithTailCards(FirstCard,TailCards).
 
compareTwoCards(FirstCard,SecondCard):-
 intersection(FirstCard,SecondCard,Elements),
 length(Elements,Large),
 Large is 1.


%Regla
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
 
%Regla
cardsSetToString(CardsSet,CardsSetToString):-
  cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString).

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


player(Username,Points,Player):- string(Username), number(Points),
  append([Username],[Points],Player).

emptyPlayers([]).
emptyCardsZone([]).
emptyState([]).

dobbleGame(NumberOfPlayers,CardsSet,Mode,Seed,Game):-
 number(NumberOfPlayers),
 NumberOfPlayers > 1,
 cardsSetIsDobble(CardsSet),
 emptyPlayers(InitialPlayers),
 emptyCardsZone(InitialCardsZone),
 emptyState(InitialState),
 Game = [NumberOfPlayers,InitialPlayers,CardsSet,Mode].
 
playerIsRegistered([],_):-false.
playerIsRegistered([Player|_],Player):-!.
playerIsRegistered([_|RestPlayers],Player):-
  playerIsRegistered(RestPlayers,Player).


dobbleGameRegister(Player,[N,Players,C,M],[N,[Player|Players],C,M]):-
  length(Players,PlayersNumber),
  N >PlayersNumber,
  not(playerIsRegistered(Players,Player)).


%trace, (dobbleGameRegister("cristopher",[2, ["ss"], [[1, 2, 3], [1, 4, 5], [1, 6, 7], [2, 4, 6], [2, 5, 7], [3, 4, 7], [3, 5, 6]], 'Modo'],GameOut)).