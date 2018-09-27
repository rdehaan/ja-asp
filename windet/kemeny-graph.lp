%%%
%%% MED = KEMENY -- JS GRAPH VERSION
%%%

#include "windet.lp".
#include "graph-generate.lp".

% determine support for each issue literal
pc(L,D) :- ilit(L), D = #count { A : voter(A), js(A,L) }.

% compute score for each node
nodescore(N,L,D) :- nodelit(N,L), pc(L,D).
nodescore(N,S) :- node(N), S = #sum { D,L : nodescore(N,L,D) }.

% compute maximal score
maxscore(M) :- M = #max { S : nodescore(N,S) }.

% choose exactly one node as winner
1 { choosenode(N) : node(N), nodescore(N,M) } 1 :- maxscore(M).

% ensure that the collective judgment set agrees with the chosen node
js(col,L) :- choosenode(N), nodelit(N,L).
