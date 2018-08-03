% agents
voter(1..6).
% agenda
issue(p;q;r).
% profile
js(1,p). js(1,-q). js(1,r).
js(2,p). js(2,q). js(2,-r).
js(3,-p). js(3,-q). js(3,r).
js(4,p). js(4,-q). js(4,r).
js(5,p). js(5,q). js(5,-r).
js(6,-p). js(6,-q). js(6,r).
% integrity constraint
clause(1,(-p;-q;-r)).
clause(2,(p;q;r)).
