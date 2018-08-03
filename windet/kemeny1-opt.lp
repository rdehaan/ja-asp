%%%
%%% MED = KEMENY
%%%
% determine support for each literal
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
% maximize the agreement with literals, weighted by their support
#maximize { N@10,pc(X,N) : pc(X,N), js(col,X) }.
%:~ pc(X,N), not js(col,X). [N@1,pc(X,N)] % alternative way of writing the maximization
