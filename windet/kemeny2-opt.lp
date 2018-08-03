%%%
%%% GENERAL SCORING (KEMENY)
%%%
% determine score for each voter A and each literal X
% (1 if A has X in their judgment set; 0 otherwise)
score(A,X,D) :- voter(A), lit(X), D=1, js(A,X), js(col,X).
% sum scores over all agents and all literals
score(E) :- E = #sum { D,score(A,X,D) : score(A,X,D) }.
% maximize the total score
#maximize { E@10,score(E) : score(E) }.
