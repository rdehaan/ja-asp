%%%
%%% MCSA = MCC = SLATER -- META-PROGRAMMING VERSION
%%%

#include "windet.lp".

% determine the majority outcome
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- ilit(X), pc(X,N), pc(-X,M), N > M.
majdisagree(X) :- ilit(X), maj(X), js(col,-X).
% inclusion minimize disagreement with the majority outcome
_criteria(0,1,X) :- majdisagree(X).
_optimize(0,1,card).
#show _criteria/3.
#show _optimize/3.
