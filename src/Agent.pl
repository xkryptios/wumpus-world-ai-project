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
:- dynamic(wumpus/2).
:- dynamic(confundus/2).
:- dynamic(tingle/2).
:- dynamic(stench/2).
:- dynamic(scream/2).
:- dynamic(bump/2).
:- dynamic(semophore/0).
:- dynamic(nextloc/3).
:- dynamic(wall/2).
:- dynamic(glitter/2).

% ----------------------------------Agent knowledge---------------------------------
current(0,0,rnorth). %initialised to 0,0,rnorth, can be changed

safe(0,0).
safe(0,1).
safe(-1,0).
safe(1,0).
safe(0,-1).
visited(0,0).
# wall(X,Y):-
# confundus(X,Y):-
            

hasarrow().

semophore().

%----------------------- ----------Agent functions---------------------------------
reborn() :- retractall(current(_,_,_)),
            asserta(current(0,0,rnorth)),
            retractall(hasarrow),
            asserta(hasarrow()),
            retractall(semophore()),
            asserta(semophore()).

reposition([C, S, T, G, B, SC]) :-  retractall(current(_,_,_)),
                                    asserta(current(0,0,rnorth)),
                                    retractall(safe(_,_)),
                                    retractall(visited(_,_)),
                                    retractall(confundus(_,_)),
                                    retractall(wumpus(_,_)),
                                    retractall(confundus(_,_)),
                                    retractall(tingle(_,_)),
                                    retractall(stench(_,_)),
                                    retractall(bump(_,_)),
                                    retractall(scream(_,_)),
                                    retractall(semophore()),
                                    asserta(semophore()),
                                    %retractall(glitter(_,_)), %existence of unpicked coins
                                    asserta(safe(0,0)),
                                    assertz(safe(0,1)),
                                    assertz(safe(-1,0)),
                                    assertz(safe(1,0)),
                                    assertz(safe(0,-1)).

%--------------------------------------Reposition--------------------------------
reposition([C, S, T, G, B, SC]) :-        S = on,
                                          current(X,Y,Z),
                                          assertz(stench(X,Y)),
                                          repo_assignbwumpus(Z). 

