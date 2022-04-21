/*This is the Agent.pl file. It contains the knowledge available to the agent
and the logical functions that the Driver can invoke to get Values, bBoolean, etc*/
%consult: consult('C:\Users\ryanc\Documents\GitHub\wumpus-world-ai-project\src\Agent.pl').

%force reset
reset :- retractall(current(_,_,_)).
%consult
consult :- consult('C:\Users\ryanc\Documents\GitHub\wumpus-world-ai-project\src\Agent.pl').

% Declaration of dynamic (editable) predicates, eg.:- dynamic(father/2)
:- dynamic(current/3).
:- dynamic(hasarrow/0).


% ----------Agent knowledge---------------
current(0,0,rnorth). %initialised to 0,0,rnorth, can be changed

hasarrow().

% ----------Agent functions---------------
reborn() :- retractall(current(_,_,_)),
            asserta(current(0,0,rnorth)),
            retractall(hasarrow),
            asserta(hasarrow()).

shoot() :- hasarrow,
            write("shot fired"),
           retractall(hasarrow()).

move(shoot, [C, S, T, G, B, SC]) :- shoot.

% moveforward for rnorth

move(moveforward , [C, S, T, G, B, SC]) :- write("i am moving forward "),
                                            write("current"),
                                            current(X,Y,Z),
                                            write(X),
                                            write(Y),
                                            write(Z),
                                            forward(Z).
% need to add in check for wall
%move(moveforward, [C, S, T, G, B, SC]) :- current(X,Y,Z),
 %                                         write("testing").
  %                                        forward(Z).

forward(rnorth) :-  write("\ni am now moving r north forward"),
                    current(X,Y,Z),
                    G is Y+1,
                    retractall(current(_,_,_)),
                    assertz(current(X,G,Z)),
                    write(X),
                    write(G),
                    write(Z),
                    put(10).

forward(reast) :- current(X,Y,Z),
                    G is X+1,
                    retractall(current(_,_,_)),
                    asserta(current(G,Y,Z)).
forward(rwest) :- current(X,Y,Z),
                    G is X-1,
                    retractall(current(_,_,_)),
                    asserta(current(G,Y,Z)).
forward(rsouth) :- current(X,Y,Z),
                    G is Y-1,
                    retractall(current(_,_,_)),
                    asserta(current(X,G,Z)).

% turnleft
move(turnleft, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                       turnleft(Z).

turnleft(rnorth) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,rwest)).
turnleft(reast) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,rnorth)).
turnleft(rwest) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,rsouth)).
turnleft(rsouth) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,reast)).

% turnright
move(turnright, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                       turnright(Z).

turnright(rnorth) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,reast)).
turnright(rwest) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,rnorth)).
turnright(rsouth) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,rwest)).
turnright(reast) :- current(X,Y,Z),
                    retractall(current(_,_,_)),
                    asserta(current(X,Y,rsouth)).



%move(pickup, [C, S, T, G, B, SC]) :- G = on,
% 
do_list(N, L):- findall(Num, between(1, N, Num), L).

list_pairs(List1, List2, Pairs) :- findall((D,J), (member(D, List1), member(J, List2)), Pairs),
print(Pairs).