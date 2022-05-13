:- use_module(library(lists)).


random(Xn, Xn1):-
AX is 1103515245 * Xn,
AXC is AX + 12345,
Xn1 is (AXC mod 2147483647).

% TDA CardsSet 
% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, MaxNumberOfCards, Seed: Entero+
% CardsSet: Lista de Cartas o Mazo de Cartas
% -- Predicados --
% cardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Seed,CardsSet)
% getOrder(NumberElementPerCard,Order)
% isValidOrder(Order)
% isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards)
% getMaxNumberOfCards(Order,MaxNumberOfCardsPosible)
% createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet)
% createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,CardsSet)
% -- Metas --
% Principales: CardsSet
% Secundarias: getOrder,isValidOrder,isAValidCardsSetToCreate,getMaxNumberOfCards
%              createCompleteCardsSet,createIncompleteCardsSet
% -- Cláusulas --
% Regla: Constructor Mazo de Cartas 
cardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Seed,CardsSet):-
  getOrder(NumberElementPerCard,Order),
  isValidOrder(Order),
  isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards),
  getMaxNumberOfCards(Order,MaxNumberOfCardsPosible),
  MaxNumberOfCardsPosible = MaxNumberOfCards ->
    createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet);
    getOrder(NumberElementPerCard,Order),
    createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,CardsSet).

% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, Order: Entero+
% CardsSet: Lista de Cartas
% -- Predicados --
% createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet)
%  createFirstCard(Elements,NumberElementPerCard,FirstCard)
%  createNCards(Elements,Order,[FirstCard],0,NCards)
%  createNSquareCards(Elements,NCards,Order,0,CardsSet)
% -- Metas --
% Principales: createCompleteCardsSet
% Secundarias: createFirstCard,createNCards,createNSquareCards
% --Cláusulas 
% Regla: Helper Constructor Crea Mazo de Cartas Completo
createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet):-
  createFirstCard(Elements,NumberElementPerCard,FirstCard),
  createNCards(Elements,Order,[FirstCard],0,NCards),
  createNSquareCards(Elements,NCards,Order,0,CardsSet).

% -- Dominios --
% Elements: Lista de Elementos
% NumberElementPerCard, Order,MaxNumberOfCards: Entero+
% IncompleteCardsSet: Lista de Cartas
% -- Predicados --
% createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet)
% createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,IncompleteCardsSet)
% createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet)
% -- Metas --
% Principales: createIncompleteCardsSet
% Secundarias: createCompleteCardsSet,createIncompleteCardsSetAuxiliar
% -- Cláusulas --
% Regla: Helper Constructor Crea Mazo de Cartas Incompleto
createIncompleteCardsSet(Elements,NumberElementPerCard,MaxNumberOfCards,Order,IncompleteCardsSet):-
 createCompleteCardsSet(Elements,NumberElementPerCard,Order,CardsSet),
 createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet).


% -- Dominios --
% CardsSet,IncompleteCardsSetAuxiliar,IncompleteCardsSet: Lista de Cartas
% Elements: Lista de Elementos
% NumberElementPerCard,Count,MaxNumberOfCards, Order: Entero+
% -- Predicados --
% createIncompleteCardsSetAuxiliar(CardsSet,0,MaxNumberOfCards,Elements,NumberElementPerCard,Order,[],IncompleteCardsSet)
% addCardToCardsSet(FirstCard,IncompleteCardsSetAuxiliar,CardsSet),
% -- Metas --
% Principales: createIncompleteCardsSetAuxiliar
% Secundarias: addCardToCardsSet
% -- Cláusula --
% Regla: Helper para Crear Mazo de cartas Incompleto 
createIncompleteCardsSetAuxiliar(_,Count,Count,_,_,_,Cards,Cards):-!.
createIncompleteCardsSetAuxiliar([FirstCard|TailCards],Count,MaxNumberOfCards,Elements,
  NumberElementPerCard,Order,IncompleteCardsSetAuxiliar,IncompleteCardsSet):-
    FinalCount is Count + 1,
    addCardToCardsSet(FirstCard,IncompleteCardsSetAuxiliar,CardsSet),
    createIncompleteCardsSetAuxiliar(TailCards,FinalCount,MaxNumberOfCards,Elements,NumberElementPerCard,Order,CardsSet,IncompleteCardsSet).
  
% -- Dominios --
% Card:Lista de simbolos
% Elements: Simbolos o Elementos
% N: Entero+
% -- Predicados --
% createFirstCard(Elements,N,Card)
% createFirstCardAuxiliar(Elements,N,[],0,Card)
% -- Metas --
% Principales: createFirstCard
% Secundarias: createFirstCardAuxiliar
% -- Cláusula --
% Regla: Helper Constructor de Primera Carta
createFirstCard(Elements,N,Card):- createFirstCardAuxiliar(Elements,N,[],0,Card).

% -- Dominios --
% Card,FirstCard:Lista de simbolos
% Elements: Simbolos o Elementos
% N, Count: Entero+
% -- Predicados --
% createFirstCardAuxiliar(Elements,N,FirstCard,Count,Card)
% getFirstElement(Elements,Element),
% getTailElements(Elements,TailElements),
% addElementToCard(Element,FirstCard,FinalCard),
% -- Metas --
% Principales: createFirstCardAuxiliar
% Secundarias: getFirstElement,GetTailElements,addElementToCard
% -- Cláusula --
% Regla: Helper Constructor auxiliar de Primera Carta
createFirstCardAuxiliar(_,N,Card,N,Card):-!.
createFirstCardAuxiliar(Elements,N,FirstCard,Count,Card):-
  getFirstElement(Elements,Element),
  getTailElements(Elements,TailElements),
  addElementToCard(Element,FirstCard,FinalCard),
  FinalCount is Count + 1,
  createFirstCardAuxiliar(TailElements,N,FinalCard,FinalCount,Card).


