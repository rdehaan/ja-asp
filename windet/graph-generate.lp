%%%
%%% GENERATING THE GRAPH OF ALL COMPLETE & CONSISTENT JUDGMENT SETS
%%%

% generate the set of all (exponentially many) possible nodes
posnode(0..2**N-1) :- numvars(N).
bit(0..N-1) :- numvars(N).

% compute the bit values of the numbers of the possible nodes
bitcomp(B,N,0) :- bit(B), posnode(N), restcomp(B,N,R), D = ((N-R)/(2**B)), even(D).
bitcomp(B,N,1) :- bit(B), posnode(N), restcomp(B,N,R), D = ((N-R)/(2**B)), not even(D).
restcomp(B,N,R) :- bit(B), posnode(N), R = N-((N/(2**B))*(2**B)).
even(N) :- posnode(N), (N/2)*2 = N.

% order the variables alphabetically
1 { varorder(X,O) : varnum(O) } 1 :- var(X).
1 { varorder(X,O) : var(X) } 1 :- varnum(O).
:- varorder(X1,O1), varorder(X2,O2), X1 < X2, O1 > O2.

% select which of the possible nodes are *actual* nodes in the graph
nodelit(N,X) :- posnode(N), var(X), varorder(X,O), bitcomp(O-1,N,1).
nodelit(N,-X) :- posnode(N), var(X), varorder(X,O), bitcomp(O-1,N,0).
nodesat(N,C) :- posnode(N), clause(C,L), nodelit(N,L).
node(N) :- posnode(N), nodesat(N,C) : clause(C).
