:- use_module(library(lists)).

%Representación Mazo de Cartas:  Elements X NumberElement X NumberMaxCard X Seed X CardsSet
cardsSet(Elements,NumberElement,NumberMaxCard,Seed,CardsSet):-
    getOrder(NumberElement,Order),
    isValidOrder(Order),
    createFirstCard(Elements,NumberElement,FirstCard),
    createNCard(Elements,Order,[FirstCard],0,NCards),
    createNSquareCards(Elements,NCards,Order,0,CardsSet).

%Constructor Vacío
emptyCardsSet([]).

%Helper
createFirstCard(Elements,N,Card):- createFirstCardAuxiliar(Elements,N,[],0,Card).
createFirstCardAuxiliar(_,N,Card,N,Card):- !.
createFirstCardAuxiliar(Elements,N,FirstCard,Count,Card):-
    getFirstElement(Elements,Element),
    getTailElements(Elements,TailElements),
    addElementToCard(Element,FirstCard,FinalCard),
    FinalCount is Count + 1,
    createFirstCardAuxiliar(TailElements,N,FinalCard,FinalCount,Card).

%Helper
createNCard(_,N,Cards,N,Cards):-!.
createNCard(Elements,N,Cards,J,FinalCards):-
    getFirstElement(Elements,FirstElement),
    FinalJ is J + 1,
    createNCardAuxiliar(Elements,[FirstElement],N,FinalJ,0,Card),
    addCardToCardsSet(Card,Cards,NewCards),
    createNCard(Elements,N,NewCards,FinalJ,FinalCards).

%Helper
createNCardAuxiliar(_,Card,N,_,N,Card):-!.
createNCardAuxiliar(Elements,Card,N,J,K,FinalCard):- 
  calculateIndexToNCards(N,J,K,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,Card,NewCard),
  FinalK is K + 1,
  createNCardAuxiliar(Elements,NewCard,N,J,FinalK,FinalCard).
  
  
% EXAMPLE: createNCardAuxiliar([1,2,3,4,5,6,7,8,9,10,11,12,13],[1],3,0,0,Card).
%createNCard([1,2,3,4,5,6,7,8,9,10,11,12,13],3,[],0,Cards).

%Helper
createNSquareCardsSecondAuxiliar(_,Card,N,_,_,K,Card):- K is N+1.
createNSquareCardsSecondAuxiliar(Elements,Card,N,J,I,K,FinalCard):-
  calculateIndexToNSquareCards(N,J,K,I,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,Card,NewCard),
  FinalK is K + 1,
  createNSquareCardsSecondAuxiliar(Elements,NewCard,N,J,I,FinalK,FinalCard).


%Helper
createNSquareCardsFirstAuxiliar(_,Cards,N,N,_,Cards):- !.
createNSquareCardsFirstAuxiliar(Elements,Cards,N,J,I,FinalCards):-
  Index is I,
  getElementByPosition(Index,Elements,FirstElement),
  FinalJ is J + 1,
  createNSquareCardsSecondAuxiliar(Elements,[FirstElement],N,FinalJ,I,1,Card),
  addCardToCardsSet(Card,Cards,NewCards),
  createNSquareCardsFirstAuxiliar(Elements,NewCards,N,FinalJ,I,FinalCards).

%Helper
createNSquareCards(_,Cards,N,N,Cards):- !.
createNSquareCards(Elements,Cards,N,I,CardsSet):-
  FinalI is I + 1,
  createNSquareCardsFirstAuxiliar(Elements,Cards,N,0,FinalI,NewCards),
  createNSquareCards(Elements,NewCards,N,FinalI,CardsSet).


%createNSquareCardsSecondAuxiliar([1,2,3,4,5,6,7,8,9,10,11,12,13],[2],3,1,1,1,Cards).
%createNSquareCardsFirstAuxiliar([1,2,3,4,5,6,7,8,9,10,11,12,13],[],3,1,0,Cards).
%createNSquareCards([1,2,3,4,5,6,7,8,9,10,11,12,13],[],3,0,Cards).

%Selectores
getFirstElement([Element|_],Element).
getTailElements([_|Elements],Elements).
getOrder(N,Order):- Order is N-1.
getFirstCard([Card|_],Card).
getTailCards([_|Cards],Cards).
getElementByPosition(Index,Elements,Element):-nth0(Index,Elements,Element).
cardsSetNthCard(CardsSet,Index,Card):-nth0(Index,CardsSet,Card).
cardsSetFindTotalCards(Card,TotalCards):-
    length(Card,Large),
    getOrder(Large,Order),
    TotalCards is (Order * Order) + Order + 1.


%Pertenencia
isElement(Element):- number(Element); string(Element); atom(Element).
isValidOrder(Order):- isPrime(Order).
isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).

%Helper
divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).
calculateIndexToNCards(N,J,K,Index):- Index is (N * J) + (K + 1).
calculateIndexToNSquareCards(N,J,K,I,Index):- Index is ((N+2)+N*(K-1) + (((I-1)*(K-1)+J-1) mod N)-1).



%Modificador
addElementToCard(Element,Card,CardUpdate):-isElement(Element),append(Card,[Element],CardUpdate).
addCardToCardsSet(Card,CardsSet,FinalCardsSet):-append(CardsSet,[Card],FinalCardsSet).

%Examples:
% createFirstCard([1,2,3,4,5,6],4,Card).
% createFirstCard([1,"noruega",3,california,5,6],4,Card).
% cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet)




