%%%
%%% UNIFORM QUOTA (WITH COMPLETION)
%%%
% fix the quota (the absolute # of voters needed to accept an issue)
%#const quota=2.
% require that the collective outcome agrees with all issues
% that have at least the quota as support
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- lit(X), pc(X,N), N >= quota.
js(col,X) :- maj(X).