repo_assignbwumpus(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(wumpus(E,Y)),
                            F is X-1,
                            assertz(wumpus(F,Y)),
                            G is Y-1,
                            assertz(wumpus(X,G)).

repo_assignbwumpus(reast) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(wumpus(E,Y)),
                            F is X-1,
                            assertz(wumpus(F,Y)),
                            G is Y-1,
                            assertz(wumpus(X,G)).

repo_assignbwumpus(rwest) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(wumpus(E,Y)),
                            F is X-1,
                            assertz(wumpus(F,Y)),
                            G is Y-1,
                            assertz(wumpus(X,G)).

repo_assignbwumpus(rsouth) :-    current(X,Y,Z),
                            D is Y+1,
                            assertz(wumpus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(wumpus(E,Y)),
                            F is X-1,
                            assertz(wumpus(F,Y)),
                            G is Y-1,
                            assertz(wumpus(X,G)).


reposition([C, S, T, G, B, SC]) :-        T = on,
                                          current(X,Y,Z),
                                          assertz(tingle(X,Y)),
                                          repo_assign_portal(Z).

repo_assign_portal(rnorth) :-   current(X,Y,Z),
                            D is Y+1,
                            assertz(confundus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(confundus(E,Y)),
                            F is X-1,
                            assertz(confundus(F,Y)),
                            G is Y-1,
                            assertz(confundus(X,G)).

repo_assign_portal(reast) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(confundus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(confundus(E,Y)),
                            F is X-1,
                            assertz(confundus(F,Y)),
                            G is Y-1,
                            assertz(confundus(X,G)).

repo_assign_portal(rwest) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(confundus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(confundus(E,Y)),
                            F is X-1,
                            assertz(confundus(F,Y)),
                            G is Y-1,
                            assertz(confundus(X,G)).

repo_assign_portal(rsouth) :-     current(X,Y,Z),
                            D is Y+1,
                            assertz(confundus(X,D)), %y is up down , x is left right
                            E is X+1,
                            assertz(confundus(E,Y)),
                            F is X-1,
                            assertz(confundus(F,Y)),
                            G is Y-1,
                            assertz(confundus(X,G)).

reposition([C, S, T, G, B, SC]) :-        G = on,
                                          current(X,Y,Z),
                                          assertz(glitter(X,Y)).
            
%--------------------------------------shoot--------------------------------

shoot() :- hasarrow,
           retractall(hasarrow()).



move(shoot, [C, S, T, G, B, SC]) :- shoot.

move(shoot, [C, S, T, G, B, SC]) :-       SC = on,
                                          current(X,Y,Z),
                                          retractall(wumpus), %retract possible wumpus
                                          assertz(scream(X,Y)),
                                          retractall(stench). % no more stench

%--------------------------------------Move--------------------------------               

% moveforward for rnorth

% need to add in check for wall
move(moveforward, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                          retractall(bump(_,_)),
                                          retractall(scream(_,_)),
                                          forward(Z). 

move(moveforward, [C, S, T, G, B, SC]):- S = off,
                                        T = off,
                                        B = off,
                                        current(X,Y,Z),
                                        assign_safe(Z).
            
%------------------------------------------------move forward------------------------------------------

forward(rnorth) :- current(X,Y,Z),
                    G is Y+1,
                    retractall(current(_,_,_)),
                    assertz(current(X,G,Z)),
                    assertz(visited(X,G)).


forward(reast) :- current(X,Y,Z),
                    G is X+1,
                    retractall(current(_,_,_)),
                    assertz(current(G,Y,Z)),
                    assertz(visited(G,Y)).

forward(rwest) :- current(X,Y,Z),
                    G is X-1,
                    retractall(current(_,_,_)),
                    asserta(current(G,Y,Z)),
                    assertz(visited(G,Y)).

forward(rsouth) :- current(X,Y,Z),
                    G is Y-1,
                    retractall(current(_,_,_)),
                    asserta(current(X,G,Z)),
                    assertz(visited(X,G)).


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

assign_safe(rnorth) :-  current(X,Y,Z),
                         D is Y+1,  %y is up down , x is left right
                        not(wumpus(X,D)),
                        not(confundus(X,D)),
                        assertz(safe(X,D)).
assign_safe(rnorth) :-  current(X,Y,Z),
                         D is Y+1,  %y is up down , x is left right
                        (wumpus(X,D)),
                        not(confundus(X,D)),
                        assertz(safe(X,D)),
                        retract(wumpus(X,D)).
assign_safe(rnorth) :-  current(X,Y,Z),
                         D is Y+1,  %y is up down , x is left right
                        not(wumpus(X,D)),
                        (confundus(X,D)),
                        assertz(safe(X,D)),
                        retract(confundus(X,D)).

assign_safe(rnorth):- current(X,Y,Z),
                     E is X-1,
                     not(wumpus(E,Y)),
                     not(confundus(E,Y)),
                     assertz(safe(E,Y)).
assign_safe(rnorth):- current(X,Y,Z),
                     E is X-1,
                     (wumpus(E,Y)),
                     not(confundus(E,Y)),
                     assertz(safe(E,Y)),
                     retract(wumpus(E,Y)).

assign_safe(rnorth):- current(X,Y,Z),
                     E is X-1,
                     not(wumpus(E,Y)),
                     (confundus(E,Y)),
                     assertz(safe(E,Y)),
                     retract(confundus(E,Y)).

assign_safe(rnorth):- current(X,Y,Z),
                      F is X+1,
                     not(wumpus(F,Y)),
                     not(confundus(F,Y)),
                     assertz(safe(F,Y)).
assign_safe(rnorth):- current(X,Y,Z),
                      F is X+1,
                     (wumpus(F,Y)),
                     not(confundus(F,Y)),
                     assertz(safe(F,Y)),
                     retract(wumpus(F,Y)).
assign_safe(rnorth):- current(X,Y,Z),
                      F is X+1,
                     not(wumpus(F,Y)),
                     (confundus(F,Y)),
                     assertz(safe(F,Y)),
                     retract(confundus(F,Y)).

assign_safe(reast):-  current(X,Y,Z),
                     D is Y+1,  %y is up down , x is left right
                     not(wumpus(X,D)),
                     not(confundus(X,D)),
                     assertz(safe(X,D)).
assign_safe(reast):-  current(X,Y,Z),
                     D is Y+1,  %y is up down , x is left right
                     (wumpus(X,D)),
                     not(confundus(X,D)),
                     assertz(safe(X,D)),
                     retract(wumpus(X,D)).
assign_safe(reast):-  current(X,Y,Z),
                     D is Y+1,  %y is up down , x is left right
                     not(wumpus(X,D)),
                     (confundus(X,D)),
                     assertz(safe(X,D)),
                     retract(confundus(X,D)).

assign_safe(reast):- current(X,Y,Z), 
                     E is Y-1,
                     not(wumpus(X,E)),
                     not(confundus(X,E)),
                     assertz(safe(X,E)).
assign_safe(reast):- current(X,Y,Z), 
                     E is Y-1,
                     (wumpus(X,E)),
                     not(confundus(X,E)),
                     assertz(safe(X,E)),
                     retract(wumpus(X,E)).
assign_safe(reast):- current(X,Y,Z), 
                     E is Y-1,
                     not(wumpus(X,E)),
                     (confundus(X,E)),
                     assertz(safe(X,E)),
                     retract(confundus(X,E)).

assign_safe(reast):- current(X,Y,Z), 
                     F is X+1,
                     not(wumpus(F,Y)),
                     not(confundus(F,Y)),
                     assertz(safe(F,Y)).
assign_safe(reast):- current(X,Y,Z), 
                     F is X+1,
                     (wumpus(F,Y)),
                     not(confundus(F,Y)),
                     assertz(safe(F,Y)),
                     retract(wumpus(F,Y)).
assign_safe(reast):- current(X,Y,Z), 
                     F is X+1,
                     not(wumpus(F,Y)),
                     (confundus(F,Y)),
                     assertz(safe(F,Y)),
                     retract(confundus(F,Y)).

assign_safe(rsouth):-   current(X,Y,Z), 
                        D is Y-1,
                        not(wumpus(X,D)),
                        not(confundus(X,D)),
                        assertz(safe(X,D)).
assign_safe(rsouth):-   current(X,Y,Z), 
                        D is Y-1,
                        (wumpus(X,D)),
                        not(confundus(X,D)),
                        assertz(safe(X,D)),
                        retract(wumpus(X,D)).
assign_safe(rsouth):-   current(X,Y,Z), 
                        D is Y-1,
                        not(wumpus(X,D)),
                        (confundus(X,D)),
                        assertz(safe(X,D)),
                        retract(confundus(X,D)).


assign_safe(rsouth):-   current(X,Y,Z), 
                        E is X-1,
                        not(wumpus(E,Y)),
                        not(confundus(E,Y)),
                        assertz(safe(E,Y)).
assign_safe(rsouth):-   current(X,Y,Z), 
                        E is X-1,
                        (wumpus(E,Y)),
                        not(confundus(E,Y)),
                        assertz(safe(E,Y)),
                        retract(wumpus(E,Y)).
assign_safe(rsouth):-   current(X,Y,Z), 
                        E is X-1,
                        not(wumpus(E,Y)),
                        (confundus(E,Y)),
                        assertz(safe(E,Y)),
                        retract(confundus(E,Y)).

assign_safe(rsouth):-   current(X,Y,Z), 
                        F is X+1,
                        not(wumpus(F,Y)),
                        not(confundus(F,Y)),
                        assertz(safe(F,Y)).
assign_safe(rsouth):-   current(X,Y,Z), 
                        F is X+1,
                        (wumpus(F,Y)),
                        not(confundus(F,Y)),
                        assertz(safe(F,Y)),
                        retract(wumpus(F,Y)).
assign_safe(rsouth):-   current(X,Y,Z), 
                        F is X+1,
                        not(wumpus(F,Y)),
                        (confundus(F,Y)),
                        assertz(safe(F,Y)),
                        retract(confundus(F,Y)).

assign_safe(rwest) :- current(X,Y,Z), 
                        D is Y+1,  %y is up down , x is left right
                        not(wumpus(X,D)),
                        not(confundus(X,D)),
                        assertz(safe(X,D)).
assign_safe(rwest) :- current(X,Y,Z), 
                        D is Y+1,  %y is up down , x is left right
                        (wumpus(X,D)),
                        not(confundus(X,D)),
                        assertz(safe(X,D)),
                        retract(wumpus(X,D)).
assign_safe(rwest) :- current(X,Y,Z), 
                        D is Y+1,  %y is up down , x is left right
                        not(wumpus(X,D)),
                        (confundus(X,D)),
                        assertz(safe(X,D)),
                        retract(confundus(X,D)).


assign_safe(rwest) :- current(X,Y,Z), 
                        E is X-1,  %y is up down , x is left right
                        not(wumpus(E,Y)),
                        not(confundus(E,Y)),
                        assertz(safe(E,Y)).
assign_safe(rwest) :- current(X,Y,Z), 
                        E is X-1,  %y is up down , x is left right
                        (wumpus(E,Y)),
                        not(confundus(E,Y)),
                        assertz(safe(E,Y)),
                        retract(wumpus(E,Y)).
assign_safe(rwest) :- current(X,Y,Z), 
                        E is X-1,  %y is up down , x is left right
                        not(wumpus(E,Y)),
                        (confundus(E,Y)),
                        assertz(safe(E,Y)),
                        retract(confundus(E,Y)).


assign_safe(rwest) :- current(X,Y,Z), 
                        F is Y-1,  %y is up down , x is left right
                        not(wumpus(X,F)),
                        not(confundus(X,F)),
                        assertz(safe(X,F)).
assign_safe(rwest) :- current(X,Y,Z), 
                        F is Y-1,  %y is up down , x is left right
                        (wumpus(X,F)),
                        not(confundus(X,F)),
                        assertz(safe(X,F)),
                        retract(wumpus(X,F)).

assign_safe(rwest) :- current(X,Y,Z), 
                        F is Y-1,  %y is up down , x is left right
                        not(wumpus(X,F)),
                        (confundus(X,F)),
                        assertz(safe(X,F)),
                        retract(confundus(X,F)).


%--------------------------------------Assign wumpus--------------------------------


                                    
move(moveforward, [C, S, T, G, B, SC]) :- S = on,
                                          current(X,Y,Z),
                                          check_wumpus(Z). 

move(moveforward, [C, S, T, G, B, SC]) :- S = on,
                                          current(X,Y,Z),
                                          semophore,
                                          assertz(stench(X,Y)),
                                          assign_wumpus(Z). 



assign_wumpus(rnorth):- current(X,Y,Z),
                        D is Y+1,
                        not(safe(X,D)),
                        assertz(wumpus(X,D)).



assign_wumpus(rnorth):- current(X,Y,Z),
                        E is X+1,
                        not(safe(E,Y)),
                        assertz(wumpus(E,Y)).


assign_wumpus(rnorth):- current(X,Y,Z),
                        F is X-1,
                        not(safe(F,Y)),
                        assertz(wumpus(F,Y)).





assign_wumpus(reast):- current(X,Y,Z),
                        D is X+1,
                        not(safe(D,Y)),
                        assertz(wumpus(D,Y)).





assign_wumpus(reast):- current(X,Y,Z),
                        E is Y+1,
                        not(safe(X,E)),
                        assertz(wumpus(X,E)).





assign_wumpus(reast):- current(X,Y,Z),
                        F is Y-1,
                        not(safe(X,F)),
                        assertz(wumpus(X,F)).




assign_wumpus(rsouth):- current(X,Y,Z),
                        D is Y-1,
                        not(safe(X,D)),
                        assertz(wumpus(X,D)).



assign_wumpus(rsouth):- current(X,Y,Z),
                        E is X+1,
                        not(safe(E,Y)),
                        assertz(wumpus(E,Y)).



assign_wumpus(rsouth):- current(X,Y,Z),
                        F is X-1,
                        not(safe(F,Y)),
                        assertz(wumpus(F,Y)).



assign_wumpus(rwest):- current(X,Y,Z),
                        D is X-1,
                        not(safe(D,Y)),
                        assertz(wumpus(D,Y)).



assign_wumpus(rwest):- current(X,Y,Z),
                        E is Y+1,
                        not(safe(X,E)),
                        assertz(wumpus(X,E)).


assign_wumpus(rwest):- current(X,Y,Z),
                        F is Y-1,
                        not(safe(X,F)),
                        assertz(wumpus(X,F)).






check_wumpus(rnorth) :- current(X,Y,Z),
                        D is X-1,
                     wumpus(D,Y),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).

check_wumpus(rnorth) :- current(X,Y,Z),
                        D is X+1,
                        wumpus(D,Y),
                        retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).


check_wumpus(rnorth) :- current(X,Y,Z),
                        D is Y+1,
                        wumpus(X,D),
                        retractall(wumpus(_,_)),
                     assertz(wumpus(X,D)),
                     retractall(semophore()).




check_wumpus(reast) :- current(X,Y,Z),
                        D is Y+1,
                     wumpus(X,D),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(X,D)),
                     retractall(semophore()).

check_wumpus(reast) :- current(X,Y,Z),
                        D is X-1,
                     wumpus(D,Y),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).

check_wumpus(reast) :- current(X,Y,Z),
                        D is Y-1,
                     wumpus(D,Y),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).


check_wumpus(rsouth) :- current(X,Y,Z),
                        D is Y-1,
                     wumpus(X,D),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(X,D)),
                     retractall(semophore()).

