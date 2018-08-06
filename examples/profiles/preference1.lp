%
% This is the example from Figure 4.1 from the Handbook of Computational Social Choice
%

% preference agenda
#const m=10.
candidate(a;b;c;d;e).
issue(p(X,Y)) :- candidate(X), candidate(Y), X != Y.
clause(c(1,X,Y),(p(X,Y);p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(2,X,Y),(-p(X,Y);-p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(3,X,Y,Z),(-p(X,Y);-p(Y,Z);p(X,Z))) :- candidate(X), candidate(Y), candidate(Z), X != Y, Y != Z, X != Z.

% profile
voter(1..16).
js((1..3),(p(b,d);p(d,a);p(a,e);p(e,c))).
js((4..6),(p(d,a);p(a,c);p(c,e);p(e,b))).
js((7..10),(p(b,c);p(c,e);p(e,d);p(d,a))).
js((11..14),(p(a,e);p(e,c);p(c,d);p(d,b))).
js(15,(p(a,b);p(b,c);p(c,e);p(e,d))).
js(16,(p(e,c);p(c,d);p(d,a);p(a,b))).
