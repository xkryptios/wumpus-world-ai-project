# from agent import Agent
from gridcell import GridCell
import random
SENSORY_CONSTANTS = ['confounded', 'stench',
                     'tingle', 'glitter', 'bump', 'scream']
ACTION_CONSTANTS = ['shoot', 'moveforward', 'turnleft', 'turnright', 'pickup']
DIRECTION_CONSTANTS = ['rnorth', 'rsouth', 'reast', 'rwest']


class Grid:
    def __init__(self, x, y):
        # check for grid size to be >=6
        # self.agent_location = (1, 1)
        self.x = x
        self.y = y
        if x < 6 or y < 6:
            print("invalid grid size! Default grid of 6x6 is created.")
            self.x = 6
            self.y = 6

        # initialisation of grid
        self.grid = []
        for i in range(self.y):
            temp = []  # array of cell
            for j in range(self.x):
                temp.append(GridCell(j, i))
            self.grid.append(temp)

        # set the border cells to walls
        for i in range(self.y):
            for j in range(self.x):
                if i == 0 or j == 0 or i == self.y - 1 or j == self.x - 1:
                    # print(type(self.grid[i][j]))
                    self.grid[i][j].set_wall()
        self.agent_current_cell = None
        self.initialise_npcs()
        self.spawn_agent()

    def display_grid(self):
        for i in range(self.y - 1, -1, -1):
            for j in range(self.x):
                self.grid[i][j].print_cell_l1()
                print(' | ', end='')
            print()
            for j in range(self.x):
                self.grid[i][j].print_cell_l2()
                print(' | ', end='')
            print()
            for j in range(self.x):
                self.grid[i][j].print_cell_l3()
                print(' | ', end='')
            print()
            print('--------' * self.x)

    def initialise_npcs(self):
        # suppose to random the location of all the npcs
        # but for now imma do a static location of the npcs
        # need to set 1x wumpus assume
        self.set_wumpus_location(1, 3)
        # need to set >= 1 coin
        self.set_coin_location(4, 3)
        # need to set >= 1 portal
        self.set_portal_location(4, 2)

        # self.spawn_agent()

    def set_wumpus_location(self, x, y):
        self.grid[y][x].place_wumpus()
        self.grid[y + 1][x].set_stench()
        self.grid[y - 1][x].set_stench()
        self.grid[y][x + 1].set_stench()
        self.grid[y][x - 1].set_stench()

    def set_portal_location(self, x, y):
        self.grid[y][x].place_portal()
        self.grid[y + 1][x].set_tingle()
        self.grid[y - 1][x].set_tingle()
        self.grid[y][x + 1].set_tingle()
        self.grid[y][x - 1].set_tingle()

    def set_coin_location(self, x, y):
        self.grid[y][x].place_coin()

    def spawn_agent(self) -> list:
        # agent is spawned at grid(1,1)
        if self.agent_current_cell != None:
            self.agent_current_cell.delete_agent()

        self.agent_current_cell = self.grid[1][1]
        self.agent_current_cell.set_agent('rnorth')
        self.agent_current_cell.set_visited()
        sensory_list = self.agent_current_cell.get_sensory_list()
        sensory_list[0] = True
        return sensory_list

    # start of agent movement functions for grid to keep track of agent
    def agent_rotate_left(self) -> list:
        direction = self.agent_current_cell.get_agent_direction()
        if direction == 'rnorth':
            self.agent_current_cell.set_agent('rwest')
        elif direction == 'rwest':
            self.agent_current_cell.set_agent('rsouth')
        elif direction == 'rsouth':
            self.agent_current_cell.set_agent('reast')
        else:
            self.agent_current_cell.set_agent('rnorth')
        # list = {confounded,stench,tingle,glitter,bump,scream}
        return self.agent_current_cell.get_sensory_list()

        # need change the location of the

    def agent_rotate_right(self) -> list:
        direction = self.agent_current_cell.get_agent_direction()
        if direction == 'rnorth':
            self.agent_current_cell.set_agent('reast')
        elif direction == 'reast':
            self.agent_current_cell.set_agent('rsouth')
        elif direction == 'rsouth':
            self.agent_current_cell.set_agent('rwest')
        else:
            self.agent_current_cell.set_agent('rnorth')

        # list = {confounded,stench,tingle,glitter,bump,scream}
        return self.agent_current_cell.get_sensory_list()

    def agent_move_forward(self) -> list:
        # check if the cell infront is a wall
        # if yes, return current cell senry with a bump
        # if no, set the location of agent in the grid to new cell, then return sensory of the new cell
        d = self.agent_current_cell.get_agent_direction()
        x = self.agent_current_cell.get_cell_position()[0]
        y = self.agent_current_cell.get_cell_position()[1]
        if d == 'rnorth':
            new_position = (x, y + 1)
        elif d == 'rsouth':
            new_position = (x, y - 1)
        elif d == 'reast':
            new_position = (x + 1, y)
        else:
            new_position = (x - 1, y)

        # check if is wall
        if self.grid[new_position[1]][new_position[0]].is_wall():
            sensory_list = self.agent_current_cell.get_sensory_list()
            sensory_list[4] = True
            return sensory_list

        # check if wumpus
        elif self.grid[new_position[1]][new_position[0]].is_wumpus():
            return self.reset_game()

        # check if is portal
        elif self.grid[new_position[1]][new_position[0]].is_portal():
            return self.teleport()

        # if agent land on a location with coin, coin will be take automatically
        # elif self.grid[new_position[1]][new_position[0]].has_coin():
            # self.grid[new_position[1]][new_position[0]].delete_coin()

        # if the next node is not wall, set the new location, set new the new cell
        self.agent_current_cell.delete_agent()
        self.agent_current_cell = self.grid[new_position[1]][new_position[0]]
        self.agent_current_cell.set_agent(d)
        self.agent_current_cell.set_visited()

        return self.agent_current_cell.get_sensory_list()

    def agent_pickup(self) -> list:
        if not self.agent_current_cell.has_coin():
            print("There is no coin in this location!")
        else:
            self.agent_current_cell.delete_coin()
        return self.agent_current_cell.get_sensory_list()

    def agent_shoot(self) -> list:
        # need to check the direction
        direction = self.agent_current_cell.get_agent_direction()
        position = self.agent_current_cell.get_cell_position()

        # locate target pixel
        if direction == 'rnorth':
            target_position = (position[0], position[1]+1)

        elif direction == 'rsouth':
            target_position = (position[0], position[1]-1)
        elif direction == 'reast':
            target_position = (position[0]+1, position[1])
        elif direction == 'rwest':
            target_position = (position[0]-1, position[1])
        else:
            raise ValueError("invalid direction!")

        sensory_list = self.agent_current_cell.get_sensory_list()
        if self.grid[target_position[1]][target_position[0]].is_wumpus():
            self.grid[target_position[1]][target_position[0]].kill_wumpus()
            sensory_list[5] = True
        return sensory_list

    def reset_game(self) -> list:
        for i in range(self.y):
            for j in range(self.x):
                self.grid[i][j].set_unvisited()
        return self.spawn_agent()

    def teleport(self) -> list:
        safe_location_list = [(1, 2), (2, 1), (3, 1)]
        new_postition = random.choice(safe_location_list)
        self.agent_current_cell.delete_agent()
        self.agent_current_cell = self.grid[new_postition[1]][new_postition[0]]
        self.agent_current_cell.set_agent('rnorth')
        sensory = self.agent_current_cell.get_sensory_list()
        sensory[0] = True
        return sensory

    def move(self, action):
        if action == 'shoot':
            return self.agent_shoot()
        if action == 'moveforward':
            return self.agent_move_forward()
        if action == 'turnleft':
            return self.agent_rotate_left()
        if action == 'turnright':
            return self.agent_rotate_right()
        if action == 'pickup':
            return self.agent_pickup()

    def explorable(self) -> bool:
        pass
    # def explorable(self) -> bool:
    #     # check if theres any more safe tiles to explore
    #     # can implement on the
    #     # return
    #     pass

    def get_path(self, p1: tuple, q: tuple) -> list:
        pass
        # if current cell has coin, issue pickup as a command by itself!!!!
        # else should plan a path from current cell to next safe cell

    # remove wumpus and sensories when killed
    def map_update_on_wumpus_kill(self):
        for i in range(self.x):
            for j in range(self.y):
                self.grid[i][j].delete_stench()

    def check_for_coin_in_current_cell(self):
        return self.agent_current_cell.has_coin()


if __name__ == "__main__":
    g = Grid(6, 6)
    g.display_grid()
    sensory = g.spawn_agent()
    g.display_grid()
    print(sensory)

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
        print("confou,stench,tingle,glitte,bumppp,scream")
        print(slist)
