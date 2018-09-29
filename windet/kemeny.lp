%%%
%%% MED = KEMENY
%%%

#include "windet.lp".

% determine support for each issue literal
pc(X,N) :- ilit(X), N = #count { A : voter(A), js(A,X) }.

% use the technique of saturation (see Eiter & Gottlob '95)
w :- not w.
virtual(X) :- ilit(X), w.
% guess a virtual assignment
virtual(X) ; virtual(-X) :- var(X).
% remove virtual assignments that are contradictory
w :- var(X), virtual(X), virtual(-X).
% remove virtual assignments that don't satisfy integrity constraint
w :- clause(C), virtual(-L) : clause(C,L).

% order the variables alphabetically
1 { varorder(X,O) : varnum(O) } 1 :- var(X).
1 { varorder(X,O) : var(X) } 1 :- varnum(O).
:- varorder(X1,O1), varorder(X2,O2), X1 < X2, O1 > O2.

% order the voters alphabetically
1 { voterorder(A,O) : voternum(O) } 1 :- voter(A).
1 { voterorder(A,O) : voter(A) } 1 :- voternum(O).
:- voterorder(A1,O1), voterorder(A2,O2), A1 < A2, O1 > O2.

% compute the distance from the virtual assignment to the profile
% virtdist(Var,Voter,Ans)
virtdist(0,N,0) :- numvoters(N).
virtdist(Xn,An,C) :-
  varnum(Xn), varorder(X,Xn),
  voternum(An), voterorder(A,An),
  virtdist(Xn,An-1,C), virtual(X), js(A,X).
virtdist(Xn,An,C) :-
  varnum(Xn), varorder(X,Xn),
  voternum(An), voterorder(A,An),
  virtdist(Xn,An-1,D), C = D+1, virtual(X), js(A,-X).
virtdist(Xn,An,C) :-
  varnum(Xn), varorder(X,Xn),
  voternum(An), voterorder(A,An),
  virtdist(Xn,An-1,C), virtual(-X), js(A,-X).
virtdist(Xn,An,C) :-
  varnum(Xn), varorder(X,Xn),
  voternum(An), voterorder(A,An),
  virtdist(Xn,An-1,D), C = D+1, virtual(-X), js(A,X).
virtdist(Xn,0,C) :- varnum(Xn), numvoters(N), virtdist(Xn-1,N,C).
virtdist(D) :- virtdist(M,N,D), numvars(M), numvoters(N).
% saturate all virtdist/3 in case w is derived
%virtdist(0..M,0..N,0..C) :- w, numvars(M), numvoters(N), C = N*M.
virtdist(Xn,An,0..C) :- w, varnum(Xn), voternum(An), numvars(M), C = M*Xn.

% compute the distance from the collective assignment to the profile
coldist(D) :- D = #sum { N,pc(X,N) : js(col,-X), pc(X,N) }.

% remove virtual assignments that have distance at least that of the collective outcome
w :- virtdist(D1), coldist(D2), D1 >= D2.