% -- Dominios --
% Cards,FinalCards:Lista de cartas
% Elements: Simbolos o Elementos
% N: Entero+
% -- Predicados --
% createNCards(Elements,N,Cards,J,FinalCards)
% getFirstElement(Elements,FirstElement)
% createNCardAuxiliar(Elements,[FirstElement],N,FinalJ,0,Card)
% addCardToCardsSet(Card,Cards,NewCards)
% createNCards(Elements,N,NewCards,FinalJ,FinalCards)
% -- Metas --
% Principales: createNCards
% Secundarias: getFirstElement,createNCardAuxiliar,addCardToCardsSet
% -- Cláusula --
% Regla: Helper Constructor de las N Cartas 
createNCards(_,N,Cards,N,Cards):-!.
createNCards(Elements,N,Cards,J,FinalCards):-
  getFirstElement(Elements,FirstElement),
  FinalJ is J + 1,
  createNCardAuxiliar(Elements,[FirstElement],N,FinalJ,0,Card),
  addCardToCardsSet(Card,Cards,NewCards),
  createNCards(Elements,N,NewCards,FinalJ,FinalCards).

% -- Dominios --
% Card,FinalCard:Lista de simbolos
% Elements: Simbolos o Elementos
% N,J,K: Entero+
%  -- Predicados --
% createNCardAuxiliar(Elements,Card,N,J,K,FinalCard)
% calculateIndexToNCards(N,J,K,Index)
% getElementByPosition(Index,Elements,Element)
% addElementToCard(Element,Card,NewCard)
% -- Metas --
% Principales: createNCardAuxiliar
% Secundarias: calculateIndexToNCards,getElementByPosition,addElementToCard
% -- Cláusula --
% Regla: Helper Auxiliar Constructor de las N Cartas 
createNCardAuxiliar(_,Card,N,_,N,Card):-!.
createNCardAuxiliar(Elements,Card,N,J,K,FinalCard):- 
  calculateIndexToNCards(N,J,K,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,Card,NewCard),   
  FinalK is K + 1,
  createNCardAuxiliar(Elements,NewCard,N,J,FinalK,FinalCard).
  
  
% -- Dominios --
% Card,FinalCard:Lista de simbolos
% Elements: Simbolos o Elementos
% N,J,K,I: Entero+
%  -- Predicados --
% createNSquareCardsSecondAuxiliar(Elements,Card,N,J,I,K,FinalCard)
% calculateIndexToNSquareCards(N,J,K,I,Index)
% getElementByPosition(Index,Elements,Element)
% addElementToCard(Element,Card,NewCard)
% -- Metas --
% Principales: createNSquareCardsSecondAuxiliar
% Secundarias: calculateIndexToNSquareCards,getElementByPosition,addElementToCard
% -- Cláusula --
% Regla: Helper Segundo Auxiliar Constructor de las N cuadrado Cartas 
createNSquareCardsSecondAuxiliar(_,Card,N,_,_,K,Card):- K is N+1.
createNSquareCardsSecondAuxiliar(Elements,Card,N,J,I,K,FinalCard):-
  calculateIndexToNSquareCards(N,J,K,I,Index),
  getElementByPosition(Index,Elements,Element),
  addElementToCard(Element,Card,NewCard),
  FinalK is K + 1,
  createNSquareCardsSecondAuxiliar(Elements,NewCard,N,J,I,FinalK,FinalCard).

% -- Dominios --
% Cards,FinalCards:Lista de simbolos
% Elements: Simbolos o Elementos
% N,J,I: Entero+
%  -- Predicados --
% createNSquareCardsFirstAuxiliar(Elements,Cards,N,J,I,FinalCards)
% getElementByPosition(Index,Elements,Element)
% createNSquareCardsSecondAuxiliar(Elements,[FirstElement],N,FinalJ,I,1,Card)
% addCardToCardsSet(Card,Cards,NewCards)
% -- Metas --
% Principales: createNSquareCardsFirstAuxiliar
% Secundarias: createNSquareCardsSecondAuxiliar,getElementByPosition,addCardToCardsSet
% -- Cláusula --
% Regla: Helper Primer Auxiliar Constructor de las N cuadrado Cartas 
createNSquareCardsFirstAuxiliar(_,Cards,N,N,_,Cards):-!.
createNSquareCardsFirstAuxiliar(Elements,Cards,N,J,I,FinalCards):-Index is I,
  getElementByPosition(Index,Elements,FirstElement),
  FinalJ is J + 1,
  createNSquareCardsSecondAuxiliar(Elements,[FirstElement],N,FinalJ,I,1,Card),
  addCardToCardsSet(Card,Cards,NewCards),
  createNSquareCardsFirstAuxiliar(Elements,NewCards,N,FinalJ,I,FinalCards).

% -- Dominios --
% Cards,CardsSet:Lista de simbolos
% Elements: Simbolos o Elementos
% N,I: Entero+
%  -- Predicados --
% createNSquareCards(Elements,Cards,N,I,CardsSet)
% createNSquareCardsFirstAuxiliar(Elements,Cards,N,J,I,FinalCards)
% -- Metas --
% Principales: createNSquareCards
% Secundarias: createNSquareCardsFirstAuxiliar
% -- Cláusula --
% Regla: Helper Constructor de las N cuadrado Cartas 
createNSquareCards(_,Cards,N,N,Cards):-!.
createNSquareCards(Elements,Cards,N,I,CardsSet):-FinalI is I + 1,
  createNSquareCardsFirstAuxiliar(Elements,Cards,N,0,FinalI,NewCards),
  createNSquareCards(Elements,NewCards,N,FinalI,CardsSet).



