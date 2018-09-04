%%%
%%% AGENDA SEPARATION
%%%

#include "../ja.lp".

% generate a partition
% (where none of the partitioning sets are empty)
side(1;2).
part(1,X); part(2,X) :- issue(X).
:- part(1,X), part(2,X), issue(X).
part(S,-X) :- issue(X), part(S,X), side(S).
:- side(S), part(S,X) : issue(X).
ipart(S,X) :- issue(X), part(S,X), side(S).
#show ipart/2.
% verify that this partition separates the agenda, using saturation (see Eiter, Gottlob '95)
w :- not w.
virtual(S,X) :- lit(X), w, side(S).
% guess a virtual assignment
virtual(S,X) ; virtual(S,-X) :- var(X), side(S).
% remove virtual assignments that are contradictory
w :- var(X), virtual(S,X), virtual(S,-X), side(S).
% remove virtual assignments that do not satisfy the integrity constraint
w :- clause(C), side(S), virtual(S,-L) : clause(C,L).
% remove virtual assignments whose combination (according to the guessed partition)
% *does* satisfy the integrity constraint
w(C) :- clause(C,L), part(S,L), virtual(S,L), side(S).
w :- w(C) : clause(C).
w(C) :- w, clause(C).
