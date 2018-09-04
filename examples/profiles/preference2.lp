%
% 
%

% preference agenda
candidate(a;b;c;d).
issue(p(X,Y)) :- candidate(X), candidate(Y), X != Y.
clause(c(1,X,Y),(p(X,Y);p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(2,X,Y),(-p(X,Y);-p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(3,X,Y,Z),(-p(X,Y);-p(Y,Z);p(X,Z))) :- candidate(X), candidate(Y), candidate(Z), X != Y, Y != Z, X != Z.

% profile
voter(1..9).
js((1..2),(p(a,b);p(b,c);p(c,d))).
js((3..4),(p(b,a);p(a,c);p(c,d))).
js((5..6),(p(b,c);p(c,a);p(a,d))).
js((7..8),(p(d,c);p(c,a);p(a,b))).
js(9,(p(d,c);p(c,a);p(a,b))).

winner(A) :- candidate(A), collective(p(A,B)) : candidate(B), A != B.
#show winner/1.
