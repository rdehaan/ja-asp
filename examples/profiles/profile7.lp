% agents
voter(1..3).
% agenda
issue(i1;i2;i3;i4).
% profile
js(1,(i1;i2;i3;i4)).
js(2,(i1;i2;-i3;-i4)).
js(3,(-i1;-i2;i3;-i4)).
% integrity constraint
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2)).