% -- Dominios --
% CardsSet: Lista de Cartas
% -- Predicados --
% cardsSetIsDobble(CardsSet)
% validateAllCardsAreUniqueElements(CardsSet)
% validateAllCardsAreOneCommonElement(CardsSet)
% -- Metas --
% Principales: cardsSetIsDobble
% Secundarias: validateAllCardsAreUniqueElements,validateAllCardsAreOneCommonElement
% -- Cláusula --
% Regla: Pertenencia Validar si el mazo de cartas sirve para jugar
cardsSetIsDobble(CardsSet):-
  validateAllCardsAreUniqueElements(CardsSet),
  validateAllCardsAreOneCommonElement(CardsSet).


% -- Dominios --
% CardsSet: Lista de Cartas
% -- Predicados --
% validateAllCardsAreUniqueElements(CardsSet)
% isCardUniqueElements(Card)
% -- Metas --
% Principales: validateAllCardsAreUniqueElements
% Secundarias: isCardUniqueElements
% -- Cláusula --
% Regla: Helper Pertenencia Validar si todas las cartas tiene elementos o símbolos únicos
validateAllCardsAreUniqueElements([]).
validateAllCardsAreUniqueElements([_,[]]).
validateAllCardsAreUniqueElements([FirstCard|TailCards]):-
  isCardUniqueElements(FirstCard),
  validateAllCardsAreUniqueElements(TailCards).

% -- Dominios --
% Card: Lista de Elementos
% -- Predicados --
% isCardUniqueElements(Card)
% -- Metas --
% Principales: isCardUniqueElements
% -- Cláusula --
% Regla: Helper Pertenencia Validar si la carta tiene elementos únicos
isCardUniqueElements([]).
isCardUniqueElements([_,[]]).
isCardUniqueElements([FirstElement|TailElements]):-
  not(member(FirstElement,TailElements)),
  isCardUniqueElements(TailElements).
 
% -- Dominios --
% CardsSet: Lista de Cartas
% -- Predicados --
% validateAllCardsAreOneCommonElement(CardsSet):- 
% compareFirstCardWithTailCards(Card,CardsSet),
% -- Metas --
% Principales: validateAllCardsAreOneCommonElement
% Secundarias: compareFirstCardWithTailCards
% -- Cláusula --
% Regla: Helper Pertenencia Validar que todas las cartas tenga un elemento en común
validateAllCardsAreOneCommonElement([]).
validateAllCardsAreOneCommonElement([_,[]]).
validateAllCardsAreOneCommonElement([FirstCard|TailCards]):- 
  compareFirstCardWithTailCards(FirstCard,TailCards),
  validateAllCardsAreOneCommonElement(TailCards).
  
% -- Dominios --
% CardsSet: Lista de Cartas
% FirstCard,SecondCard: Lista de Elementos
% -- Predicados --
% compareFirstCardWithTailCards(Card,CardsSet)
% compareTwoCards(FirstCard,SecondCard)
% -- Metas --
% Principales: validateAllCardsAreOneCommonElement
% Secundarias: compareTwoCards
% -- Cláusula --
% Regla: Helper Pertenencia Comparar la primera carta con el resto de cartas
compareFirstCardWithTailCards(_,[]).
compareFirstCardWithTailCards(FirstCard,[SecondCard|TailCards]):-
 compareTwoCards(FirstCard,SecondCard),
 compareFirstCardWithTailCards(FirstCard,TailCards).

% -- Dominios --
% FirstCard,SecondCard: Lista de Elementos
% -- Predicados --
% compareTwoCards(FirstCard,SecondCard)
% -- Metas --
% Principales: compareTwoCards
% -- Cláusula --
% Regla: Helper Pertenencia Comparar la primera carta con la segunda carta
compareTwoCards(FirstCard,SecondCard):-
 intersection(FirstCard,SecondCard,Elements),
 length(Elements,Large),
 Large is 1.


% -- Dominios --
% CardsSet,MissingCards: Lista de Cartas
% -- Predicados --
%  cardsSetMissingCards(CardsSet,MissingCards):-
%  getElementsWithOutDuplicates(CardsSet,ElementsWithoutDuplicates),
%  getFirstCard(CardsSet,Card),
%  cardsSetFindTotalCards(Card,TotalCards),
%  getOrder(NumberElementPerCard,Order),
%  createCompleteCardsSet(ElementsWithoutDuplicates,NumberElementPerCard,Order,FullCardsSet),
% -- Metas --
% Principales: cardsSetMissingCards
% Secundarias: getElementsWithOutDuplicates,getFirstCard,cardsSetFindTotalCards,getOrder,createCompleteCardsSet
% -- Cláusula --
% Regla: Helper Busca las Cartas Faltantes
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
 
% -- Dominios --
% CardsSet: Lista de Cartas
% CardsSetToString: Representación en cadena de caracteres del mazo de cartas
% -- Predicados --
% cardsSetToString(CardsSet,CardsSetToString)
% cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString)
% -- Metas --
% Principales: cardsSetToString
% Secundarias: cardsToStringAuxiliar
% -- Cláusula --
% Regla: Helper que convierte un mazo de cartas a una representación en string 
cardsSetToString(CardsSet,CardsSetToString):-
  cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString).