check_wumpus(rsouth) :- current(X,Y,Z),
                        D is X-1,
                        wumpus(D,Y),
                        retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).

check_wumpus(rsouth) :- current(X,Y,Z),
                        D is X+1,
                     wumpus(D,Y),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).

check_wumpus(rwest) :- current(X,Y,Z),
                        D is X-1,
                     wumpus(D,Y),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(D,Y)),
                     retractall(semophore()).


check_wumpus(rwest) :- current(X,Y,Z),
                        D is Y+1,
                     wumpus(X,D),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(X,D)),
                     retractall(semophore()).

check_wumpus(rwest) :- current(X,Y,Z),
                        D is Y-1,
                     wumpus(X,D),
                     retractall(wumpus(_,_)),
                     assertz(wumpus(X,D)),
                     retractall(semophore()).



%--------------------------------------Assign portal--------------------------------


move(moveforward, [C, S, T, G, B, SC]) :- T = on,
                                          current(X,Y,Z),
                                          assertz(tingle(X,Y)),
                                          assign_portal(Z).

assign_portal(rnorth):- current(X,Y,Z),
                        D is Y+1,
                        not(safe(X,D)),
                        assertz(confundus(X,D)).



assign_portal(rnorth):- current(X,Y,Z),
                        E is X+1,
                        not(safe(E,Y)),
                        assertz(confundus(E,Y)).



