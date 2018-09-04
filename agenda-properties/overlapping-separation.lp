%%%
%%% OVERLAPPING AGENDA SEPARATION
%%%

#include "../ja.lp".

% generate an overlapping decomposition
% (where none of the partitioning sets are empty)
% (and none of the partitioning sets includes the other)
side(1;2).
{ ipart(S,X) } :- issue(X), side(S).
part(S,X) :- issue(X), ipart(S,X), side(S).
part(S,-X) :- issue(X), ipart(S,X), side(S).
:- issue(X), not ipart(1,X), not ipart(2,X).
:- ipart(1,X) : issue(X), ipart(2,X).
:- ipart(2,X) : issue(X), ipart(1,X).
:- side(S), not ipart(S,X) : issue(X).
#show ipart/2.
% verify that this overlapping decomposition separates the agenda,
% using saturation (see Eiter, Gottlob '95)
w :- not w.
virtual(S,X) :- lit(X), w, side(S).
% guess a virtual assignment
virtual(S,X) ; virtual(S,-X) :- var(X), side(S).
% remove virtual assignments that are contradictory
w :- var(X), virtual(S,X), virtual(S,-X), side(S).
% remove virtual assignments that do not satisfy the integrity constraint
w :- side(S), clause(C), virtual(S,-L) : clause(C,L).
% remove virtual assignments that disagree on those issues that are
% in both parts of the overlapping decomposition
w :- lit(X), part(1,X), part(2,X), virtual(1,X), virtual(2,-X).
% remove virtual assignments whose combination (according to the guessed decomposition)
% *does* satisfy the integrity constraint
w(C) :- clause(C,L), part(S,L), virtual(S,L), side(S).
w :- w(C) : clause(C).
w(C) :- w, clause(C).