% -- Dominios --
% CardsSet: Lista de Cartas
% Position: Entero+
% CardsSetToString: Mazo de cartas en formato string
% -- Predicados --
% cardsSetToString(CardsSet,CardsSetToString)
% cardsToStringAuxiliar(CardsSet,0,'Mazo de Cartas: ',CardsSetToString)
% -- Metas --
% Principales: cardsSetToString
% Secundarias: cardsToStringAuxiliar
% -- Cláusula --
% Regla: Helper que convierte un mazo de cartas a una representación en string 
cardsToStringAuxiliar([],_,Cards,Cards).
cardsToStringAuxiliar([FirstCard|TailCards],Position,CardsSet,CardsSetToString):-
 FinalPosition is Position + 1,
 cardToString(FirstCard,FinalPosition,StringCard),
 string_concat(CardsSet,StringCard,StringCardFinal),
 cardsToStringAuxiliar(TailCards,FinalPosition,StringCardFinal,CardsSetToString).


% -- Dominios --
% Card:Lista de simbolos
% FinalStringCard: Carta em formato string
% Position: Entero+
% -- Predicados --
% cardToString(Card,Position,FinalStringCard)
% -- Metas --
% Principales: cardToString
% -- Cláusula --
% Regla: Helper que convierte una carta representación en string 
cardToString(Card,Position,FinalStringCard):-
 atomics_to_string(Card,'-',StringCard),
 atomic_concat(Position,' : ',StringPosition),
 atomic_concat(' Carta ',StringPosition,StringCardFormat),
 atomic_concat(StringCardFormat,StringCard,FinalStringCard).


% -- Dominios --
% Element: Simbolo
% Elements: Simbolos o Elementos
%  -- Predicados --
% getFirstElement(Elements,Element)
% -- Metas --
% Principales: getFirstElement
% -- Cláusula --
% Regla: Selector Obtener el primer elemento
getFirstElement([Element|_],Element).

% -- Dominios --
% Elements: Simbolos o Elementos
%  -- Predicados --
% getFirstElement(Elements,Elements)
% -- Metas --
% Principales: getTailElements
% -- Cláusula --
% Regla: Selector Obtener la cola de la lista de elementos
getTailElements([_|Elements],Elements).

% -- Dominios --
% Order,N: Enteros+
%  -- Predicados --
% getOrder(N,Order)
% -- Metas --
% Principales: getOrder
% -- Cláusula --
% Regla: Selector Obtener el orden del plano proyectivo del mazo de cartas
getOrder(N,Order):- Order is N-1.

% -- Dominios --
% CardsSet: Lista de Cartas
% Card: Lista de Elementos
%  -- Predicados --
% getFirstCard(CardsSet,Card)
% -- Metas --
% Principales: getFirstCard
% -- Cláusula --
% Regla: Selector Obtener la primera carta
getFirstCard([Card|_],Card).

% -- Dominios --
% CardsSet: Lista de Cartas
% Cards: Lista de Elementos
%  -- Predicados --
% getFirstCard(CardsSet,Cards)
% -- Metas --
% Principales: getTailCards
% -- Cláusula --
% Regla: Selector Obtener las cartas de la cola del mazo
getTailCards([_|Cards],Cards).

% -- Dominios --
% Elements:Lista de Elementos
% Index: Entero+
% Element: Elemento o Símbolo
%  -- Predicados --
% getElementByPosition(Index,Elements,Element)
% -- Metas --
% Principales: getElementByPosition
% -- Cláusula --
% Regla: Selector Obtener elemento por posición
getElementByPosition(Index,Elements,Element):-nth0(Index,Elements,Element).

% -- Dominios --
% Elements:Lista de Elementos
% Index: Entero+
% Element: Elemento o Símbolo
%  -- Predicados --
% getElementByPosition(Index,Elements,Element)
% -- Metas --
% Principales: getElementByPosition
% -- Cláusula --
% Regla: Selector Obtener el máximo número de cartas
getMaxNumberOfCards(N,MaxNumberOfCards):-MaxNumberOfCards is  (N*N)+N+1.

% -- Dominios --
% Elements:Lista de Elementos
% NumberOfElements: Entero+
%  -- Predicados --
% getNumberOfElements(Elements,NumberOfElements)
% -- Metas --
% Principales: getNumberOfElements
% -- Cláusula --
% Regla: Selector Obtener el número de elementos
getNumberOfElements(Elements,NumberOfElements):-length(Elements,NumberOfElements).

% -- Dominios --
% ElementsWithoutDuplicates:Lista de Elementos
% CardsSet: Lista de Cartas
%  -- Predicados --
% getElementsWithOutDuplicates(CardsSet,ElementsWithoutDuplicates)
% flattenCardsSet(CardsSet,Elements)
% removeDuplicateElements(Elements,ElementsWithoutDuplicates)
% -- Metas --
% Principales: getElementsWithOutDuplicates
% Secundarias: flattenCardsSet,removeDuplicateElements
% -- Cláusula --
% Regla: Selector Obtener el número de elementos sin duplicados
getElementsWithOutDuplicates(CardsSet,ElementsWithoutDuplicates):- 
  flattenCardsSet(CardsSet,Elements),
  removeDuplicateElements(Elements,ElementsWithoutDuplicates).

% -- Dominios --
% Card:Lista de Elementos
% Index: Entero+
% CardsSet: Lista de Cartas
%  -- Predicados --
% cardsSetNthCard(CardsSet,Index,Card)
% -- Metas --
% Principales: cardsSetNthCard
% -- Cláusula --
% Regla: Selector Obtener la enésima carta
cardsSetNthCard(CardsSet,Index,Card):-nth0(Index,CardsSet,Card).

