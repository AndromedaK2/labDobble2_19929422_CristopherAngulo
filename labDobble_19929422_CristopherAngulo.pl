:- use_module(library(lists)).

cardsSet(Elements,NumberElement,NumberMaxCard,CardsSet,Random).


createFirstCard(Elements,N,Card):- createFirstCardAuxiliar(Elements,N,[],0,Card).


createFirstCardAuxiliar(_,N,Card,N,Card):- !.
createFirstCardAuxiliar(Elements,N,FirstCard,Count,Card):-
    getFirstElement(Elements,Element),
    getTailElements(Elements,TailElements),
    addElementToCard(Element,FirstCard,FinalCard),
    FinalCount is Count + 1,
    createFirstCardAuxiliar(TailElements,N,FinalCard,FinalCount,Card).    



getFirstElement([Element|_],Element).
getTailElements([_|Elements],Elements).

%CreateNCard(Elements,N,CardsSet):-
   
isElement(Element):- number(Element); string(Element); atom(Element).

isValidOrder(Order):- 
    isPrime(Order).

divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).

isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).

getFirstCard([Card|_],Card).
getTailCards([_|Cards],Cards).

addElementToCard(Element,Card,CardUpdate):- isElement(Element), append(Card,[Element],CardUpdate).

%addCardToCardsSet().

%Example:  
% createFirstCard([1,2,3,4,5,6],4,Card).
% createFirstCard([1,"noruega",3,california,5,6],4,Card).

