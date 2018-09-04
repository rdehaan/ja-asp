% agents
voter(1..7).
% agenda
issue(i1;i2;i3;i4;i5).
% profile
js(1..2,(-i1;-i2;-i3;-i4;-i5)).
js(3,(i1;i2;i3;i4;-i5)).
js(4,(i1;i2;i3;-i4;i5)).
js(5,(i1;i2;-i3;i4;i5)).
js(6,(i1;-i2;i3;i4;i5)).
js(7,(-i1;i2;i3;i4;i5)).
% integrity constraint
clause(1,(-i1;-i2;-i3;-i4;-i5)).