% -- Dominios --
% Card,TotalCards: Lista de Cartas
%  -- Predicados --
% cardsSetFindTotalCards(Card,TotalCards)
% getOrder(Large,Order)
% -- Metas --
% Principales: cardsSetFindTotalCards
% Secundarias: getOrder
% -- Cláusula --
% Regla: Selector Obtener la enésima carta
cardsSetFindTotalCards(Card,TotalCards):-length(Card,Large),getOrder(Large,Order),
 TotalCards is (Order * Order) + Order + 1.

% -- Dominios --
% Element: Elemento o Símbolo
%  -- Predicados --
% isElement(Element)
% -- Metas --
% Principales: isElement
% -- Cláusula --
% Regla: Pertenencia verificar si es un elemento
isElement(Element):- number(Element); string(Element); atom(Element).

% -- Dominios --
% Order: Entero+
%  -- Predicados --
% isValidOrder(Order)
% -- Metas --
% Principales: isValidOrder
% Secundarias: isPrimer
% -- Cláusula --
% Regla: Helper Pertenencia verificar si el número es primo
isValidOrder(Order):- isPrime(Order).

% -- Dominios --
% X: Entero+
%  -- Predicados --
% isPrime(X)
% divisible(X, 2)
% -- Metas --
% Principales: isPrime
% Secundarias: divisible
% -- Cláusula --
% Regla: Pertenencia verificar si es orden válido
isPrime(2) :- true,!.
isPrime(X) :- X < 2,!,false.
isPrime(X) :- not(divisible(X, 2)).

% -- Dominios --
% Elements: Elementos o Símbolos
% Order,MaxNumberOfCards: Entero+
%  -- Predicados --
% isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards)
% getMaxNumberOfCards(Order,MaxNumberOfCardsToCompare) 
% -- Metas --
% Principales: isAValidCardsSetToCreate
% Secundarias: getMaxNumberOfCards
% -- Cláusula --
% Regla: Pertenencia verificar si es orden válido
isAValidCardsSetToCreate(Elements,Order,MaxNumberOfCards):-
  getMaxNumberOfCards(Order,MaxNumberOfCardsToCompare),
  length(Elements,ElementsLength), 
  MaxNumberOfCardsToCompare = MaxNumberOfCards,
  MaxNumberOfCards = ElementsLength.

% -- Dominios --
% X,Y: Entero+
%  -- Predicados --
% divisible(X,Y)
% -- Metas --
% Principales: divisible(X,Y)
% -- Cláusula --
% Regla: Helper Pertenencia verificar si es divisible por un número
divisible(X,Y) :- 0 is X mod Y, !.
divisible(X,Y) :- X > Y+1, divisible(X, Y+1).

% -- Dominios --
% N,J,K,Index: Entero+
%  -- Predicados --
% calculateIndexToNCards(N,J,K,Index)
% -- Metas --
% Principales: calculateIndexToNCards
% -- Cláusula --
% Regla: Helper Calcular Indice para buscar la N cartas
calculateIndexToNCards(N,J,K,Index):- Index is (N * J) + (K + 1).

% -- Dominios --
% N,J,K,I,Index: Entero+
%  -- Predicados --
% calculateIndexToNSquareCards(N,J,K,I,Index)
% -- Metas --
% Principales: calculateIndexToNSquareCards
% -- Cláusula --
% Regla: Helper Calcular Indice para buscar la N cuadrado cartas
calculateIndexToNSquareCards(N,J,K,I,Index):- Index is ((N+2)+N*(K-1) + (((I-1)*(K-1)+J-1) mod N)-1).

% -- Dominios --
% Element: Elemento o Símbolo
% Card,CardUpdate: Lista de Elementos o Símbolos 
%  -- Predicados --
% addElementToCard(Element,Card,CardUpdate)
% isElement(Element)
% -- Metas --
% Principales: addElementToCard
% Secundarias: isElement
% -- Cláusula --
% Regla: Helper Modificador Agregar elemento a carta
addElementToCard(Element,Card,CardUpdate):-isElement(Element),append(Card,[Element],CardUpdate).

% -- Dominios --
% CardsSet,FinalCardsSet: Lista de Cartas
% Card: Lista de Elementos o Símbolos 
%  -- Predicados --
% addCardToCardsSet(Card,CardsSet,FinalCardsSet)
% -- Metas --
% Principales: addCardToCardsSet
% -- Cláusula --
% Regla: Helper Modificador Agregar Carta al mazo de cartas
addCardToCardsSet(Card,CardsSet,FinalCardsSet):-append(CardsSet,[Card],FinalCardsSet).

% -- Dominios --
% CardsSet,FlatCardsSet: Lista de Cartas
%  -- Predicados --
% flattenCardsSet(CardsSet,FlatCardsSet)
% -- Metas --
% Principales:flattenCardsSet
% -- Cláusula --
% Regla: Helper Modificador Aplanar Mazo de cartas
flattenCardsSet(CardsSet,FlatCardsSet):-flatten(CardsSet,FlatCardsSet).

% -- Dominios --
% Elements,ElementsWithoutDuplicates: Elementos o Símbolos
%  -- Predicados --
% removeDuplicateElements(Elements,ElementsWithoutDuplicates)
% -- Metas --
% Principales: removeDuplicateElements
% -- Cláusula --
% Regla: Helper Modificador remover elementos duplicados
removeDuplicateElements(Elements,ElementsWithoutDuplicates):- sort(Elements, ElementsWithoutDuplicates).


