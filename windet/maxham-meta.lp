%%%
%%% MAX-HAMMING
%%%

#include "windet.lp".

% determine the Hamming distance from each voter's judgment set to the outcome
dist(A,D) :- voter(A), D = #count { X : ilit(X), js(col,X), js(A,-X) }.
% take the maximum distance (over all voters)
dist(E) :- E = #max { D,dist(A,D) : dist(A,D) }.
disttoken(F) :- issuenum(F), dist(E), F <= E.
% minimize the maximum distance
_criteria(0,1,disttoken(F)) :- disttoken(F).
_optimize(0,1,card).
#show _criteria/3.
#show _optimize/3.
