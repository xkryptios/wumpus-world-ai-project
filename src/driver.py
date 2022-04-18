from grid import Grid
from pyswip import Prolog, Functor, Variable, Query


class Agent:
    def __init__(self) -> None:
        prolog = Prolog()
        prolog.consult("Agent.pl")

    def move(self, a, l) -> None:
        # actions constant = {shoot, moveforward,turnleft,turnright,pickup}
        pass

    def reposition(self, l) -> None:
        pass

    def explore(self, l) -> bool:
        # true if list contain sequence of actions that leads agent to a safe+unvisited location
        # if no more safe+unvisited cell AND no coin in explored area => return to origin
        pass

    def current(self, x, y, d):
        # is true if xy is the current relative position and d is current relative orientation of the agent
        pass

    def hasarrow(self):
        pass

    # localisation methods
    def visited(self, x: int, y: int) -> bool:
        pass

    def wumpus(self, x: int, y: int) -> bool:
        pass

    def confundus(self, x: int, y: int) -> bool:
        pass

    def tingle(self, x: int, y: int) -> bool:
        pass

    def glitter(self, x: int, y: int) -> bool:
        pass

    def stench(self, x: int, y: int) -> bool:
        pass

    def safe(self, x: int, y: int) -> bool:
        pass


if __name__ == "__main__":
    # create a grid
    g = Grid(6, 6)
    g.display_grid()
    cmd = ['l','r','f']
    # agent = Agent()
    while True:
        s = input("enter command: Left=l, Right=r, Forward=f ")
        if s not in cmd:
            continue

        if s == 'l':
            slist = g.agent_rotate_left()
        elif s == 'r':
            slist = g.agent_rotate_right()
        else:
            slist = g.agent_move_forward()

        g.display_grid()
        print("confou,stench,tingle,glitte,bumppp,scream")
        print(slist)
