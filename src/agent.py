from tokenize import String
from grid import Grid
from pyswip import Prolog, Functor, Variable, Query

SENSORY_CONSTANTS = ['confounded', 'stench',
                     'tingle', 'glitter', 'bump', 'scream']
ACTION_CONSTANTS = ['shoot', 'moveforward', 'turnleft', 'turnright', 'pickup']
DIRECTION_CONSTANTS = ['rnorth', 'rsouth', 'reast', 'rwest']


class Agent:
    def __init__(self, coin_count) -> None:
        self.prolog = Prolog()
        self.prolog.consult("Agent.pl")
        self.coin_count = coin_count
        self.visited_list = []
        self.safe_lsit = []

    def reborn(self) -> None:
        self.prolog.query("reborn()")

    def move(self, A: String, L: list) -> None:
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

    def current(self, x: int, y: int, d: String) -> bool:
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
        return self.prolog.query(f"confundus({x},{y})")

    def tingle(self, x: int, y: int) -> bool:
        return self.prolog.query(f"tingle({x},{y})")

    def glitter(self, x: int, y: int) -> bool:
        return self.prolog.query(f"glitter({x},{y})")

    def stench(self, x: int, y: int) -> bool:
        return self.prolog.query(f"stench({x},{y})")

    def safe(self, x: int, y: int) -> bool:
        return self.prolog.query(f"safe({x},{y})")
    def get_all_visited(self)->list:
        return list(self.prolog.query(f"visited(X,Y)"))
    def get_all_safe_cells(self)->list:
        return list(self.prolog.query("safe(X,Y"))
    
    def get_current_location(self):
        return list(self.prolog.query('current(X,Y,D'))[0]


if __name__ == "__main__":
    print("hello")
    # pass
    origin = {'X':0,'Y':0}
    a = list(origin)
    print(type(a),a)