assign_portal(rnorth):- current(X,Y,Z),
                        F is X-1,
                        not(safe(F,Y)),
                        assertz(confundus(F,Y)).





assign_portal(reast):- current(X,Y,Z),
                        D is X+1,
                        not(safe(D,Y)),
                        assertz(confundus(D,Y)).



assign_portal(reast):- current(X,Y,Z),
                        E is Y+1,
                        not(safe(X,E)),
                        assertz(confundus(X,E)).





assign_portal(reast):- current(X,Y,Z),
                        F is Y-1,
                        not(safe(X,F)),
                        assertz(confundus(X,F)).





assign_portal(rsouth):- current(X,Y,Z),
                        D is Y-1,
                        not(safe(X,D)),
                        assertz(confundus(X,D)).




assign_portal(rsouth):- current(X,Y,Z),
                        E is X+1,
                        not(safe(E,Y)),
                        assertz(confundus(E,Y)).



assign_portal(rsouth):- current(X,Y,Z),
                        F is X-1,
                        not(safe(F,Y)),
                        assertz(confundus(F,Y)).




assign_portal(rwest):- current(X,Y,Z),
                        D is X-1,
                        not(safe(D,Y)),
                        assertz(confundus(D,Y)).




assign_portal(rwest):- current(X,Y,Z),
                        E is Y+1,
                        not(safe(X,E)),
                        assertz(confundus(X,E)).



