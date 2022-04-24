/*This is the Agent.pl file. It contains the knowledge available to the agent
and the logical functions that the Driver can invoke to get Values, bBoolean, etc*/
%consult: consult('C:/Users/user/Desktop/prolog/Agent.pl').

%force reset
reset :- retractall(current(_,_,_)).
%consult
consult :- consult('C:/Users/user/Desktop/prolog/Agent.pl').

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
           retractall(hasarrow()).

move(shoot, [C, S, T, G, B, SC]) :- shoot.

%testing func ryan
%move(moveforward, [C, S, T, G, B, SC]) :- S = on,
                                          current(X,Y,Z),
                                          write("move first\n"),
                                          wumpus(X,Y).
                                          

%pos_wumpus(X,Y) :-  write("i detect a stench\n"),
                    write("possible wumpus at"),
                    %write(X), %detects x  at 0
                    D is X+1,
                    write(D),
                    write(Y),
                    assertz(possible_wumpus(D,Y)),
                    E is Y+1,
                    write(X),
                    write(E),
                    assertz(possible_wumpus(X,E)),
                    F  is Y-1,
                    write(X),
                    write(F),
                    assertz(possible_wumpus(X,F)).


%pos_portal(X,Y) :-  write("i detect a tingle\n"),
                    write("possible portal at"),
                    D is X+1,
                    write(D),
                    write(Y),
                    E is Y+1,
                    write(X),
                    write(E),
                    F  is Y-1,
                    write(X),
                    write(F).


                    
                                         

% moveforward for rnorth

% need to add in check for wall
move(moveforward, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                          assertz(visited(X,Y)),
                                          write("i am now moving forward\n"),
                                          forward(Z). %for some reason forward not updated yet
                                         %S = on,
                                         %write("wumpus detected nearby\n"),
                                         %write("currently at\n"),
                                         %write(X),
                                         %write(Y),
                                         %pos_wumpus(X,Y),
                                         %T = on,
                                         %write("detect portal nearby").

move(moveforward, [C, S, T, G, B, SC]) :- S = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          assertz(stench(X,Y)),
                                          assignbwumpus(Z).

assignbwumpus(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(E,Y)).

assignbwumpus(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is X+1,
                            assertz(possible_wumpus(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_wumpus(X,E)),
                            F is Y-1,
                            assertz(possible_wumpus(X,E)).

assignbwumpus(rwest) :-     current(X,Y,Z),
                            D is X-1,
                            assertz(possible_wumpus(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_wumpus(X,E)),
                            F is Y-1,
                            assertz(possible_wumpus(X,E)).

assignbwumpus(rsouth) :-     current(X,Y,Z),
                            D is Y-1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(F,Y)).
                        


move(moveforward, [C, S, T, G, B, SC]) :- T = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          assertz(tingle(X,Y)),
                                          assign_portal(Z).

assign_portal(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(E,Y)).

assign_portal(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is X+1,
                            assertz(possible_portal(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_portal(X,E)),
                            F is Y-1,
                            assertz(possible_portal(X,E)).

assign_portal(rwest) :-     current(X,Y,Z),
                            D is X-1,
                            assertz(possible_portal(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_portal(X,E)),
                            F is Y-1,
                            assertz(possible_portal(X,E)).

assign_portal(rsouth) :-     current(X,Y,Z),
                            D is Y-1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)).

move(moveforward, [C, S, T, G, B, SC]) :- G = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          write("im richhh i find coin , YEET\n"),
                                          assertz(coin(X,Y)).

move(moveforward, [C, S, T, G, B, SC]) :- B = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          write("knn cb wall bump\n"),
                                          assertz(wall(X,Y)),
                                          retractall(current(_,_,_)),
                                          assertz(current(X,Y,Z)).
                                        


forward(rnorth) :- current(X,Y,Z),
                    G is Y+1,
                    retractall(current(_,_,_)),
                    assertz(current(X,G,Z)).

forward(reast) :- current(X,Y,Z),
                    G is X+1,
                    retractall(current(_,_,_)),
                    assertz(current(G,Y,Z)).
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
                    write("i was rnorth , turning to face reast now\n"),
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


visited(X,Y) :-

possible_wumpus(X,Y) :-

possible_portal(X,Y) :-

tingle(X,Y) :-

coin(X,Y) :- 

wall(X,Y) :-

stench(X,Y) :-

%move(pickup, [C, S, T, G, B, SC]) :- G = on,
%               .