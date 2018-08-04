%%%
%%% MNAC = MPC
%%%

#include "windet.lp".

% add a virtual agent for each voter (with its own judgment set)
agent(virtual(A)) :- voter(A).
% require that the outcome is the majority outcome of the virtual profile
vpc(X,N) :- ilit(X), N = #count { A : voter(A), js(virtual(A),X) }.
vmaj(X) :- ilit(X), vpc(X,N), vpc(-X,M), N > M.
js(col,X) :- vmaj(X).
% minimize the disagreement between the real and the virtual profile
vdisagree(A,X) :- ilit(X), voter(A), js(A,X), js(virtual(A),-X).
_criteria(0,1,vdisagree(A,X)) :- vdisagree(A,X).
_optimize(0,1,card).
#show _criteria/3.
#show _optimize/3.
