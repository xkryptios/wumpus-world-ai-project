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
:- dynamic(scream/2).
:- dynamic(bump/2).


% ----------------------------------Agent knowledge---------------------------------
current(0,0,rnorth). %initialised to 0,0,rnorth, can be changed

safe(0,0).
safe(0,1).
safe(-1,0).
safe(1,0).
safe(0,-1).
            

hasarrow().

%----------------------- ----------Agent functions---------------------------------
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
                                    retractall(bump(_,_)),
                                    retractall(scream(_,_)),
                                    %retractall(glitter(_,_)), %existence of unpicked coins
                                    safe(0,0).

%--------------------------------------Reposition--------------------------------
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
            
%--------------------------------------shoot--------------------------------

shoot() :- hasarrow,
           retractall(hasarrow()).



move(shoot, [C, S, T, G, B, SC]) :- shoot.

move(shoot, [C, S, T, G, B, SC]) :-       SC = on,
                                          current(X,Y,Z),
                                          %write("scream is heart\n"),
                                          retractall(possible_wumpus), %retract possible wumpus
                                          assertz(scream(X,Y)),
                                          retractall(stench). % no more stench

%--------------------------------------Move--------------------------------               

% moveforward for rnorth

% need to add in check for wall
move(moveforward, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                          assertz(visited(X,Y)),
                                          write("i am now moving forward\n"),
                                          retractall(bump(_,_)),
                                          retractall(scream(_,_)),
                                          forward(Z). 

move(moveforward, [C, S, T, G, B, SC]):- S = off,
                                        T = off,
                                        B = off,
                                        current(X,Y,Z),
                                        write("assigning safe\n"),
                                        assign_safe(Z).
            
%------------------------------------------------move forward------------------------------------------

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

%---------------------------------turning-----------------------------------------

% turnleft
move(turnleft, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                        retractall(bump(_,_)),
                                          retractall(scream(_,_)),
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
                                        retractall(bump(_,_)),
                                          retractall(scream(_,_)),
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

%--------------------------------------Asign safe------------------------------------

assign_safe(rnorth) :-                  current(X,Y,Z),
                                        D is Y+1,  %y is up down , x is left right
                                        assertz(safe(X,Y)),
                                        E is X-1,
                                        assertz(safe(E,Y)),
                                        F is X+1,
                                        assertz(safe(F,Y)).

assign_safe(reast) :-                  current(X,Y,Z),
                                        D is Y+1,  %y is up down , x is left right
                                        assertz(safe(X,Y)),
                                        E is Y-1,
                                        assertz(safe(X,E)),
                                        F is X+1,
                                        assertz(safe(F,Y)).

assign_safe(rsouth) :-                  current(X,Y,Z),
                                        D is Y-1,  %y is up down , x is left right
                                        assertz(safe(X,Y)),
                                        E is X-1,
                                        assertz(safe(E,Y)),
                                        F is X+1,
                                        assertz(safe(F,Y)).

assign_safe(rwest) :-                  current(X,Y,Z),
                                        D is Y+1,  %y is up down , x is left right
                                        assertz(safe(X,Y)),
                                        E is X-1,
                                        assertz(safe(E,Y)),
                                        F is Y-1,
                                        assertz(safe(X,Y)).



%--------------------------------------Assign wumpus--------------------------------


                                    
move(moveforward, [C, S, T, G, B, SC]) :- S = on,
                                          current(X,Y,Z),
                                          check_wumpus(Z). 

move(moveforward, [C, S, T, G, B, SC]) :- S = on,
                                          current(X,Y,Z),
                                          assertz(stench(X,Y)),
                                          assignbwumpus(Z). 

/*move(moveforward, [C, S, T, G, B, SC]) :-   S = on,
                                            current(X,Y,Z),
                                            J,
                                            check_wumpus(Z).*/


assignbwumpus(rnorth) :-   current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
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
                            write("i sense a wumpus in the forces\n"),
                            D is X-1,
                            assertz(possible_wumpus(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_wumpus(X,E)),
                            F is Y-1,
                            assertz(possible_wumpus(X,F)).

assignbwumpus(rsouth) :-    current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is Y-1,
                            assertz(possible_wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_wumpus(E,Y)),
                            F is X-1,
                            assertz(possible_wumpus(F,Y)).


check_wumpus(rnorth) :- current(X,Y,Z),
                        D is X-1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).

check_wumpus(rnorth) :- current(X,Y,Z),
                        D is X+1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).


check_wumpus(rnorth) :- current(X,Y,Z),
                        D is Y+1,
                     possible_wumpus(X,D),
                     assertz(wumpus(X,D)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(X),
                     write(D).




check_wumpus(reast) :- current(X,Y,Z),
                        D is Y+1,
                     possible_wumpus(X,D),
                     assertz(wumpus(X,D)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(X),
                     write(D).

check_wumpus(reast) :- current(X,Y,Z),
                        D is X-1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).

check_wumpus(reast) :- current(X,Y,Z),
                        D is Y-1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).


check_wumpus(rsouth) :- current(X,Y,Z),
                        D is Y-1,
                     possible_wumpus(X,D),
                     assertz(wumpus(X,D)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(X),
                     write(D).

check_wumpus(rsouth) :- current(X,Y,Z),
                        D is X-1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).

check_wumpus(rsouth) :- current(X,Y,Z),
                        D is X+1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).

