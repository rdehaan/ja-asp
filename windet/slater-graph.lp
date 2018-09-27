%%%
%%% MCSA = MCC = SLATER -- JS GRAPH VERSION
%%%

#include "windet.lp".
#include "graph-generate.lp".

% determine majority outcome
pc(L,D) :- ilit(L), D = #count { A : voter(A), js(A,L) }.
maj(X) :- ilit(X), pc(X,N), pc(-X,M), N > M.

% compute score for each node
nodescore(N,S) :- node(N), S = #count { 1,L : nodelit(N,L), maj(L) }.

% compute maximal score
maxscore(M) :- M = #max { S : nodescore(N,S) }.

% choose exactly one node as winner
1 { choosenode(N) : node(N), nodescore(N,M) } 1 :- maxscore(M).

% ensure that the collective judgment set agrees with the chosen node
js(col,L) :- choosenode(N), nodelit(N,L).
