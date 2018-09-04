%%%
%%% NEAR UNIDIMENSIONAL ALIGNMENT:
%%% maximizing the number of voters for which the corresponding subprofile is unidimensionally aligned
%%%

#include "../ja.lp".

% guess a set of voters
{ in(A) } :- voter(A).
out(A) :- voter(A), not in(A).
% guess an ordering of the guessed set of voters
numin(D) :- D = #count { in(A) : in(A) }.
innum(N) :- voternum(N), numin(D), N <= D.
1 { order(A,Y) : innum(Y) } 1 :- in(A).
1 { order(A,Y) : in(A) } 1 :- innum(Y).
% mark all issues that do not match single crossing property
notunidim(I) :- ilit(I),
  js(A1,I), js(A2,-I), js(A3,I),
  order(A1,P1), order(A2,P2), order(A3,P3),
  P1 < P2, P2 < P3.
% require that all issues are single crossing
:- notunidim(I).
% maximize the number of voters selected
_criteria(0,1,out(A)) :- out(A).
_optimize(0,1,card).
#show _criteria/3.
#show _optimize/3.

#show order/2.
#show in/1.
