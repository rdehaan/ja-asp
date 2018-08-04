%%%
%%% BASIC ENCODING OF THE WINNER DETERMINATION PROBLEM
%%%

#include "../ja.lp".

% generate a collective outcome
agent(col).

% auxiliary predicate to refer to the collective outcome
collective(X) :- js(col,X), ilit(X).

% show only the collective outcome
#show collective/1.
