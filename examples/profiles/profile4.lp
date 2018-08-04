% agents
voter(1..17).
% agenda
issue(i1;i2;i3;i4;i5).
aux(a1).
% profile
js(1..6,(i1;i2;i3;i4;i5;a1)).
js(7..10,(i1;i2;-i3;-i4;i5;a1)).
js(11..17,(-i1;-i2;i3;-i4;-i5;a1)).
% integrity constraint
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2;a1)).
clause(4,(-i3;i4;-i2;-a1)).
