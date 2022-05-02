:- use_module(library(lists)).

%Representación Mazo de Cartas:  Elements X NumberElement X NumberMaxCard X Seed X CardsSet
cardsSet(Elements,NumberElement,NumberMaxCard,Seed,CardsSet):-
    getOrder(NumberElement,Order),
    isValidOrder(Order),
    createFirstCard(Elements,NumberElement,FirstCard),
    createNCard(Elements,Order,[FirstCard],0,CardsSet).
    % addCardToCardsSet(Card,EmptyCardsSet,CardsSet).

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
createNCard(_,N,NCards,N,NCards):-!.
createNCard(Elements,N,Cards,J,FinalNCards):-
    getFirstElement(Elements,FirstElement),
    FinalJ is J + 1,
    createNCardAuxiliar(Elements,[FirstElement],N,FinalJ,0,FinalNCard),
    addCardToCardsSet(FinalNCard,Cards,CardsSet),
    createNCard(Elements,N,CardsSet,FinalJ,FinalNCards).

%Helper
createNCardAuxiliar(_,NCard,N,_,N,NCard):-!.
createNCardAuxiliar(Elements,NCard,N,J,K,FinalNCard):- 
  calculateIndexToNCards(N,J,K,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,NCard,NCardUpdate),
  FinalK is K + 1,
  createNCardAuxiliar(Elements,NCardUpdate,N,J,FinalK,FinalNCard).
  
  
% EXAMPLE: createNCardAuxiliar([1,2,3,4,5,6,7,8,9,10,11,12,13],[1],3,0,0,Card).
%createNCard([1,2,3,4,5,6,7,8,9,10,11,12,13],3,[],0,Cards).

%Helper
createNSquareCardsSecondAuxiliar(_,Card,N,_,_,K,Card):- K is N+1.
createNSquareCardsSecondAuxiliar(Elements,NSquareCard,N,J,I,K,FinalCard):-
  calculateIndexToNSquareCards(N,J,K,I,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,NSquareCard,NSquareCardUpdate),
  FinalK is K + 1,
  createNSquareCardsSecondAuxiliar(Elements,NSquareCardUpdate,N,J,I,FinalK,FinalCard).


%Helper
createNSquareCardsFirstAuxiliar(_,Cards,N,N,_,Cards):- !.
createNSquareCardsFirstAuxiliar(Elements,Cards,N,J,I,FinalCard):-
  Index is I,
  getElementByPosition(Index,Elements,FirstElement),
  FinalJ is J + 1,
  createNSquareCardsSecondAuxiliar(Elements,[FirstElement],N,FinalJ,I,1,Card),
  addCardToCardsSet(Card,Cards,CardsUpdate),
  createNSquareCardsFirstAuxiliar(Elements,CardsUpdate,N,FinalJ,I,FinalCard).












%createNSquareCardsSecondAuxiliar([1,2,3,4,5,6,7,8,9,10,11,12,13],[2],3,1,1,1,Cards).
%createNSquareCardsFirstAuxiliar([1,2,3,4,5,6,7,8,9,10,11,12,13],[],3,1,0,Cards).

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
addElementToCard(Element,Card,CardUpdate):- isElement(Element), append(Card,[Element],CardUpdate).

addCardToCardsSet(Card,CardsSet,FinalCardsSet):-
    append(CardsSet,[Card],FinalCardsSet).

%Examples:
% createFirstCard([1,2,3,4,5,6],4,Card).
% createFirstCard([1,"noruega",3,california,5,6],4,Card).
% cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet)




