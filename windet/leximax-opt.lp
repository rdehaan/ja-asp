%%%
%%% RA-LEXIMAX
%%%

#include "windet.lp".

% determine support for each literal
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
% maximize agreement with the literals on different priority levels;
% for each literal X, agreeing with X is prioritized on level N,
% where N is the support for X
% (higher levels have more priority)
#maximize { 1@N,pc(X,N) : pc(X,N), js(col,X) }.
%:~ pc(X,N), not js(col,X). [N@1,pc(X,N)] % alternative way of writing the maximization
