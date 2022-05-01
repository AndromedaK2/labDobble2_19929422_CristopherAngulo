:- use_module(library(lists)).
%Dominio
/*


*/


%Predicados
/*

*/

%Metas
/*
createFirstCard
cardsSet
*/

%Cláusulas

cardsSet(Elements,NumberElement,NumberMaxCard,CardsSet,Random).


    

createFirstCard(Elements,N,Card):- firstAuxcreateFirstCard(Elements,N,[],0,Card).

firstAuxcreateFirstCard(_,N,Card,N,Card):- !.
firstAuxcreateFirstCard(Elements,N,FirstCard,Count,Card):-
    getFirstElement(Elements,Element),
    getTailElements(Elements,TailElements),
    addElementToCard(Element,FirstCard,FinalCard),
    Count1 is Count + 1,
    firstAuxcreateFirstCard(TailElements,N,FinalCard,Count1,Card).    


getFirstElement([Element|_],Element).
getTailElements([_|Elements],Elements).

getFirstCard([Card|_],Card).
getTailCards([_|Cards],Cards).

addElementToCard(Element,Card,CardUpdate):- append(Card,[Element],CardUpdate).
addCardToCardsSet().

%Example: trace, createFirstCard([1,2,3,4,5,6],4,Card).

