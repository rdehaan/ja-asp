%%%
%%% RA-PARALLEL
%%%

#include "windet.lp".

% determine support for each literal
pc(X,N) :- lit(X), N = #count { A : voter(A), js(A,X) }.
% guess an order over all literals that is consistent with order of support
1 { order(X,Y) : litnum(Y) } 1 :- lit(X).
1 { order(X,Y) : lit(X) } 1 :- litnum(Y).
:- order(X1,Y1), order(X2,Y2), pc(X1,N1), pc(X2,N2), N1 > N2, Y1 > Y2.
% use saturation (see Eiter, Gottlob '95)
w(W) :- not w(W), litnum(W).
virtual(W,X) :- lit(X), w(W).
% guess a virtual assignment
virtual(W,X) ; virtual(W,-X) :- issue(X), litnum(W).
% remove virtual assignments that are contradictory
w(W) :- issue(X), virtual(W,X), virtual(W,-X).
% remove virtual assignments that don't satisfy the integrity constraint
w(W) :- clause(C), litnum(W), virtual(W,-L) : clause(C,L).
% remove virtual assignments for those literals whose complements are before in the order
w(W) :- order(X,W), order(-X,Y), Y <= W.
% remove virtual assignments for those literals that agree with the collective outcome
w(W) :- litnum(W), order(X,W), js(col,X).
% remove virtual assignments that don't agree with the collective outcome
% on lower ordered literals
w(W) :- litnum(W), order(X,Y), Y < W, js(col,X), virtual(W,-X).
% remove virtual assignments that agree with the corresponding literal
w(W) :- litnum(W), order(X,W), virtual(W,-X).
