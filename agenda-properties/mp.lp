%%%
%%% AGENDA NON-SAFETY -- NOT 2-MEDIAN-PROPERTY
%%%

#include "../ja.lp".

#const k=2.
% generate a partial assignment
0 { assign(X); assign(-X) } 1 :- ilit(X).
#show assign/1.
% verify that it is inconsistent, using saturation (see Eiter, Gottlob '95)
w :- not w.
virtual(X) :- lit(X), w.
% guess a virtual assignment
virtual(X) ; virtual(-X) :- var(X).
% remove virtual assignments that are contradictory
w :- var(X), virtual(X), virtual(-X).
% remove virtual assignments that don't satisfy the integrity constraint
w :- clause(C), virtual(-L) : clause(C,L).
% remove virtual assignments that agree with guessed partial assignment
w :- ilit(X), assign(X), virtual(-X).
% verify that it is minimally inconsistent;
% by guessing a satisfying truth assignment for each strict subset (of size one smaller)
agent(vagent(X)) :- assign(X), ilit(X).
js(vagent(Y),X) :- agent(vagent(Y)), ilit(X), assign(X), Y != X.
% require that a minimal assignment gives a value to at least k+1 issue literals
k+1 { assign(X) : ilit(X) }.
% if some minimally inconsistent assignments remain,
% the agenda does not satisfy the k-median property
