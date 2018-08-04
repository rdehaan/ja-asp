%%%
%%% ENCODING OF THE BASIC JA SETTING
%%%

% generate literals over all issues
ilit(X) :- issue(X).
ilit(-X) :- issue(X).
lit(X) :- ilit(X).
% generate literals over all auxiliary variables
lit(X) :- aux(X).
lit(-X) :- aux(X).
% auxiliary predicate for variables
var(X) :- issue(X).
var(X) :- aux(X).

% auxiliary predicates for counting/identifying issues, literals, voters
numissues(N) :- N = #count { Z : issue(Z) }.
issuenum(1..N) :- numissues(N).

numlits(N) :- N = #count { Z : lit(Z) }.
litnum(1..N) :- numlits(N).

numvoters(N) :- N = #count { A : voter(A) }.
voternum(1..N) :- numvoters(N).

% auxiliary predicate for finding clauses
clause(C) :- clause(C,_).

% every voter is an agent
agent(A) :- voter(A).

% require that every agent has a judgment set
% + completeness (& negation-freeness)
1 { js(A,X); js(A,-X) } 1 :- agent(A), lit(X).

% constraint consistency (CNF)
:- agent(A), clause(C), js(A,-L) : clause(C,L).
