%
% This is the example from Figure 4.1 from the Handbook of Computational Social Choice
%

% preference agenda
candidate(a;b;c).
issue(p(X,Y)) :- candidate(X), candidate(Y), X != Y.
clause(c(1,X,Y),(p(X,Y);p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(2,X,Y),(-p(X,Y);-p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(3,X,Y,Z),(-p(X,Y);-p(Y,Z);p(X,Z))) :- candidate(X), candidate(Y), candidate(Z), X != Y, Y != Z, X != Z.

% profile
voter(1..3).
js(1,(p(a,b);p(b,c))).
js(2,(p(b,c);p(c,a))).
js(3,(p(c,a);p(a,b))).
