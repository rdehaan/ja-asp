%%%
%%% MAX-HAMMING
%%%
% determine the Hamming distance from each voter's judgment set to the outcome
dist(A,D) :- voter(A), D = #count { X : lit(X), js(col,X), js(A,-X) }.
% take the maximum distance (over all voters)
dist(E) :- E = #max { D,dist(A,D) : dist(A,D) }.
% minimize the maximum distance
#minimize { E@10,dist(E) : dist(E) }.
