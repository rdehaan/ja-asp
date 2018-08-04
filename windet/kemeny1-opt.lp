%%%
%%% MED = KEMENY
%%%

#include "windet.lp".

% mark that this is an optimization problem (for pretty printing).
optimization.
% determine support for each issue literal
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.
% maximize the agreement with issue literals, weighted by their support
#maximize { N@10,pc(X,N) : pc(X,N), js(col,X) }.
%:~ pc(X,N), not js(col,X). [N@1,pc(X,N)] % alternative way of writing the maximization
