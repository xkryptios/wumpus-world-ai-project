
from re import S
from this import d
from grid import Grid
from pyswip import Prolog, Functor, Variable, Query

SENSORY_CONSTANTS = ['confounded', 'stench',
                     'tingle', 'glitter', 'bump', 'scream']
ACTION_CONSTANTS = ['shoot', 'moveforward', 'turnleft', 'turnright', 'pickup']
DIRECTION_CONSTANTS = ['rnorth', 'rsouth', 'reast', 'rwest', '_']
DIR_LEGENDS = {'rnorth':'^','rsouth':'v','reast':'>','rwest':'<'}
CONVERT_BOOL = {True:'on',False:'off'}

class Agent:
    def __init__(self, coin_count) -> None:
        self.prolog = Prolog()
        self.prolog.consult("Agent.pl")
        self.coin_count = coin_count

    def reborn(self) -> None:
        self.prolog.query("reborn()")

    def move(self, A, L: list) -> None:
        # list = {confounded,stench,tingle,glitter,bump,scream}
        if A not in ACTION_CONSTANTS:
            raise ValueError(f'{A} is not a valid action!')
        # q_string = f"move({A}, [{CONVERT_BOOL[L[0]]},{CONVERT_BOOL[L[1]]},{CONVERT_BOOL[L[2]]},{CONVERT_BOOL[L[3]]},{CONVERT_BOOL[L[4]]},{CONVERT_BOOL[L[5]]}])"
        q_string = f"move({A}, [{CONVERT_BOOL[L[0]]},{CONVERT_BOOL[L[1]]},{CONVERT_BOOL[L[2]]},{CONVERT_BOOL[L[3]]},{CONVERT_BOOL[L[4]]},{CONVERT_BOOL[L[5]]}])."
        print(q_string)
        list(self.prolog.query(q_string))
        # print(res)

    def reposition(self, L) -> None:
        q_string = f"reposition([{CONVERT_BOOL[L[0]]},{CONVERT_BOOL[L[1]]},{CONVERT_BOOL[L[2]]},{CONVERT_BOOL[L[3]]},{CONVERT_BOOL[L[4]]},{CONVERT_BOOL[L[5]]}])"
        list(self.prolog.query(q_string))

    def explore(self, L: list) -> bool:
        # true if list contain sequence of actions that leads agent to a safe+unvisited location
        # if no more safe+unvisited cell AND no coin in explored area => return to origin
        s = ''
        for action in L:
            if action not in ACTION_CONSTANTS:
                raise ValueError(f'{action} is not a value action!')
            s += action + ' ,'

        s = s[0:-2]
        q_string = f"explore([{s}])"
        print(q_string)
        return list(self.prolog.query(q_string))

    def current(self, x: int, y: int, d='_') -> bool:
        if d not in DIRECTION_CONSTANTS:
            raise ValueError(f'{d} is not a direction!')
        return bool(list(self.prolog.query(f"current({x},{y},{d})")))

    def hasarrow(self):
        return bool(list(self.prolog.query(f"hasarrow()")))

    # localisation methods , not sure if is implement here
    def visited(self, x: int, y: int) -> bool:
        return bool(list(self.prolog.query(f"visited({x},{y})")))
    def get_all_visited(self) -> list:
        list_of_dict = list(self.prolog.query(f"visited(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        coordinate_list = list( dict.fromkeys(coordinate_list) )
        return coordinate_list

    def wumpus(self, x: int, y: int) -> bool:
        return bool(list(self.prolog.query(f"wumpus({x},{y})")))

    def confundus(self, x: int, y: int) -> bool:
        #check if given cell has a possibility of confundus
        return bool(list(self.prolog.query(f"confundus({x},{y})")))

    def tingle(self, x: int, y: int) -> bool:
        return bool(list(self.prolog.query(f"tingle({x},{y})")))

    def glitter(self, x: int, y: int) -> bool:
        return bool(list(self.prolog.query(f"glitter({x},{y})")))

    def stench(self, x: int, y: int) -> bool:
        return bool(list(self.prolog.query(f"stench({x},{y})")))

    def safe(self, x: int, y: int) -> bool:
        return bool(list(self.prolog.query(f"safe({x},{y})")))
    def get_all_safe_cells(self) -> list:
        list_of_dict = list(self.prolog.query("safe(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        coordinate_list = list( dict.fromkeys(coordinate_list) )
        return coordinate_list

    def wall(self, x: int, y: int) -> bool:
        # print(list(self.prolog.query("wall(X,Y)")))
        return (bool(list(self.prolog.query(f"wall({x},{y})"))))

    def has_agent(self, x, y) -> bool:
        res = list(self.prolog.query(f"current({x},{y},D)"))
        return len(res) == 1

    def get_all_unvisited_safe_cells(self) -> list:
        safe = self.get_all_safe_cells()
        visited = self.get_all_visited()
        wall = self.get_all_wall()
        unvisited_safe = [cell for cell in safe if( cell not in visited and cell not in wall)]
        print("unvisited safe cells:",unvisited_safe)
        return unvisited_safe

    def get_current_location(self) -> tuple:
        dic = list(self.prolog.query('current(X,Y,D)'))[0]
        values_list = list(dic.values())
        return (values_list[0], values_list[1])

    def get_current_direction(self):
        dic = list(self.prolog.query('current(X,Y,D)'))[0]
        values_list = list(dic.values())
        return values_list[2]

    def get_all_wumpus(self):
        list_of_dict = list(self.prolog.query(f"wumpus(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        coordinate_list = list( dict.fromkeys(coordinate_list) )
        return coordinate_list

        pass
    def get_all_portal(self):
        list_of_dict = list(self.prolog.query(f"confundus(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        coordinate_list = list( dict.fromkeys(coordinate_list) )
        for i in coordinate_list:
            if type(i[0]) != int or type(i[0]) != int:
                print('get all ',self.get_all_safe_cells)
                print(list(self.prolog.query(f"confundus(X,Y)")))
                raise ValueError('weird tuple created')
        return coordinate_list

    def get_all_wall(self):
        list_of_dict = list(self.prolog.query(f"wall(X,Y)"))
        coordinate_list = []
        for i in list_of_dict:
            coordinate_list.append(tuple(i.values()))
        coordinate_list = list( dict.fromkeys(coordinate_list) )
        return coordinate_list
    
    def print_relative_map(self,sensory_list=[True,False,False,False,False,False]):
        cells = self.get_all_visited() + self.get_all_safe_cells() + self.get_all_portal() + self.get_all_wall() +self.get_all_wumpus()
        print(self.get_all_portal())
        max_x = 0
        min_x = 0
        max_y = 0
        min_y = 0
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
                    print("# # #",end=' | ')
                    continue
                elif self.current(x,y):# not sure if this a problem
                    if sensory_list[0]:
                        s1 = '%'
                    if sensory_list[1]:
                        s2 = '='
                    if sensory_list[3]:
                        s3 = 'T'
                    print(f"{s1} {s2} {s3}", end=' | ')
                    continue

                if self.stench(x,y):
                    s2 = '='
                if self.tingle(x,y):
                    s3 = 'T'
                print(f"{s1} {s2} {s3}", end=' | ')
            print()


            for x in range(min_x,max_x+1):
                s4 = s6 = ' '
                s5 = '?'
                if self.wall(x,y):
                    print("# # #",end=' | ')
                    continue
                elif self.current(x,y):# not sure if this a problem
                    dir = DIR_LEGENDS[self.get_current_direction()]
                    # print('yoooooooo',dir)
                    print(f"- {dir} -", end=' | ')
                    continue

                wumpus = self.wumpus(x,y)
                portal = self.confundus(x,y)
                safe = self.safe(x,y)
                visited = self.visited(x,y)

                if safe:
                    s4 = 's'
                if wumpus or portal :
                    s6 ='-'

                if wumpus and portal:
                    s5 = 'U'
                elif wumpus:
                    s5 = 'W'
                elif portal:
                    s5 = 'O'
                elif safe and visited:
                    s5 = 'S'
                elif safe:
                    s5 = 's'
                
                print(f"{s4} {s5} {s6}", end=' | ')
            print()



            for x in range(min_x,max_x+1):
                s7 = '.'
                s8 = '.'
                s9 = '.'
                if self.wall(x,y):
                    print('# # #',end=' | ')
                    continue
                elif self.current(x,y):# not sure if this a problem
                    if sensory_list[3]:
                        s7 = '*'
                    if sensory_list[1]:
                        s8 = 'B'
                    if sensory_list[3]:
                        s9 = '@'
                    print(f"{s7} {s8} {s9}", end=' | ')
                    continue
                
                if self.glitter(x,y):
                    s7 = '*'
                print(f"{s7} {s8} {s9}", end=' | ')
            print()
            print('--------'*(max_y-min_y+1))

    def get_traversible_nodes(self):
    #get all visited notes, then remove all walls
        visited = self.get_all_visited()
        wall = self.get_all_wall()
        no_wall = [cell for cell in visited if cell not in wall] 
        return no_wall


if __name__ == "__main__":
    for i in range(3, -2-1, -1):
        print(i)
