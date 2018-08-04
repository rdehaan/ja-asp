%%%
%%% OVERLAPPING AGENDA SEPARATION
%%%

#include "../ja.lp".

% generate an overlapping decomposition
% (where none of the partitioning sets are empty)
% (and none of the partitioning sets includes the other)
{ ipart1(X) } :- issue(X).
{ ipart2(X) } :- issue(X).
part1(X) :- issue(X), ipart1(X).
part2(X) :- issue(X), ipart2(X).
part1(-X) :- issue(X), ipart1(X).
part2(-X) :- issue(X), ipart2(X).
:- issue(X), not ipart1(X), not ipart2(X).
:- ipart1(X) : issue(X), ipart2(X).
:- ipart2(X) : issue(X), ipart1(X).
:- not ipart1(X) : issue(X).
:- not ipart2(X) : issue(X).
#show ipart1/1.
#show ipart2/1.
% verify that this overlapping decomposition separates the agenda,
% using saturation (see Eiter, Gottlob '95)
w :- not w.
virtual1(X) :- lit(X), w.
virtual2(X) :- lit(X), w.
% guess a virtual assignment
virtual1(X) ; virtual1(-X) :- var(X).
virtual2(X) ; virtual2(-X) :- var(X).
% remove virtual assignments that are contradictory
w :- var(X), virtual1(X), virtual1(-X).
w :- var(X), virtual2(X), virtual2(-X).
% remove virtual assignments that do not satisfy the integrity constraint
w :- clause(C), virtual1(-L) : clause(C,L).
w :- clause(C), virtual2(-L) : clause(C,L).
% remove virtual assignments that disagree on those issues that are
% in both parts of the overlapping decomposition
w :- lit(X), part1(X), part2(X), virtual1(X), virtual2(-X).
% remove virtual assignments whose combination (according to the guessed decomposition)
% *does* satisfy the integrity constraint
w(C) :- clause(C,L), part1(L), virtual1(L).
w(C) :- clause(C,L), part2(L), virtual2(L).
w :- w(C) : clause(C).
w(C) :- w, clause(C).
