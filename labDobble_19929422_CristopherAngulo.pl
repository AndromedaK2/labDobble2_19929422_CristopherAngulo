:- use_module(library(lists)).

%Representación Mazo de Cartas:  Elements X NumberElement X NumberMaxCard X Seed X CardsSet
cardsSet(Elements,NumberElement,NumberMaxCard,Seed,CardsSet):-
    isValidOrder(NumberElement),
    createFirstCard(Elements,NumberElement,Card),
    emptyCardsSet(EmptyCardsSet),
    addCardToCardsSet(Card,EmptyCardsSet,CardsSet).

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
CreateNCard(_,N,NCards,N,NCards):-!.
CreateNCard(Elements,N,NCards,J,FinalNCards):-
    getFirstElement(Element,FirstElement).
    CreateNCardAuxiliar(Elements,FirstElement,  ),
    CreateNCard().

%Helper
CreateNCardAuxiliar(_,Card,N,N,_,Card):- !.
CreateNCardAuxiliar(Elements,Card,N,J,K,FinalCard):- 
  calculateIndexToNCards(N,J,K,Index),
  getElementByPosition(Elements,Index,Element),
  addElementToCard()
  
  


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
isValidOrder(Order):- FinalOrder is Order-1, isPrime(FinalOrder).
isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).

%Helper
divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).
calculateIndexToNCards(N,J,K,Index):-
  Index is (N * J) + (K + 1).

%Modificador
addElementToCard(Element,Card,CardUpdate):- isElement(Element), append(Card,[Element],CardUpdate).

addCardToCardsSet(Card,CardsSet,FinalCardsSet):-
    append([Card],CardsSet,FinalCardsSet).

%Examples:
% createFirstCard([1,2,3,4,5,6],4,Card).
% createFirstCard([1,"noruega",3,california,5,6],4,Card).
% cardsSet([1,2,3,4,5,6,7,8,9,10,11,12,13],4,13,2,CardsSet)




