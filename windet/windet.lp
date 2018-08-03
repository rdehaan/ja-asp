%%%
%%% BASIC ENCODING OF THE WINNER DETERMINATION PROBLEM
%%%

% generate a collective outcome
agent(col).

% auxiliary predicate to refer to the collective outcome
collective(X) :- js(col,X).

% show only the collective outcome
#show collective/1.
