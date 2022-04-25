from grid import Grid
from pyswip import Prolog, Functor, Variable, Query
from agent import Agent

if __name__ == "__main__":
    # initialise agent and map
    g = Grid(6, 6)
    agent = Agent(1)

    # ryan test
    prolog = Prolog()
    prolog.consult("Agent.pl")
    loc = list(agent.currentpos())  # agent call
    print(loc)
    # loc2 = list(prolog.query("move(moveforward, [0,0,0,0,0,0])")) # manual (need to have a list)
    
    agent.move("turnleft", [0, 0, 0, 0, 0, 0])  # turning left
    agent.move("moveforward", [0, 0, 0, 0, 1, 0])  # test bump
    loc10 = list(agent.prolog.query("listing(bump)"))
    print(loc10)
    loc8 = list(agent.currentpos())
    print(loc8)
    agent.move("turnright", [0, 0, 0, 0, 0, 0])  #go back to start

    #move to 0,1
    agent.move("moveforward", [0, 0, 0, 0, 0, 0])
    loc2 = list(agent.currentpos())
    print(loc2)

    loc12 = list(agent.prolog.query("listing(safe)"))
    print(loc12)

    #stay at 0,1
    agent.move("turnright", [0, 0, 0, 0, 0, 0])  # testing right turn
    loc3 = list(agent.currentpos())
    print(loc3)

    #move to 1,1
    agent.move("moveforward", [0, 1, 0, 0, 0, 0])  # testing stench
    loc4 = list(agent.currentpos())
    print(loc4)
    loc10 = list(agent.prolog.query("listing(wumpus)"))
    print(loc10)

    print("tesing wumpus assignment\n")

    #2,1
    agent.move("moveforward", [0, 0, 0, 0, 0, 0])
    print(list(agent.currentpos()))

    #2,1
    agent.move("turnleft", [0, 0, 0, 0, 0, 0])
    print(list(agent.currentpos()))

    #2,2
    agent.move("moveforward", [0, 1, 0, 0, 0, 0])
    print(list(agent.currentpos()))

    loc10 = list(agent.prolog.query("listing(wumpus)"))
    print(loc10)

    # loc10 = list(agent.prolog.query("listing(portal)"))
    # print(loc10)





    loc11 = list(agent.prolog.query("listing(confoundus)"))
    print(loc11)

    agent.move("moveforward", [0, 0, 1, 0, 0, 0])  # testing portal
    loc5 = list(agent.currentpos())
    print(loc5)

    agent.move("moveforward", [0, 0, 0, 1, 0, 0])  # testing coin
    loc5 = list(agent.currentpos())
    print(loc5)
    print(bool(list(agent.visited(3, 3))))  # testing agent visited
    print((bool(agent.visited)))  # testing agent visited
    print(bool(list(agent.visited(0, 0))))  # testing agent visited

    loc10 = list(agent.prolog.query("listing(stench)"))
    print(loc10)

    loc11 = list(agent.prolog.query("listing(wumpus)"))
    print(loc11)

    loc11 = list(agent.prolog.query("listing(visited)"))
    print(loc11)

    loc11 = list(agent.prolog.query("listing(tingle)"))
    print(loc11)

    loc11 = list(agent.prolog.query("listing(confoundus)"))
    print(loc11)


    loc12 = list(agent.prolog.query("safe(X,Y)"))
    print(loc12)

    loc5 = list(agent.currentpos())
    print(loc5)
    loc13 = list(agent.prolog.query("reposition([on, on, off, on, off, off])")) #test portal
    print(loc13)
    loc5 = list(agent.currentpos())
    print(loc5)

    loc11 = list(agent.prolog.query("listing(glitter)"))
    print(loc11)
    print(bool(list(agent.prolog.query("explore([forward,forward,forward])"))))
    #print((list(agent.prolog.query("explore([X])"))))


    # spawn agent on absolute map
    g.spawn_agent()
    # g.display_grid()
    # print(sensory)

    while g.explorable():
        # ask grid to get a list of action
        path = g.get_actions()

        # if agent confirm the path is safe
        if agent.explore(path):
            for action in path:
                sensory_list = g.move(action)  # get sensory from the grid map
                # tell agent movement is made and update sensory
                agent.move(action, sensory_list)
        # check current place gt coin, if yes pickup
        # if g.check_for_coin_in_current_cell():

    # finish exploration
    print("end of exploration")
    g.display_grid()
