%%%
%%% MC = MSA
%%%

#include "windet.lp".

% find the majority outcome
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.
maj(X) :- ilit(X), pc(X,N), pc(-X,M), N > M.
% mark which issues in the collective outcome agree with the majority
majagree(X) :- maj(X), js(col,X).
% use the technique of saturation (see Eiter & Gottlob '95)
w :- not w.
virtual(X) :- ilit(X), w.
% guess a virtual assignment
virtual(X) ; virtual(-X) :- var(X).
% remove virtual assignments that are contradictory
w :- var(X), virtual(X), virtual(-X).
% remove virtual assignments that don't satisfy integrity constraint
w :- clause(C), virtual(-L) : clause(C,L).
% mark which issues in virtual assignment agree with collective outcome
virtagree(X) :- issue(X), js(col,X), virtual(X).
virtagree(X) :- issue(X), js(col,-X), virtual(-X).
% remove virtual assignments that for some issue don't agree with majority
% where collective outcome does
w :- lit(X), majagree(X), virtual(-X).
% remove the virtual assignment that agrees with collective outcome on everything
w :- virtagree(X) : issue(X).
% it is only a stable set if no virtual assignments remain,
% that is, only if there is no virtual assignment that agrees with the majority
% on a strict subset of issues (w.r.t. the collective outcome)
