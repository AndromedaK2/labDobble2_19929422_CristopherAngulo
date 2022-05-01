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

auxiliarcreateFirstCard([element|elements],n,card,count):-
    count is count + 1,
    auxiliarcreateFirstCard(elements,n,[card|element],count).
    
createFirstCard(elements,n,card):-
    auxiliarcreateFirstCard(elements,n,card,0).


