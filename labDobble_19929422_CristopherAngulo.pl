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

cardsSet().




firstAuxcreateFirstCard([Element|Elements],N,_,Count):-
    secondAuxcreateFirstCard(Elements,N,Element,Count).

secondAuxcreateFirstCard(_,N,_,N):-!.
secondAuxcreateFirstCard([Element|Elements],N,Card,Count):-
    Count1 is Count + 1,
    secondAuxcreateFirstCard(Elements,N,[Element|Card],Count1).

    
createFirstCard(Elements,N,Card):-
    firstAuxcreateFirstCard(Elements,N,Card,0).


