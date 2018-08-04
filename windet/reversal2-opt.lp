%%%
%%% REVERSAL SCORING
%%%

#include "windet.lp".

% mark that this is an optimization problem (for pretty printing).
optimization.
% for each voter A and each literal X, create a virtual agent virtual(A,X)
% (with its own judgment set)
agent(virtual(A,X)) :- voter(A), ilit(X), js(A,X).
% require that virtual(A,X) has -X in its judgment set
js(virtual(A,X),-X) :- agent(virtual(A,X)).
% determine for which literals Y, virtual(A,X) disagrees with A
% and take sum of disagreement per virtual(A,X)
disagree(A,X,Y) :- voter(A), ilit(X), ilit(Y), js(A,Y), js(virtual(A,X),-Y).
agree(A,X,Y) :- not disagree(A,X,Y), voter(A), ilit(X), ilit(Y).
%disagreement(A,X,D) :- voter(A), lit(X), D = #count { Y : disagree(A,X,Y) }.
%%% firstly minimize total disagreement (at high priority level)
#minimize { 1@20,disagree(A,X,Y) : disagree(A,X,Y) }.
%%% maximize the score for voter A on literal X (w.r.t. the collective outcome)
%%% -- this is the total disagreement between the judgment sets of A and virtual(A,X) --
%%% (at lower priority level)
#minimize { 1@10,agree(A,X,Y) : js(col,X), agree(A,X,Y), ilit(Y) }.
