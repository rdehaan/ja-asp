%%%
%%% MAJORITY
%%%

#include "windet.lp".

% require that the collective outcome agrees with all issues
% that have strictly more support than their negation
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- lit(X), pc(X,N), pc(-X,M), N > M.
js(col,X) :- maj(X).