% TDA Player
% -- Dominios --
% Username: string
% Cards: Lista de Cartas | Lista Vacía 
% Points: Entero+
% Player: Username X Cards X Points
%  -- Predicados --
% removeDuplicateElements(Elements,ElementsWithoutDuplicates)
% -- Metas --
% Principales: removeDuplicateElements
% -- Cláusula --
% Regla: Constructor Jugador
player(Username,Player):- 
  string(Username),
  Cards  = [],
  Points = 0,
  Player = [Username,Cards,Points].


% -- Dominios --
% Listas Vacías
%  -- Predicados --
% emptyPlayers([]).
% emptyCardsZone([]).
% emptyState([]).
% emptyUserCards([]).
% emptyTurns([]).
% -- Metas --
% Principales: emptyPlayers,
% emptyCardsZone,
% emptyState,
% emptyUserCards,
% emptyTurns,
% -- Cláusula --
% Hechos: 
emptyPlayers([]).
emptyCardsZone([]).
emptyState("Juego Creado").
emptyUserCards([]).
emptyTurns([]).



% TDA DobbleGame
% ---Dominios---
% NumberOfPlayers, Seed:Entero+
% CardsSet: Lista de Cartas
% Mode: String
% DobbleGame: Juego Dobble -> NumberOfPlayers  X Players X CardsSet X Mode X CardsZone X State X Turns
% ---Predicados---
% dobbleGame(NumberOfPlayers,CardsSet,Mode,Seed,DobbleGame)
% cardsSetIsDobble(CardsSet),
% emptyPlayers(InitialPlayers)
% emptyCardsZone(InitialCardsZone)
% emptyState(InitialState)
% emptyTurns(InitialTurns)
% ---Metas---
% Principales: dobbleGame
% Secundarias: cardsSetIsDobble, emptyPlayers, emptyCardsZone, emptyState, emptyTurns
% ---Cláusula---:
% Regla: Constructor DobbleGame
dobbleGame(NumberOfPlayers,CardsSet,Mode,Seed,DobbleGame):-
 number(NumberOfPlayers),
 NumberOfPlayers > 1,
 cardsSetIsDobble(CardsSet),
 emptyPlayers(InitialPlayers),
 emptyCardsZone(InitialCardsZone),
 emptyState(InitialState),
 emptyTurns(InitialTurns),
 DobbleGame = [NumberOfPlayers,InitialPlayers,CardsSet,Mode,InitialCardsZone,InitialState,InitialTurns].
 

% ---Dominios---
% Username:string
% DobbleGame,NewDobbleGame: Juego Dobble
% ---Predicados---
% dobbleGameRegister(Username,DobbleGame,NewDobbleGame)
% playerIsRegistered(Players,Username)
% player(Username,Player)
% addTurn(Username,RestGame,NewGame)
% ---Metas---
% Principales: dobbleGameRegister
% Secundarias: playerIsRegistered,player,addTurn
% ---Cláusula---:
% Regla: Modificador Registra  Jugadores Nuevos, si ya existe retorna false.
dobbleGameRegister(Username,[N,Players|RestGame],[N,[Player|Players]| NewGame]):-
  length(Players,PlayersNumber),
  N > PlayersNumber,
  not(playerIsRegistered(Players,Username)),
  player(Username,Player),
  addTurn(Username,RestGame,NewGame).


% ---Dominios---
% Username:string
% Players: Lista de Jugadores
% ---Predicados---
% playerIsRegistered(Players,Username)
% ---Metas---
% Principales: playerIsRegistered
% ---Cláusula---:
% Regla: Helper Pertenencia Verifica si el usuario esta registrado, si existe retorna true, si no retorna false.
playerIsRegistered([],_):-false.
playerIsRegistered([[Username,_,_]|_],Username):-!.
playerIsRegistered([_|RestPlayers],Username):-playerIsRegistered(RestPlayers,Username).


% ---Dominios---
% Turns: Turnos 
% DobbleGame: Juego Dobble
% ---Predicados---
% getTurns(DobbleGame,Turns)
% ---Metas---
% Principales: getTurns
% ---Cláusula---:
% Regla: Selector retorna los turnos del juego
getTurns([_,_,_,_,_,_,Turns],Turns).

% ---Dominios---
% NumberOfPlayers: Entero+ 
% DobbleGame: Juego Dobble
% ---Predicados---
% getNumberOfPlayers(DobbleGame,NumberOfPlayers)
% ---Metas---
% Principales: getNumberOfPlayers
% ---Cláusula---:
% Regla: Selector retorna el número de jugadores
getNumberOfPlayers([NumberOfPlayers,_,_,_,_,_,_],NumberOfPlayers).

% ---Dominios---
% Players: Jugadores 
% DobbleGame: Juego Dobble
% ---Predicados---
% getPlayers(DobbleGame,Players)
% ---Metas---
% Principales: getPlayers
% ---Cláusula---:
% Regla: Selector retorna los jugadores 
getPlayers([_,Players,_,_,_,_,_],Players).

% ---Dominios---
% Username:string
% Players: Lista de Jugadores
% Player: Jugador 
% ---Predicados---
% getPlayer(Players,Username,Player)
% ---Metas---
% Principales: getPlayer
% ---Cláusula---:
% Regla: Selector Obtiene un jugador dado un nombre de usuario
getPlayer([],_,_).
getPlayer([[Username,Cards,Points]|_],Username,[Username,Cards,Points]):-!.
getPlayer([_|Players],Username,Player):-
  getPlayer(Players,Username,Player).

