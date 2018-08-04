%%%
%%% RA-LEXIMAX
%%%

#include "windet.lp".

% determine support for each literal
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.
% maximize agreement with the literals on different priority levels;
% for each literal X, agreeing with X is prioritized on level N,
% where N is the support for X
% (higher levels have more priority)
_criteria(N,1,pc(X,N)) :- pc(X,N), js(col,-X).
_optimize(N,1,card) :- pc(X,N).
#show _criteria/3.
#show _optimize/3.
