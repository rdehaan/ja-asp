%%%
%%% MCSA = MCC = SLATER
%%%
% determine the majority outcome
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- lit(X), pc(X,N), pc(-X,M), N > M.
% maximize agreement with the majority outcome
#maximize { 1@10,maj(X) : maj(X), js(col,X) }.
%:~ maj(X), not js(col,X). [1@1,X] % alternative way of writing the maximization
