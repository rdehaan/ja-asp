%%%
%%% MNAC = MPC
%%%
% add a virtual agent for each voter (with its own judgment set)
agent(virtual(A)) :- voter(A).
% require that the outcome is the majority outcome of the virtual profile
vpc(X,N) :- lit(X), N = #count { A : voter(A), js(virtual(A),X) }.
vmaj(X) :- lit(X), vpc(X,N), vpc(-X,M), N > M.
js(col,X) :- vmaj(X).
% minimize the disagreement between the real and the virtual profile
vdisagree(A,X) :- lit(X), voter(A), js(A,X), js(virtual(A),-X).
#minimize { 1,vdisagree(A,X) : vdisagree(A,X) }.
