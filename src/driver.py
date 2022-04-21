from grid import Grid
from pyswip import Prolog, Functor, Variable, Query
from agent import Agent

if __name__ == "__main__":
    # initialise agent and map
    g = Grid(6, 6)
    agent = Agent(1)

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