% ---Dominios---
% CardsSet: Lista de Cartas
% DobbleGame: Juego Dobble
% ---Predicados---
% getCardsSet(DobbleGame,CardsSet)
% ---Metas---
% Principales: getCardsSet
% ---Cláusula---:
% Regla: Selector Obtiene Mazo de Cartas del Juego
getCardsSet([_,_,CardsSet,_,_,_,_],CardsSet).

% ---Dominios---
% Mode: string
% DobbleGame: Juego Dobble
% ---Predicados---
% getMode(DobbleGame,Mode)
% ---Metas---
% Principales: getMode
% ---Cláusula---:
% Regla: Selector Obtiene el modo de juego
getMode([_,_,_,Mode,_,_,_],Mode).

% ---Dominios---
% CardsZone: Lista de Cartas
% DobbleGame: Juego Dobble
% ---Predicados---
% getCardsZone(DobbleGame,CardsZone)
% ---Metas---
% Principales: getCardsZone
% ---Cláusula---:
% Regla: Selector Obtiene la zona del juego donde estan las cartas volteadas boca arriba 
getCardsZone([_,_,_,_,CardsZone,_,_],CardsZone).

% ---Dominios---
% State: Estado del Juego
% DobbleGame: Juego Dobble
% ---Predicados---
% getGameStatus(DobbleGame,State)
% ---Metas---
% Principales: getGameStatus
% ---Cláusula---:
% Regla: Selector Obtiene el estado del juego 
getGameStatus([_,_,_,_,_,State,_],State).

% ---Dominios---
% Player: Jugador
% Cards: Lista de Cartas
% ---Predicados---
% getPlayerCards(Player,Cards)
% ---Metas---
% Principales: getPlayerCards
% ---Cláusula---:
% Regla: Selector Obtiene las cartas del jugador
getPlayerCards([_,Cards,_],Cards).

% ---Dominios---
% Username:string
% RestDobbleGame: CardsSet X Mode X CardsZone X State X Turns
% ---Predicados---
% addTurn(Username,DobbleGame)
% ---Metas---
% Principales: addTurn
% ---Cláusula---:
% Regla: Helper agrega el turno del jugador al juego
addTurn(Username,[CardsSet,Mode,InitialCardsZone,InitialState,[]],
  [CardsSet,Mode,InitialCardsZone,InitialState,[Username]]).
addTurn(Username,[CardsSet,Mode,InitialCardsZone,InitialState,Turns],
  [CardsSet,Mode,InitialCardsZone,InitialState,[Username|Turns]]).
 

% ---Dominios---
% FirstCard, SecondCard: Lista de Elementos
% Element: Elemento o Símbolo
% ---Predicados---
% getElementInCommonBetweenTwoCards(FirstCard,SecondCard,Element)
% ---Metas---
% Principales: getElementInCommonBetweenTwoCards
% ---Cláusula---:
% Regla: Helper obtiene el elemento en común entre 2 cartas
getElementInCommonBetweenTwoCards(FirstCard,SecondCard,Element):-
  intersection(FirstCard,SecondCard,Element).



% ---Dominios---
% DobbleGame, NewDobbleGame: Juego de Dobble
% ---Predicados---
% setTurnsGame(DobbleGame,NewDobbleGame)
% ---Metas---
% Principales: setTurnsGame
% ---Cláusula---:
% Regla: Modificador Actuliza los turnos del juego
setTurnsGame([NumberOfPlayers,Players,CardsSet,Mode,CardsZone,State,[FirstTurn|Turns]],
  [NumberOfPlayers,Players,CardsSet,Mode,CardsZone,State,NewTurns]):-
    append(Turns,[FirstTurn],NewTurns).

 
setStatusGame([NumberOfPlayers,Players,CardsSet,Mode,CardsZone,_,Turns],NewStatus,
  [NumberOfPlayers,Players,CardsSet,Mode,CardsZone,NewStatus,Turns]).


% ---Dominios---
% NewCards: Lista de Cartas
% Player, NewPlayer: Jugador 
% ---Predicados---
% setPlayerCards(Player,NewCards,NewPlayer)
% ---Metas---
% Principales: setPlayerCards
% ---Cláusula---:
% Regla: Modificador Actualiza las Cartas de un jugador 
setPlayerCards([Username,[],Points],NewCards,[Username,NewCards,Points]).
setPlayerCards([Username,Cards,Points],NewCards,[Username,TotalCards,Points]):-
 append(Cards,NewCards,TotalCards).


% ---Dominios---
% Player, NewPlayer: Jugador 
% ---Predicados---
% setPlayerPoints(Player,NewPlayer)
% ---Metas---
% Principales: setPlayerPoints
% ---Cláusula---:
% Regla: Modificador Actualiza el puntaje actual del jugador
setPlayerPoints([Username,Cards,Points],[Username,Cards,TotalPoints]):-
  length(Cards,TotalPoints).

% ---Dominios---
% Players,NewPlayers: Lista de jugadores
% Player: Jugador 
% ---Predicados---
% setPlayers(Players,NewPlayer,NewPlayers)
% ---Metas---
% Principales: setPlayers
% ---Cláusula---:
% Regla: Modificador Actualiza un jugador en especifico en las lista de jugadores
setPlayers([],_,_).
setPlayers([[Username,_,_]|Players],[Username,Cards,Points], [[Username,Cards,Points]|Players]):-!.
setPlayers([Player|Players],NewPlayer,[Player|NewPlayers]):- 
  setPlayers(Players,NewPlayer,NewPlayers).

