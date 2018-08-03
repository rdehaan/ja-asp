% agents
voter(1..17).
% agenda
issue(i1;i2;i3;i4;i5).
% profile
js((1;2;3;4;5;6),(i1;i2;i3;i4;i5)).
js((7;8;9;10),(i1;i2;-i3;-i4;i5)).
js((11;12;13;14;15;16;17),(-i1;-i2;i3;-i4;-i5)).
% integrity constraint
clause(1,(i3;-i4)).
clause(2,(-i3;i4;-i1)).
clause(3,(-i3;i4;-i2)).
