%%%
%%% YOUNG
%%%

#include "windet.lp".

% for each voter, guess whether they are 'in' or 'out'
in(A) :- voter(A), not out(A).
out(A) :- voter(A), not in(A).
% determine the majority w.r.t. the 'in' voters
inpc(X,N) :- ilit(X), N = #count { A : voter(A), in(A), js(A,X) }.
inmaj(X) :- ilit(X), inpc(X,N), inpc(-X,M), N > M.
% require that the outcome agrees with 'in'-majority
js(col,X) :- inmaj(X).
%%% to get the variant with strict majority
%:- lit(X), not inmaj(X), not inmaj(-X).
%:- lit(X), inpc(X,N), inpc(-X,N).
% minimize the # of voters that are 'out'
_criteria(0,1,out(A)) :- out(A).
_optimize(0,1,card).
#show _criteria/3.
#show _optimize/3.
