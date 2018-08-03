% agents
voter(1..3).
% agenda
issue(p;q;r;t).
% profile
js(1,p). js(1,-q). js(1,r). js(1,t).
js(2,p). js(2,q). js(2,-r). js(2,t).
js(3,-p). js(3,-q). js(3,r). js(3,t).
% integrity constraint
clause(1,(-p;-q;-r)).
clause(2,(p;q;r)).
