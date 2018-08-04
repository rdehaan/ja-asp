%%%
%%% MCSA = MCC = SLATER
%%%

#include "windet.lp".

% mark that this is an optimization problem (for pretty printing).
optimization.
% determine the majority outcome
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- ilit(X), pc(X,N), pc(-X,M), N > M.
% maximize agreement with the majority outcome
#minimize { 1@10,maj(X) : maj(X), js(col,-X) }.
%:~ maj(X), not js(col,X). [1@1,X] % alternative way of writing the maximization