% ---Dominios---
% Players: Lista de jugadores
% DobbleGame,NewDobbleGame: Juego Dobble
% ---Predicados---
% setPlayersGame(DobbleGame,Players,NewDobbleGame)
% ---Metas---
% Principales: setPlayersGame
% ---Cláusula---:
% Regla: Modificador Actualiza los jugadores del juego
setPlayersGame([NumberOfPlayers,_,CardsSet,Mode,CardsZone,State,Turns],Players,
  [NumberOfPlayers,Players,CardsSet,Mode,CardsZone,State,Turns]).

% ---Dominios---
% DobbleGame,NewDobbleGame: Juego Dobble
% ---Predicados---
% removeCards(DobbleGame,Players,NewDobbleGame)
% ---Metas---
% Principales: removeCards
% ---Cláusula---:
% Regla: Helper remueve las cartas de la cima del mazo
removeCards([NumberOfPlayers,Players,[FirstCard,SecondCards|CardsSet],Mode,CardsZone,State,Turns],
  [NumberOfPlayers,Players,CardsSet,Mode,CardsZone,State,Turns]).

canKeepPlaying(DobbleGame):-
  getGameStatus(DobbleGame,Status),
  Status = "En Partida"; Status = "Juego Creado".

% ---Dominios---
% DobbleGame,NewDobbleGame: Juego Dobble
% ---Predicados---
% removeCards(DobbleGame,Players,NewDobbleGame)
% ---Metas---
% Principales: removeCards
% ---Cláusula---:
% Regla: Helper remueve las cartas de la cima del mazo
cleanCardsZone([NumberOfPlayers,Players,CardsSet,Mode,_,State,Turns],
  [NumberOfPlayers,Players,CardsSet,Mode,[],State,Turns]).

moveCardsToFinal([NumberOfPlayers,Players,[FirstCard,SecondCard|CardsSet],Mode,CardsZone,State,Turns],
  [NumberOfPlayers,Players,NewCardsSet,Mode,CardsZone,State,Turns]):-
  append(CardsSet,[FirstCard,SecondCard],NewCardsSet).

%Regla: Helper Obtener de quien es el turno
dobbleGameWhoseTurnIsIt(DobbleGame,FirstTurn):-
 getTurns(DobbleGame,[FirstTurn|_]).
 
dobbleGamePlay(DobbleGame,null,NewDobbleGame):-
 canKeepPlaying(DobbleGame),
 setStatusGame(DobbleGame,"En Partida",NewDobbleGame1),
 getMode(NewDobbleGame1,Mode),
 mode(Mode,NewDobbleGame1,NewDobbleGame).

dobbleGamePlay(DobbleGame,[spotit,Username,Element],NewDobbleGame):-
 getMode(DobbleGame,Mode),
 action(spotit,Username,Element,DobbleGame,NewDobbleGame).

dobbleGamePlay(DobbleGame,[pass],NewDobbleGame):-
  action(pass,_,_,DobbleGame,NewDobbleGame).
  
dobbleGamePlay(DobbleGame,[finish],NewDobbleGame):-
  action(finish,_,_,DobbleGame,NewDobbleGame).
  
%TDA: StackMode 
mode("stack",DobbleGame,NewDobbleGame):-
  getCardsSet(DobbleGame,[FirstCard,SecondCard|_]),
  setCardsZoneStackMode(FirstCard,SecondCard,DobbleGame,NewDobbleGame).   


% ---Dominios---
% FirstCard, SecondCard: Lista de Elementos
% DobbleGame: 
% ---Predicados---
% setCardsZoneStackMode(FirstCard,SecondCard,Element)
% ---Metas---
% Principales: setCardsZoneStackMode
% ---Cláusula---:
% Regla: Helper obtiene el elemento en común entre 2 cartas
setCardsZoneStackMode(FirstCard,SecondCard,[NumberOfPlayers,Players,CardsSet,Mode,_,State,Turns]
  ,[NumberOfPlayers,Players,CardsSet,Mode,[FirstCard,SecondCard],State,Turns]).


% spotit
action(spotit,Username,Element,DobbleGame,NewDobbleGame):-
 getCardsZone(DobbleGame,[FirstCard,SecondCard]),
 getElementInCommonBetweenTwoCards(FirstCard,SecondCard,[CommonElement]),
 Element = CommonElement ->
  getPlayers(DobbleGame,Players),
  getPlayer(Players,Username,Player),
  setPlayerCards(Player,[FirstCard,SecondCard],PlayerNewCards),
  setPlayerPoints(PlayerNewCards,PlayerNewPoints),
  setPlayers(Players,PlayerNewPoints,NewPlayers),
  setPlayersGame(DobbleGame,NewPlayers,NewDobbleGame1),
  setTurnsGame(NewDobbleGame1,NewDobbleGame2),
  removeCards(NewDobbleGame2,NewDobbleGame3),
  cleanCardsZone(NewDobbleGame3,NewDobbleGame);
  %-------------------------------------------
  moveCardsToFinal(DobbleGame,NewDobbleGame1),
  setTurnsGame(NewDobbleGame1,NewDobbleGame2),
  cleanCardsZone(NewDobbleGame2,NewDobbleGame).

% Pass
action(pass,_,_,DobbleGame,NewDobbleGame):-
  moveCardsToFinal(DobbleGame,NewDobbleGame1),
  setTurnsGame(NewDobbleGame1,NewDobbleGame2),
  cleanCardsZone(NewDobbleGame2,NewDobbleGame).


action(finish,_,_,DobbleGame,NewDobbleGame):-
  setStatusGame(DobbleGame,"finalizado",NewDobbleGame).



% getWinnerAndLosers(DobbleGame):-
 



  



