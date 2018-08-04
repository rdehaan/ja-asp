%%%
%%% AGENDA SEPARATION
%%%

#include "../ja.lp".

% generate a partition
% (where none of the partitioning sets are empty)
part1(X); part2(X) :- issue(X).
:- part1(X), part2(X), issue(X).
part1(-X) :- issue(X), part1(X).
part2(-X) :- issue(X), part2(X).
:- part1(X) : issue(X).
:- part2(X) : issue(X).
part(X) :- issue(X), part1(X).
#show part/1.
% verify that this partition separates the agenda, using saturation (see Eiter, Gottlob '95)
w :- not w.
virtual1(X) :- lit(X), w.
virtual2(X) :- lit(X), w.
% guess a virtual assignment
virtual1(X) ; virtual1(-X) :- issue(X).
virtual2(X) ; virtual2(-X) :- issue(X).
% remove virtual assignments that are contradictory
w :- issue(X), virtual1(X), virtual1(-X).
w :- issue(X), virtual2(X), virtual2(-X).
% remove virtual assignments that do not satisfy the integrity constraint
w :- clause(C), virtual1(-L) : clause(C,L).
w :- clause(C), virtual2(-L) : clause(C,L).
% remove virtual assignments whose combination (according to the guessed partition)
% *does* satisfy the integrity constraint
w(C) :- clause(C,L), part1(L), virtual1(L).
w(C) :- clause(C,L), part2(L), virtual2(L).
w :- w(C) : clause(C).
w(C) :- w, clause(C).
