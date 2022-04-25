
from re import S
from grid import Grid
from pyswip import Prolog, Functor, Variable, Query

SENSORY_CONSTANTS = ['confounded', 'stench',
                     'tingle', 'glitter', 'bump', 'scream']
ACTION_CONSTANTS = ['shoot', 'moveforward', 'turnleft', 'turnright', 'pickup']
DIRECTION_CONSTANTS = ['rnorth', 'rsouth', 'reast', 'rwest', '_']
DIR_LEGENDS = {'rnorth':'^','rsouth':'v','reast':'>','rwest':'<'}

class Agent:
    def __init__(self, coin_count) -> None:
        self.prolog = Prolog()
        self.prolog.consult("Agent.pl")
        self.coin_count = coin_count

    def reborn(self) -> None:
        self.prolog.query("reborn()")

    def move(self, A, L: list) -> None:
        # list = {confounded,stench,tingle,glitter,bump,scream}
        # convert list of bool to on/off
        if A not in ACTION_CONSTANTS:
            raise ValueError(f'{A} is not a valid action!')
        confound = 'off'
        stench = 'off'
        tingle = 'off'
        glitter = 'off'
        bump = 'off'
        scream = 'off'
        if L[0]:
            confound = 'on'
        if L[1]:
            stench = 'on'
        if L[2]:
            tingle = 'on'
        if L[3]:
            glitter = 'on'
        if L[4]:
            bump = 'on'
        if L[5]:
            scream = 'on'
        self.prolog.query(
            f"move({A}, [{confound},{stench},{tingle},{glitter},{bump},{scream}]).")

    def reposition(self, L) -> None:
        confound = 'off'
        stench = 'off'
        tingle = 'off'
        glitter = 'off'
        bump = 'off'
        scream = 'off'
        if L[0]:
            confound = 'on'
        if L[1]:
            stench = 'on'
        if L[2]:
            tingle = 'on'
        if L[3]:
            glitter = 'on'
        if L[4]:
            bump = 'on'
        if L[5]:
            scream = 'on'
        self.prolog.query(
            f"reposition([{confound},{stench},{tingle},{glitter},{bump},{scream}])")

    def explore(self, L: list) -> bool:
        # true if list contain sequence of actions that leads agent to a safe+unvisited location
        # if no more safe+unvisited cell AND no coin in explored area => return to origin
        s = ''
        for action in L:
            if action not in ACTION_CONSTANTS:
                raise ValueError(f'{action} is not a value action!')
            s += action + ' ,'

        s = s[0:-2]
        return self.prolog.query(f"explore([{s}])")

    def current(self, x: int, y: int, d='_') -> bool:
        if d not in DIRECTION_CONSTANTS:
            raise ValueError(f'{d} is not a direction!')
        # is true if xy is the current relative position and d is current relative orientation of the agent
        return self.prolog.query(f"current([{x},{y},{d}])")

    def hasarrow(self):
        return self.prolog.query(f"hasarrow()")

    # localisation methods , not sure if is implement here
    def visited(self, x: int, y: int) -> bool:
        return self.prolog.query(f"visited({x},{y})")

    def wumpus(self, x: int, y: int) -> bool:
        return self.prolog.query(f"wumpus({x},{y})")

    def confundus(self, x: int, y: int) -> bool:
        #check if given cell has a possibility of confundus
        return self.prolog.query(f"confundus({x},{y})")

    def tingle(self, x: int, y: int) -> bool:
        return self.prolog.query(f"tingle({x},{y})")

    def glitter(self, x: int, y: int) -> bool:
        return self.prolog.query(f"glitter({x},{y})")

    def stench(self, x: int, y: int) -> bool:
        return self.prolog.query(f"stench({x},{y})")

    def safe(self, x: int, y: int) -> bool:
        return self.prolog.query(f"safe({x},{y})")

    def wall(self, x: int, y: int) -> bool:
        return self.prolog.query(f"wall({x},{y})")

    def has_agent(self, x, y) -> bool:
        res = list(self.prolog.query(f"agent({x},{y},D)"))
        return len(res) == 1

    def get_all_visited(self) -> list:
        list_of_dict = list(self.prolog.query(f"visited(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        return coordinate_list

    def get_all_safe_cells(self) -> list:
        list_of_dict = list(self.prolog.query("safe(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        return coordinate_list

    def get_all_unvisited_safe_cells(self) -> list:
        safe = self.get_all_safe_cells()
        visited = self.get_all_visited()
        unvisited_safe = [cell for cell in safe if cell not in visited]
        return unvisited_safe

    def get_current_location(self) -> tuple:
        dic = list(self.prolog.query('current(X,Y,D)'))[0]
        values_list = list(dic.values())
        return (values_list[0], values_list[1])

    def get_current_direction(self):
        dic = list(self.prolog.query('current(X,Y,D)'))[0]
        values_list = list(dic.values())
        print(values_list)
        return values_list[2]
    
    def print_relative_map(self,sensory_list):
        cells = self.get_all_visited() + self.get_all_safe_cells()
        max_x = 0
        min_x = 0
        max_y = 0
        min_x = 0
        for cell in cells:
            max_x = max(max_x,cell[0])
            min_x = min(min_x,cell[0])
            max_y = max(max_y,cell[1])
            min_y = min(min_y,cell[1])
        
        for y in range(max_y,min_y-1,-1):
            for x in range(min_x,max_x+1):

                s1 = '.'
                s2 = '.'
                s3 = '.'
                if self.wall(x,y):
                    print("# # #",end='')
                    continue
                elif self.current(x,y):# not sure if this a problem
                    if sensory_list[0]:
                        s1 = '%'
                    if sensory_list[1]:
                        s2 = '='
                    if sensory_list[3]:
                        s3 = 'T'
                    print(f"{s1} {s2} {s3}", end='')
                    continue

                if self.stench(x,y):
                    s2 = '='
                if self.tingle(x,y):
                    s3 = 'T'
                print(f"{s1} {s2} {s3}", end='')


            for x in range(min_x,max_x+1):
                s4 = s6 = ' '
                s5 = '?'
                if self.wall(x,y):
                    print("# # #",end='')
                    continue
                elif self.current(x,y):# not sure if this a problem
                    print(f"- {DIR_LEGENDS[self.get_current_direction()]} -", end='')
                    continue

                wumpus = self.wumpus(x,y)
                portal = self.confundus(x,y)

                if wumpus or portal:
                    s4 = s6 ='-'

                if wumpus and portal:
                    s5 = 'U'
                elif wumpus:
                    s5 = 'W'
                elif portal:
                    s5 = 'O'
                print(f"{s4} {s5} {s6}", end='')



            for x in range(min_x,max_x+1):
                s7 = '.'
                s8 = '.'
                s9 = '.'
                if self.wall(x,y):
                    print('# # #',end='')
                    continue
                elif self.current(x,y):# not sure if this a problem
                    if sensory_list[3]:
                        s7 = '*'
                    if sensory_list[1]:
                        s8 = 'B'
                    if sensory_list[3]:
                        s9 = '@'
                    print(f"{s7} {s8} {s9}", end='')
                    continue
                
                if self.glitter(x,y):
                    s7 = '*'
                print(f"{s7} {s8} {s9}", end='')
                


        pass


if __name__ == "__main__":
    for i in range(3, -2-1, -1):
        print(i)
