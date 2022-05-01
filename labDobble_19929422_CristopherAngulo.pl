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

firstAuxcreateFirstCard(_,N,Card,N,Card):- !.
firstAuxcreateFirstCard(Elements,N,FirstCard,Count,Card):-
    getFirstElement(Elements,Element),
    getTailElements(Elements,TailElements),
    append([Element],FirstCard,FinalCard),
    Count1 is Count + 1,
    firstAuxcreateFirstCard(TailElements,N,FinalCard,Count1,Card).    
    
createFirstCard(Elements,N,Card):-
    firstAuxcreateFirstCard(Elements,N,[],0,Card).

getFirstElement([Element|_],Element).
getTailElements([_|Elements],Elements).

getFirstCard([Card|_],Card).
getTailCards([_|Cards],Cards).



