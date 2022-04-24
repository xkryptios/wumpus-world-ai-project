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
:- dynamic(safe/2).
:- dynamic(visited/2).
:- dynamic(possible_wumpus/2).
:- dynamic(possible_portal/2).
:- dynamic(wumpus/2).
:- dynamic(confoundus/2).
:- dynamic(tingle/2).
:- dynamic(stench/2).


% ----------Agent knowledge---------------
current(0,0,rnorth). %initialised to 0,0,rnorth, can be changed

safe(0,0).
safe(0,1).
safe(-1,0).
safe(1,0).
safe(0,-1).
            

hasarrow().


% ----------Agent functions---------------
reborn() :- retractall(current(_,_,_)),
            asserta(current(0,0,rnorth)),
            retractall(hasarrow),
            asserta(hasarrow()).

reposition([C, S, T, G, B, SC]) :-  retractall(current(_,_,_)),
                                    asserta(current(0,0,rnorth)),
                                    retractall(safe(_,_)),
                                    retractall(visited(_,_)),
                                    retractall(possible_wumpus(_,_)),
                                    retractall(possible_portal(_,_)),
                                    retractall(wumpus(_,_)),
                                    retractall(confoundus(_,_)),
                                    retractall(tingle(_,_)),
                                    retractall(stench(_,_)),
                                    %retractall(glitter(_,_)), %existence of unpicked coins
                                    safe(0,0).

reposition([C, S, T, G, B, SC]) :-        S = on,
                                          current(X,Y,Z),
                                          write("test"),
                                          %write("move first\n"),
                                          assertz(stench(X,Y)),
                                          repo_assignbwumpus(Z). 

repo_assignbwumpus(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(F,Y)),
                            G is Y-1,
                            assertz(possible_wumpus(X,G)).

repo_assignbwumpus(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is Y+1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(F,Y)),
                            G is Y-1,
                            assertz(possible_wumpus(X,G)).

repo_assignbwumpus(rwest) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(F,Y)),
                            G is Y-1,
                            assertz(possible_wumpus(X,G)).

repo_assignbwumpus(rsouth) :-    current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(F,Y)),
                            G is Y-1,
                            assertz(possible_wumpus(X,G)).


reposition([C, S, T, G, B, SC]) :-        T = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          assertz(tingle(X,Y)),
                                          repo_assign_portal(Z).

repo_assign_portal(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)),
                            G is Y-1,
                            assertz(possible_portal(X,G)).

repo_assign_portal(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is Y+1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)),
                            G is Y-1,
                            assertz(possible_portal(X,G)).

repo_assign_portal(rwest) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)),
                            G is Y-1,
                            assertz(possible_portal(X,G)).

repo_assign_portal(rsouth) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)),
                            G is Y-1,
                            assertz(possible_portal(X,G)).

reposition([C, S, T, G, B, SC]) :-        G = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          write("im richhh i find coin , YEET\n"),
                                          assertz(glitter(X,Y)).
            


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

move(moveforward, [C, S, T, G, B, SC]):- S = off,
                                        T = off,
                                        G = off,
                                        B = off,
                                        current(X,Y,Z),
                                        D is X+1,
                                        assertz(safe(D,Y)),
                                        E is X-1,
                                        assertz(safe(E,Y)),
                                        F is Y+1,
                                        assertz(safe(X,F)),
                                        G is Y-1,
                                        assertz(safe(X,G)).


                                         
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
                            assertz(possible_wumpus(F,Y)).

assignbwumpus(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is X+1,
                            assertz(possible_wumpus(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_wumpus(X,E)),
                            F is Y-1,
                            assertz(possible_wumpus(X,F)).

assignbwumpus(rwest) :-     current(X,Y,Z),
                            D is X-1,
                            assertz(possible_wumpus(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_wumpus(X,E)),
                            F is Y-1,
                            assertz(possible_wumpus(X,F)).

assignbwumpus(rsouth) :-    current(X,Y,Z),
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
                            assertz(possible_portal(F,Y)).

assign_portal(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is X+1,
                            assertz(possible_portal(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_portal(X,E)),
                            F is Y-1,
                            assertz(possible_portal(X,F)).

assign_portal(rwest) :-     current(X,Y,Z),
                            D is X-1,
                            assertz(possible_portal(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_portal(X,E)),
                            F is Y-1,
                            assertz(possible_portal(X,F)).

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
                                          assertz(glitter(X,Y)).


move(pickup, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                     glitter(X,Y),
                                     retract(glitter(X,Y)).


move(moveforward, [C, S, T, G, B, SC]) :- B = on,
                                          current(X,Y,Z), %y is up down , x is left right
                                          %write("move first\n"),
                                          write("knn cb wall bump\n"),
                                          assign_wall(Z).

assign_wall(rnorth) :- current(X,Y,Z),
                        D is Y-1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(current(X,D,Z)).

assign_wall(reast) :- current(X,Y,Z), 
                        D is X-1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(current(D,Y,Z)).

assign_wall(rwest) :- current(X,Y,Z),
                        D is X+1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(current(D,Y,Z)).

assign_wall(rsouth) :- current(X,Y,Z),
                        D is Y+1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(current(X,D,Z)).



move(shoot, [C, S, T, G, B, SC]) :-       SC = on,
                                          current(X,Y,Z),
                                          %write("scream is heart\n"),
                                          retractall(possible_wumpus), %retract possible wumpus
                                          retractall(stench). % no more stench
                                        


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

glitter(X,Y) :- 

wall(X,Y) :-

stench(X,Y) :-

wumpus(X,Y) :-

confoundus(X,Y) :-

safe(X,Y) :-

%move(pickup, [C, S, T, G, B, SC]) :- G = on,
%               .