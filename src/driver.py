from logging.handlers import RotatingFileHandler
from multiprocessing.sharedctypes import Value
import string
from typing import final
from grid import Grid
from pyswip import Prolog, Functor, Variable, Query
from agent import Agent


def find_path(start, end, visited_list):
    if start not in visited_list or end not in visited_list:
        raise ValueError(
            f'start {start} or end {end} is not in visited list queried from AGENT!')
    # initialise graph in adj list
    adj = {}
    for i in visited_list:
        adj[i] = []
    for i in visited_list:
        x = i[0]
        y = i[1]
        if (x, y+1) in visited_list and (x, y+1) not in adj[x, y]:
            adj[(x, y)].append((x, y+1))
        if (x, y-1) in visited_list and (x, y-1) not in adj[x, y]:
            adj[(x, y)].append((x, y-1))
        if (x+1, y) in visited_list and (x+1, y) not in adj[x, y]:
            adj[(x, y)].append((x+1, y))
        if (x-1, y) in visited_list and (x-1, y) not in adj[x, y]:
            adj[(x, y)].append((x-1, y))

    # print(adj)

    # start of dfs
    q = []
    visited = []
    q.append(start)
    parent = {}
    parent[start] = None
    while len(q) != 0:
        cur_node = q.pop()  # pop the last in the list
        if cur_node in visited:
            continue
        visited.append(cur_node)
        print(f"{cur_node} is being expanded")

        if cur_node == end:
            print('path found')
            break

        adj_nodes = adj[cur_node]
        for node in adj_nodes:
            if node not in visited:
                q.append(node)
                parent[node] = cur_node
    # parent[start] = None

    # return a list in order from start to end node
    path_list = []
    # print(parent)
    temp = end
    while parent[temp] != None:
        path_list.append(temp)
        temp = parent[temp]

    path_list.append(start)
    path_list.reverse()

    return path_list


def convert_cell_to_action(path: list, initial_d: string):
    action_list = []

    # turn to the location
    last_direction = initial_d
    # move forward

    for i in range(len(path)-1):
        # [1 ,2 ,3,4]
        init_cell = path[i]
        final_cell = path[i+1]
        turns, last_direction = get_turns(
            init_cell, final_cell, last_direction)
        action_list += turns
        action_list.append('moveforward')
    return action_list


def get_turns(i, f, d) -> tuple:
    turn_list = []
    final_direction = ''
    if i[0] == f[0] and i[1] == f[1]+1:  # target cell below
        if d == 'rnorth':
            turn_list.append('turnleft')
            turn_list.append('turnleft')
        elif d == 'rsouth':
            pass
        elif d == 'reast':
            turn_list.append('turnright')
        elif d == 'rwest':
            turn_list.append('turnleft')
        else:
            raise ValueError(f'invalid direction {d}')
        final_direction = 'rsouth'
    elif i[0] == f[0] and i[1] == f[1]-1:  # target cell above

        if d == 'rnorth':
            pass
        elif d == 'rsouth':
            turn_list.append('turnleft')
            turn_list.append('turnleft')
        elif d == 'reast':
            turn_list.append('turnleft')
        elif d == 'rwest':
            turn_list.append('turnright')
        else:
            raise ValueError(f'invalid direction {d}')
        final_direction = 'rnorth'
    elif i[0] == f[0]+1 and i[1] == f[1]:  # target cell left
        if d == 'rnorth':
            turn_list.append('turnleft')
        elif d == 'rsouth':
            turn_list.append('turnright')
        elif d == 'reast':
            turn_list.append('turnleft')
            turn_list.append('turnleft')
        elif d == 'rwest':
            pass
        else:
            raise ValueError(f'invalid direction {d}')
        final_direction = 'rwest'
    elif i[0] == f[0]-1 and i[1] == f[1]:  # target cell right
        if d == 'rnorth':
            turn_list.append('turnright')
        elif d == 'rsouth':
            turn_list.append('turnleft')
        elif d == 'reast':
            pass
        elif d == 'rwest':
            turn_list.append('turnleft')
            turn_list.append('turnleft')
        else:
            raise ValueError(f'invalid direction {d}')
    else:
        raise ValueError(
            f'Invalid cell pair! {i}, {f} are not adjacent cells!')
        final_direction = 'reast'
    return turn_list, final_direction


if __name__ == "__main__":
    # initialise agent and map
    # g = Grid(6, 6)
    # agent = Agent(1)

    # g.display_grid()

    # # check if there is still safe cells
    # safe_cell_list = agent.get_all_safe_cells()
    # while len(safe_cell_list) != 0:
    #     # ask grid to get a list of action
    #     visited_list = agent.get_all_visited()
    #     end_location = safe_cell_list.pop()
    #     start_location = agent.get_current_location()
    #     action_list = find_path(start_location, end_location, visited_list)

    #     # if agent confirm the path is safe
    #     if agent.explore(action_list):
    #         for action in action_list:
    #             sensory_list = g.move(action)  # get sensory from the grid map
    #             # tell agent movement is made and update sensory
    #             agent.move(action, sensory_list)
    #     # check current place gt coin, if yes pickup
    #     # if g.check_for_coin_in_current_cell():

    # # get back to origin
    # origin = {'X': 0, 'Y': 0}
    # start_location = agent.get_current_location()
    # action_list = find_path(start_location, origin)
    # if agent.explore(action_list):
    #     for action in action_list:
    #         sensory_list = g.move(action)
    #         agent.move(action, sensory_list)

    # # finish exploration
    # print("end of exploration")
    # g.display_grid()

    safe_list = [(-1, 2), (1, 2)]
    visited_list = [(0, 1), (0, 0), (0, -1), (-1, 0), (1, 0), (0, 2), (-1, 2)]
    start = (0, 0)
    end = (-1, 2)
    res = find_path(start, end, visited_list)
    i_d = 'reast'
    print(res)
    actions = convert_cell_to_action(res, i_d)
    print(actions)
