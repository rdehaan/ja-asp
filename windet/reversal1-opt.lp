%%%
%%% REVERSAL SCORING
%%%
% for each voter A and each literal X, create a virtual agent virtual(A,X)
% (with its own judgment set)
agent(virtual(A,X)) :- voter(A), lit(X).
% require that virtual(A,X) has -X in its judgment set
js(virtual(A,X),-X) :- voter(A), lit(X), js(A,X).
% determine for which literals Y, virtual(A,X) disagrees with A
% and take sum of disagreement per virtual(A,X)
disagree(A,X,Y) :- voter(A), lit(X), lit(Y), js(A,Y), js(virtual(A,X),-Y).
disagreement(A,X,D) :- voter(A), lit(X), D = #count { Y : disagree(A,X,Y) }.
% firstly minimize total disagreement (at high priority level)
#minimize { D@20,disagreement(A,X,D) : disagreement(A,X,D) }.
%#minimize { 1@20,disagree(A,X,Y) : disagree(A,X,Y) }. % alternative way of writing minimization
% determine the score for voter A on literal X (w.r.t. the collective outcome)
% -- this is the total disagreement between the judgment sets of A and virtual(A,X) --
score(A,X,D) :- js(col,X), disagreement(A,X,D).
% sum scores over all agents and all literals
score(E) :- E = #sum { D,score(A,X,D) : score(A,X,D) }.
% maximize the total score (at lower priority level)
#maximize { E@10,score(E) : score(E) }.