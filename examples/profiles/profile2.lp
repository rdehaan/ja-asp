% agents
voter(1..34).
% agenda
issue(i1;i2;i3;i4;i5).
issue(j1;j2;j3;j4;j5).
% profile
js(1..6,(i1;i2;i3;i4;i5)).
js(7..10,(i1;i2;-i3;-i4;i5)).
js(11..17,(-i1;-i2;i3;-i4;-i5)).
js(18..23,(i1;i2;i3;i4;i5)).
js(24..27,(i1;i2;-i3;-i4;i5)).
js(28..34,(-i1;-i2;i3;-i4;-i5)).
js(1..6,(j1;j2;j3;j4;j5)).
js(7..10,(j1;j2;-j3;-j4;j5)).
js(11..17,(-j1;-j2;j3;-j4;-j5)).
js(18..23,(j1;j2;j3;j4;j5)).
js(24..27,(j1;j2;-j3;-j4;j5)).
js(28..34,(-j1;-j2;j3;-j4;-j5)).
% integrity constraint
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2)).
clause(4,(j3;-j4)).
clause(5,(-j3;j4;-j1)).
clause(6,(-j3;j4;-j2)).