check_wumpus(rwest) :- current(X,Y,Z),
                        D is X-1,
                     possible_wumpus(D,Y),
                     assertz(wumpus(D,Y)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(D),
                     write(Y).


check_wumpus(rwest) :- current(X,Y,Z),
                        D is Y+1,
                     possible_wumpus(X,D),
                     assertz(wumpus(X,D)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(X),
                     write(D).

check_wumpus(rwest) :- current(X,Y,Z),
                        D is Y-1,
                     possible_wumpus(X,D),
                     assertz(wumpus(X,D)),
                     retractall(possible_wumpus(_,_)),
                     write("wumpus assigned to "),
                     write(X),
                     write(D).



%--------------------------------------Assign portal--------------------------------


move(moveforward, [C, S, T, G, B, SC]) :- T = on,
                                          current(X,Y,Z),
                                          assertz(tingle(X,Y)),
                                          assign_portal(Z).

assign_portal(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)),
                            check_portal(Z),
                            write("i am resetting pos portal"),
                            retractall(possible_portal(_,_)).

assign_portal(reast) :-     current(X,Y,Z),
                            write("i sense a wumpus in the forces\n"),
                            D is X+1,
                            assertz(possible_portal(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_portal(X,E)),
                            F is Y-1,
                            assertz(possible_portal(X,F)),
                            check_portal(Z),
                            write("i am resetting pos portal"),
                            retractall(possible_portal(_,_)).

assign_portal(rwest) :-     current(X,Y,Z),
                            D is X-1,
                            assertz(possible_portal(D,Y)), %y is up down , x is left right
                            E is Y+1,
                            assertz(possible_portal(X,E)),
                            F is Y-1,
                            assertz(possible_portal(X,F)),
                            write("i am resetting pos portal"),
                            check_portal(Z),
                            retractall(possible_portal(_,_)).

assign_portal(rsouth) :-     current(X,Y,Z),
                            D is Y-1,
                            assertz(possible_portal(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(possible_portal(E,Y)),
                            F is X-1,
                            assertz(possible_portal(F,Y)),
                            write("i am resetting pos portal"),
                            check_portal(Z),
                            retractall(possible_portal(_,_)).

check_portal(rnorth) :- current(X,Y,Z),
                        D is X-1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("portal assigned to "),
                     write(D),
                     write(Y).

check_portal(rnorth) :- current(X,Y,Z),
                        D is X+1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("portal assigned to "),
                     write(D),
                     write(Y).


check_portal(rnorth) :- current(X,Y,Z),
                        D is Y+1,
                     possible_portal(X,D),
                     assertz(portal(X,D)),
                     write("portal assigned to "),
                     write(X),
                     write(D).




check_portal(reast) :- current(X,Y,Z),
                        D is Y+1,
                     possible_portal(X,D),
                     assertz(portal(X,D)),
                     write("portal assigned to "),
                     write(X),
                     write(D).

check_portal(reast) :- current(X,Y,Z),
                        D is X-1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("[prtal] assigned to "),
                     write(D),
                     write(Y).

check_portal(reast) :- current(X,Y,Z),
                        D is Y-1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("portal assigned to "),
                     write(D),
                     write(Y).


check_portal(rsouth) :- current(X,Y,Z),
                        D is Y-1,
                     possible_portal(X,D),
                     assertz(portal(X,D)),
                     write("portal assigned to "),
                     write(X),
                     write(D).

check_portal(rsouth) :- current(X,Y,Z),
                        D is X-1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("portal assigned to "),
                     write(D),
                     write(Y).

check_portal(rsouth) :- current(X,Y,Z),
                        D is X+1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("portal assigned to "),
                     write(D),
                     write(Y).

check_portal(rwest) :- current(X,Y,Z),
                        D is X-1,
                     possible_portal(D,Y),
                     assertz(portal(D,Y)),
                     write("portal assigned to "),
                     write(D),
                     write(Y).


check_portal(rwest) :- current(X,Y,Z),
                        D is Y+1,
                     possible_portal(X,D),
                     assertz(portal(X,D)),
                     write("portal assigned to "),
                     write(X),
                     write(D).

check_portal(rwest) :- current(X,Y,Z),
                        D is Y-1,
                     possible_portal(X,D),
                     assertz(portal(X,D)),
                     write("portal assigned to "),
                     write(X),
                     write(D).

%--------------------------------------Coin--------------------------------

move(moveforward, [C, S, T, G, B, SC]) :- G = on,
                                          current(X,Y,Z),
                                          %write("move first\n"),
                                          write("im richhh i find coin , YEET\n"),
                                          assertz(glitter(X,Y)).


move(pickup, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                     glitter(X,Y),
                                     retract(glitter(X,Y)).

%--------------------------------------Assign wall--------------------------------

move(moveforward, [C, S, T, G, B, SC]) :- B = on,
                                          current(X,Y,Z), %y is up down , x is left right
                                          %write("move first\n"),
                                          write("knn cb wall bump\n"),
                                          assign_wall(Z).

assign_wall(rnorth) :- current(X,Y,Z),
                        D is Y-1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(bump(X,D)),
                       assertz(current(X,D,Z)).

assign_wall(reast) :- current(X,Y,Z), 
                        D is X-1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(bump(D,Y)),
                       assertz(current(D,Y,Z)).

assign_wall(rwest) :- current(X,Y,Z),
                        D is X+1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(bump(D,Y)),
                       assertz(current(D,Y,Z)).

assign_wall(rsouth) :- current(X,Y,Z),
                        D is Y+1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       assertz(bump(X,D)),
                       assertz(current(X,D,Z)).

