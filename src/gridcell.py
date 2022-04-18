from enum import Enum


# noinspection SpellCheckingInspection
class Direction(Enum):
    rnorth = 1
    rsouth = 2
    reast = 3
    rwest = 4


class GridCell:
    def __init__(self):
        # initialise cell variables
        self.confounded_indicator = False  # symbol 1 : % , else .
        self.stench_indicator = False  # symbol 2 : O , else .
        self.tingle_indicator = False  # symbol 3 : T , else .

        self.agent_indicator = False  # 4 and 6 : - else ' '
        self.npc_indicator = False  # 4 and 6 : - else ' '

        # symb 5
        # alot of indicators...
        self.wumpus_known_or_possible = False
        self.confundus_known_or_possible = False

        self.agent_direction = Direction.rnorth
        self.safe = False
        self.visited = False

        # if none of boolean variable for symb 5 is true, print ?

        #

        self.glitter_indicator = False  # 7  : * , else .
        self.bump_indicator = False  # 8 : B , else . ( transitory, appear when moved forward and met a wall)
        self.scream_indicator = False  # symb 9 : @ else .

        # our own boolean values
        self.wall = False
        self.has_coin = False

    def print_cell_l1(self):

        if self.wall:
            print('# # #', end='')
            return
        symb1 = '.'
        symb2 = '.'
        symb3 = '.'
        if self.confounded_indicator:
            symb1 = '%'
        if self.stench_indicator:
            symb2 = '='
        if self.tingle_indicator:
            symb3 = 'T'
        print(f"{symb1} {symb2} {symb3}", end='')

    def print_cell_l2(self):
        if self.wall:
            print('# # #', end='')
            return

        symb4 = symb6 = ' '
        symb5 = '?'
        if self.wumpus_known_or_possible:
            symb5 = 'W'
            symb4 = symb6 = '-'

        elif self.confundus_known_or_possible:
            symb5 = 'O'
            symb4 = symb6 = '-'
        elif self.has_coin:
            symb5 = '$'
            symb4 = symb6 = '-'
        elif self.agent_indicator:
            if self.agent_direction == Direction.rnorth:
                symb5 = '^'
            elif self.agent_direction == Direction.rsouth:
                symb5 = 'v'
            elif self.agent_direction == Direction.reast:
                symb5 = '>'
            elif self.agent_direction == Direction.rwest:
                symb5 = '<'
            symb4 = symb6 = '-'
        elif not self.visited and self.safe:
            symb5 = 's'
        # elif self.visited and self.safe:
        elif self.visited:
            symb5 = 'S'
        print(f"{symb4} {symb5} {symb6}", end='')

    def print_cell_l3(self):
        if self.wall:
            print('# # #', end='')
            return
        symb7 = '.'
        symb8 = '.'
        symb9 = '.'
        if self.glitter_indicator:
            symb7 = '*'
        if self.bump_indicator:
            symb8 = 'B'
        if self.scream_indicator:
            symb9 = '@'
        print(f"{symb7} {symb8} {symb9}", end='')

    def set_wall(self):
        self.wall = True

    def set_tingle(self):
        self.tingle_indicator = True

    def set_stench(self):
        self.stench_indicator = True

    def set_confounded(self):
        self.confounded_indicator = True

    def set_agent(self, direction: Direction):
        self.agent_indicator = True
        self.agent_direction = direction

    def delete_agent(self):
        self.agent_indicator = False

    def set_glitter(self):
        self.glitter_indicator = True

    def set_bump(self):
        self.bump_indicator = True

    def set_scream(self):
        self.scream_indicator = True

    def set_visited(self):
        self.visited = True

    def place_wumpus(self):
        self.wumpus_known_or_possible = True

    def place_coin(self):
        self.has_coin = True

    def place_portal(self):
        self.confundus_known_or_possible = True

    def get_agent_direction(self):
        return self.agent_direction

    def is_wall(self):
        return self.wall

    def get_sensory_list(self):
        sensory_list = [self.confounded_indicator, self.stench_indicator, self.tingle_indicator, self.glitter_indicator,
                        self.bump_indicator, self.scream_indicator]
        # list = {confounded,stench,tingle,glitter,bump,scream}
        return sensory_list


if __name__ == "__main__":
    c1 = GridCell()
    c1.print_cell_l1()
    c1.print_cell_l2()
    c1.print_cell_l3()
