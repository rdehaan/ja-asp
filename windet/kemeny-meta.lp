%%%
%%% KEMENY -- META-PROGRAMMING VERSION
%%%

#include "windet.lp".

% determine disagreement for each voter A and each literal X
disagree(A,X,1) :- voter(A), lit(X), js(A,X), js(col,-X).
% minimize total disagreement
_criteria(0,1,disagree(A,X,1)) :- disagree(A,X,1).
_optimize(0,1,card).
#show _criteria/3.
#show _optimize/3.
