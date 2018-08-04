%%%
%%% YOUNG
%%%

#include "windet.lp".

% for each voter, guess whether they are 'in' or 'out'
in(A) :- voter(A), not out(A).
out(A) :- voter(A), not in(A).
% determine the majority w.r.t. the 'in' voters
inpc(X,N) :- lit(X), N = #count { A : voter(A), in(A), js(A,X) }.
inmaj(X) :- lit(X), inpc(X,N), inpc(-X,M), N > M.
% require that the outcome agrees with 'in'-majority
js(col,X) :- inmaj(X).
%%% to get the variant with strict majority
%:- lit(X), not inmaj(X), not inmaj(-X).
%:- lit(X), inpc(X,N), inpc(-X,N).
% maximize the # of voters that are 'in'
#maximize { 1@10,in(A) : in(A) }.
