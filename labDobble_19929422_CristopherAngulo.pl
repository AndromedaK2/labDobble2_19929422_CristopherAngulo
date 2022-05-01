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

firstAuxcreateFirstCard(_,N,[],N):- !.
firstAuxcreateFirstCard(Elements,N,FirstCard,Count):-
    getFirstElement(Elements,Element),
    getTailElements(Elements,TailElements),
    Count1 is Count + 1,
    firstAuxcreateFirstCard(TailElements,N,[FirstCard|Element],Count1).
    
createFirstCard(Elements,N,Card):-
    firstAuxcreateFirstCard(Elements,N,Card,0).

getFirstElement([Element|_],Element).
getTailElements([_|Elements],Elements).

getFirstCard([Card|_],Card).
getTailCards([_|Cards],Cards).


% genNhelp(N,N,[]).
% genNhelp(N,C,[C|R]) :- 
%     C < N,
%     C1 is C + 1,
%     genNhelp(N,C1,R).

% genN(N,R) :-
%     genNhelp(N,0,R).