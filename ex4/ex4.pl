/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).


% Signature: path(Node1, Node2, Path)/3
% Purpose: Path is a path, denoted by a list of nodes, from Node1 to Node2.
% Base case: the path from a node to itself.
  path(Node, Node, [Node]).
  path(Node1, Node2, [Node1 | Path]) :-
    edge(Node1, NodeNext),
    path(NodeNext, Node2, Path).



% Signature: cycle(Node, Cycle)/2
% Purpose: Cycle is a cyclic path, denoted a list of nodes, from Node1 to Node1.
  cycle(Node, [Node | Path]) :-
    path(Node, Node, Path),
    Path \= [].


% Signature: reverse(Graph1,Graph2)/2
% Purpose: The edges in Graph1 are reversed in Graph2
   reverse([], []).
   reverse([[X, Y]|Rest], [[Y, X]|Reversedrest]) :-
    reverse(Rest, Reversedrest).


% Signature: degree(Node, Graph, Degree)/3
% Purpose: Degree is the degree of node Node, denoted by a Church number (as defined in class)
degree(Node, Graph, Degree) :-
    findall(1, member([Node, _], Graph), List),
    church_number(List, Degree).

church_number([], zero).
church_number([_|T], s(N)) :- church_number(T, N).






