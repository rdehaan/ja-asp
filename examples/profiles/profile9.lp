% agents
voter(1..3).
% agenda
issue(p;q;r).
% profile
js(1,(p;q;r)).
js(2,(p;-q;-r)).
js(3,(-p;q;-r)).
% integrity constraint
clause(1,(-p;-q;r)).
