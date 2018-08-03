% preference agenda
#const m=10.
candidate(1..m).
issue(p(X,Y)) :- candidate(X), candidate(Y), X != Y.
clause(c(1,X,Y),(p(X,Y);p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(2,X,Y),(-p(X,Y);-p(Y,X))) :- candidate(X), candidate(Y), X != Y.
clause(c(3,X,Y,Z),(-p(X,Y);-p(Y,Z);p(X,Z))) :- candidate(X), candidate(Y), candidate(Z), X != Y, Y != Z, X != Z.