assign_portal(rwest):- current(X,Y,Z),
                        F is Y-1,
                        not(safe(X,F)),
                        assertz(confundus(X,F)).


                        


%--------------------------------------Coin--------------------------------

move(moveforward, [C, S, T, G, B, SC]) :- G = on,
                                          current(X,Y,Z),
                                          assertz(glitter(X,Y)).


move(pickup, [C, S, T, G, B, SC]) :- current(X,Y,Z),
                                     glitter(X,Y),
                                     retract(glitter(X,Y)).

%--------------------------------------Assign wall--------------------------------

move(moveforward, [C, S, T, G, B, SC]) :- B = on,
                                          current(X,Y,Z), %y is up down , x is left right
                                          assign_wall(Z).

assign_wall(rnorth) :- current(X,Y,Z),
                        D is Y-1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       retractall(safe(X,Y)),
                       assertz(bump(X,D)),
                       assertz(current(X,D,Z)).

assign_wall(reast) :- current(X,Y,Z), 
                        D is X-1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       retractall(safe(X,Y)),

                       assertz(bump(D,Y)),
                       assertz(current(D,Y,Z)).

assign_wall(rwest) :- current(X,Y,Z),
                        D is X+1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       retractall(safe(X,Y)),

                       assertz(bump(D,Y)),
                       assertz(current(D,Y,Z)).

assign_wall(rsouth) :- current(X,Y,Z),
                        D is Y+1,
                       assertz(wall(X,Y)),
                       retract(current(X,Y,Z)),
                       retractall(safe(X,Y)),
                       assertz(bump(X,D)),
                       assertz(current(X,D,Z)).
-------------------------------------------explore------------------------------------
nextloc(0,0,rnorth).

