% agents
agent(1..3).
voter(1..3).
agent(col).
% agenda
issue(p;q;r).
% profile
js(1,p). js(1,-q). js(1,r).
js(2,p). js(2,q). js(2,-r).
js(3,-p). js(3,q). js(3,r).
% integrity constraint
clauseneg(1,(-p;-q;-r)).
clauseneg(2,(p;q;r)).