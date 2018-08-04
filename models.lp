%%%
%%% GENERATE ALL COMPLETE AND CONSISTENT JUDGMENT SETS
%%%

#include "ja.lp".

% generate a collective outcome
agent(judgment).

% auxiliary predicate to refer to the collective outcome
judgment(X) :- js(judgment,X), ilit(X).

% show only the collective outcome
#show judgment/1.
