%%%
%%% MC = MSA -- META-PROGRAMMING VERSION
%%%
% determine the majority outcome
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- lit(X), pc(X,N), pc(-X,M), N > M.
majdisagree(X) :- lit(X), maj(X), js(col,-X).
% inclusion minimize disagreement with the majority outcome
_criteria(0,1,X) :- majdisagree(X).
_optimize(0,1,incl).
#show _criteria/3.
#show _optimize/3.
