from grid import Grid
from pyswip import Prolog, Functor, Variable, Query
from agent import Agent

def find_path(start,end,visited_list):
    pass

if __name__ == "__main__":
    # initialise agent and map
    g = Grid(6, 6)
    agent = Agent(1)

    g.display_grid()

    #check if there is still safe cells
    safe_cell_list = agent.get_all_safe_cells()
    while len(safe_cell_list) != 0:
        # ask grid to get a list of action
        visited_list = agent.get_all_visited()
        end_location = safe_cell_list.pop()
        start_location = agent.get_current_location()
        action_list = find_path(start_location,end_location,visited_list)



        # if agent confirm the path is safe
        if agent.explore(action_list):
            for action in action_list:
                sensory_list = g.move(action)  # get sensory from the grid map
                # tell agent movement is made and update sensory
                agent.move(action, sensory_list)
        # check current place gt coin, if yes pickup
        # if g.check_for_coin_in_current_cell():
    
    #get back to origin
    origin = {'X':0,'Y':0}
    start_location = agent.get_current_location()
    action_list = find_path(start_location,origin)
    if agent.explore(action_list):
        for action in action_list:
            sensory_list = g.move(action)
            agent.move(action,sensory_list)

    # finish exploration
    print("end of exploration")
    g.display_grid()