explore([H|T]) :-current(X,Y,Z), safe(X,Y),
                 updatenext(H,X,Y,Z),explore2(T).

explore2([H|T]) :- nextloc(X,Y,Z),
                     updatenext(H,X,Y,Z), explore2(T).

explore2([]).



updatenext(moveforward, X, Y, rnorth) :- D is Y+1, safe(X,D),retractall(nextloc(_,_,_)), asserta(nextloc(X,D,rnorth)).

updatenext(moveforward, X, Y, reast) :- D is X+1, safe(D,Y),retractall(nextloc(_,_,_)), asserta(nextloc(D,Y,reast)).

updatenext(moveforward, X, Y, rwest) :- D is X-1,safe(D,Y), retractall(nextloc(_,_,_)), asserta(nextloc(D,Y,rwest)).

updatenext(moveforward, X, Y, rsouth) :- D is Y-1,safe(X,D), retractall(nextloc(_,_,_)), asserta(nextloc(X,D,rsouth)).

updatenext(turnleft, X, Y, rnorth) :-  retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,rwest)).

updatenext(turnleft, X, Y, reast) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,rnorth)).

updatenext(turnleft, X, Y, rwest) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,rsouth)).

updatenext(turnleft, X, Y, rsouth) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,reast)).

updatenext(turnright, X, Y, rnorth) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,reast)).

updatenext(turnright, X, Y, reast) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,rsouth)).

updatenext(turnright, X, Y, rwest) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,rnorth)).

updatenext(turnright, X, Y, rsouth) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,rwest)).

updatenext(pickup, X, Y, Z) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,Z)).

updatenext(shoot, X, Y, Z) :- retractall(nextloc(_,_,_)), asserta(nextloc(X,Y,Z)).





/*explore([H|T]) :-   current(X,Y,Z),
                    assertz(testcurrent(X,Y,Z)),
                    testsafe(H,X,Y,Z),
                    write(H),
                    explore2(T).

explore2([H|T]):- testcurrent(X,Y,Z),
                  testsafe(H,X,Y,Z),
                  write(H),
                  explore2(T).

testsafe(H,X,Y,Z) :- go(H).

go(forward):- testcurrent(X,Y,Z),
              orientation(Z).

orientation(rnorth):- testcurrent(X,Y,Z),
                        write("testing"),
                        D is Y+1,
                        retractall(testcurrent(_,_,_)),
                        assertz(testcurrent(X,D,Z)).

orientation(reast):- testcurrent(X,Y,Z),
                     D is X+1,
                     retractall(testcurrent(_,_,_)),
                     assertz(testcurrent(D,Y,Z)).

orientation(rsouth):- testcurrent(X,Y,Z),
                        D is Y-1,
                        retractall(testcurrent(_,_,_)),
                        assertz(testcurrent(X,D,Z)).

orientation(rwest):- testcurrent(X,Y,Z),
                     D is X-1,
                     retractall(testcurrent(_,_,_)),
                     assertz(testcurrent(D,Y,Z)).

go(turnright):- testcurrent(X,Y,Z),
                orientation(Z).

orientation(rnorth):- testcurrent(X,Y,Z),
                      retractall(testcurrent(_,_,_)),
                      assertz(testcurrent(X,Y,reast)).

orientation(reast):- testcurrent(X,Y,Z),
                     retractall(testcurrent(_,_,_)),
                     assertz(testcurrent(X,Y,rsouth)).

orientation(rsouth):- testcurrent(X,Y,Z),
                     retractall(testcurrent(_,_,_)),
                     assertz(testcurrent(X,Y,rwest)).

orientaton(rwest):- testcurrent(X,Y,Z),
                    retractall(testcurrent(_,_,_)),
                    assertz(testcurrent(X,Y,rnorth)).

go(turnleft):- testcurrent(X,Y,Z),
                orientation(Z).

orientation(rnorth):- testcurrent(X,Y,Z),
                      retractall(testcurrent(_,_,_)),
                      assertz(testcurrent(X,Y,rwest)).
 
orientation(reast):- testcurrent(X,Y,Z),
                     retractall(testcurrent(_,_,_)),
                     assertz(testcurrent(X,Y,rnorth)).

orientation(rsouth):- testcurrent(X,Y,Z),
                     retractall(testcurrent(_,_,_)),
                     assertz(testcurrent(X,Y,reast)).
                    
orientaton(rwest):- testcurrent(X,Y,Z),
                    retractall(testcurrent(_,_,_)),
                    assertz(testcurrent(X,Y,rsouth)).
*/


                

