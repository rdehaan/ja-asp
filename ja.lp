%%%
%%% ENCODING OF THE BASIC JA SETTING
%%%

% generate literals over all issues
lit(X) :- issue(X).
lit(-X) :- issue(X).

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

% constraint consistency (DNF)
%:- agent(A), termfalse(T,A) : term(T,_).
%termfalse(T,A) :- term(T,L), js(A,-L).
