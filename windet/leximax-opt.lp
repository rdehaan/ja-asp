%%%
%%% RA-LEXIMAX
%%%

#include "windet.lp".

% mark that this is an optimization problem (for pretty printing).
optimization.
% determine support for each issue literal
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.
% maximize agreement with the issue literals on different priority levels;
% for each literal X, agreeing with X is prioritized on level N,
% where N is the support for X
% (higher levels have more priority)
#minimize { 1@N,pc(X,N) : pc(X,N), js(col,-X) }.
%:~ pc(X,N), js(col,-X). [N@1,pc(X,N)] % alternative way of writing the maximization
