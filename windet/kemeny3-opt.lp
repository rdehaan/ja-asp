%%%
%%% GENERAL DISTANCE BASED (KEMENY)
%%%

#include "windet.lp".

% determine the Hamming distance from each voter's judgment set to the outcome
dist(A,D) :- voter(A), D = #count { X : lit(X), js(col,X), js(A,-X) }.
% sum the distances over all voters
dist(E) :- E = #sum { D,dist(A,D) : dist(A,D) }.
% minimize the cumulative distance
#minimize { E@10,dist(E) : dist(E) }.
