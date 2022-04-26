from grid import Grid
from pyswip import Prolog, Functor, Variable, Query
from agent import CONVERT_BOOL, Agent
ACTIONS ={'l':'turnleft','r':'turnright','s':'shoot','p':'pickup','f':'moveforward'}


def find_path(start, end, visited_list):
    if start not in visited_list or end not in visited_list:
        if start not in visited_list:
            raise ValueError(
                f'start {start} node not in visited list queried from AGENT!')
        else:
            raise ValueError(
                f'end {end} node not in visited list queried from AGENT!')
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

        if cur_node == end:
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


def convert_cell_to_action(path: list, initial_d):
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
            print(type(d),d)
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
        final_direction = 'reast'
    else:
        raise ValueError(
            f'Invalid cell pair! {i}, {f} are not adjacent cells!')
    return turn_list, final_direction

def display_sensory(a='',S=[False,False,False,False,False,False]):
    print('\n\n------------------------------------------------------------------------------')
    print('| CONFOUNDED     STENCH       TINGLE      GLITTER        BUMP        SCREAM   |')
    print(f'|   {CONVERT_BOOL[S[0]]}           {CONVERT_BOOL[S[1]]}          {CONVERT_BOOL[S[2]]}          {CONVERT_BOOL[S[3]]}          {CONVERT_BOOL[S[4]]}          {CONVERT_BOOL[S[5]]}     |')
    print('------------------------------------------------------------------------------')
    print(f'LAST MOVE : {a.upper()}')


class Driver():
    def __init__(self) -> None:
        self.gui()

    def gui(self):
        ans = ['1','2','3','4']
        a = ''
        while True:
            print("enter a viable input (1-3)")
            print("1 :Run on grid manually ")
            print("2 :Let AI explore the grid by itself")
            print("3 :Test relocation and reborn functionality")
            print('4 : exit program')
            a = input()
            print()
            if a not in ans:
                continue
            break
            
        if a == '1':
            self.manual()
        elif a == '2':
            self.runai()
        elif a == '3':
            self.testreloc()
        elif a == '4':
            exit()
    def manual(self):
        g = Grid(6, 7)
        g.display_grid()
        print("confound,stench,tingle,glitter,bumpp,scream")
        print([True,False,False,False,False,False])



        cmd = ['l', 'r', 'f', 's', 'p']
        while True:
            s = input("enter command: Left=l, Right=r, Forward=f , Pickup=p, Shoot=s")
            if s not in cmd:
                continue
            if s == 'l':
                slist = g.agent_rotate_left()
            elif s == 'r':
                slist = g.agent_rotate_right()
            elif s == 'p':
                slist = g.agent_pickup()
            elif s == 's':
                slist = g.agent_shoot()
            else:
                slist = g.agent_move_forward()

            g.display_grid()
            print("confound,stench,tingle,glitter,bumpp,scream")
            print(slist)
    def runai(self):
        g = Grid(6, 7)
        agent = Agent(1)

        g.display_grid()
        # agent.reborn()
    
        # # check if there is still safe cells
        unvisited_safe_cell_list = agent.get_all_unvisited_safe_cells()
        display_sensory()
        agent.print_relative_map()
        input()
        while len(unvisited_safe_cell_list) != 0:
            # ask grid to get a list of action
            # visited_list = agent.get_all_visited()
            traversible_nodes = agent.get_traversible_nodes()
            end_location = unvisited_safe_cell_list.pop()
            start_location = agent.get_current_location()
            traversible_nodes.append(end_location)
            path_list = find_path(start_location, end_location, traversible_nodes)
            action_list = convert_cell_to_action(path_list,agent.get_current_direction())
            
            # if agent.explore(action_list):
            for action in action_list:
                # moving of agent
                sensory_list = g.move(action)
                agent.move(action,sensory_list)

                # displaying of grid
                display_sensory(action,sensory_list)
                agent.print_relative_map(sensory_list)
                input()
            unvisited_safe_cell_list = agent.get_all_unvisited_safe_cells()

            # check if current location has coin
            if sensory_list[3]:
                sensory_list = g.move('pickup')
                agent.move('pickup',sensory_list)
                display_sensory('pickup',sensory_list)
                agent.print_relative_map(sensory_list)
                input()


        #return to (0,0)
        start_location = agent.get_current_location()
        traversible_nodes = agent.get_traversible_nodes()
        path_list = find_path(start_location,(0,0),traversible_nodes)
        action_list = convert_cell_to_action(path_list,agent.get_current_direction())
        for action in action_list:
                # moving of agent
                sensory_list = g.move(action)
                agent.move(action,sensory_list)

                # displaying of grid
                display_sensory(action,sensory_list)
                agent.print_relative_map(sensory_list)
                input()
        print("All explorable cells have been explored!")
        print("End of exploration")
    
    def testreloc(self):
        g = Grid(6,7)
        agent = Agent(1)
        g.display_grid()
        agent.print_relative_map()

        cmd = ['l', 'r', 'f', 's', 'p']
        action = ''
        while True:
            s = input("enter command: Left=l, Right=r, Forward=f , Pickup=p, Shoot=s")
            if s not in cmd:
                continue
            if s == 'l':
                slist = g.agent_rotate_left()
            elif s == 'r':
                slist = g.agent_rotate_right()
            elif s == 'p':
                slist = g.agent_pickup()
            elif s == 's':
                slist = g.agent_shoot()
            else:
                slist = g.agent_move_forward()

            # g.display_grid()
            agent.move(ACTIONS[s],slist)
            agent.print_relative_map(slist)
            print("confound,stench,tingle,glitter,bumpp,scream")
            print(slist)
        

    




if __name__ == "__main__":
    d = Driver()
    


