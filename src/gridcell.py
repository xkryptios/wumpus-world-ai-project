import string


class GridCell:
    def __init__(self, x, y):

        self.cell_position = (x, y)

        # initialise sensory variables of cell-----------------
        self.confounded_indicator = False  # symbol 1 : % , else .
        self.stench_indicator = False  # symbol 2 : O , else .
        self.tingle_indicator = False  # symbol 3 : T , else .
        self.glitter_indicator = False  # 7  : * , else .
        # 8 : B , else . ( transitory, appear when moved forward and met a wall)
        self.bump_indicator = False
        self.scream_indicator = False  # symb 9 : @ else .
        # end of sensory variables---------------------

        self.agent_indicator = False  # 4 and 6 : - else ' '
        self.npc_indicator = False  # 4 and 6 : - else ' '

        # symb 5
        # alot of indicators...
        # if none of boolean variable for symb 5 is true, print ?
        # self.wumpus_known_or_possible = False
        # self.confundus_known_or_possible = False
        self.agent_direction = 'rnorth'
        self.safe = False
        self.visited = False

        # our own boolean values
        self.wall = False
        self.wumpus = False
        self.portal = False

    def print_cell_l1(self):

        if self.wall:
            print('# # #', end='')
            return
        symb1 = ' '
        symb2 = ' '
        symb3 = ' '
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
        if self.wumpus:
            symb5 = 'W'
            symb4 = symb6 = '-'

        elif self.portal:
            symb5 = 'O'
            symb4 = symb6 = '-'
        elif self.glitter_indicator:
            symb5 = '$'
            symb4 = symb6 = '-'
        elif self.agent_indicator:
            if self.agent_direction == 'rnorth':
                symb5 = '^'
            elif self.agent_direction == 'rsouth':
                symb5 = 'v'
            elif self.agent_direction == 'reast':
                symb5 = '>'
            elif self.agent_direction == 'rwest':
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
        symb7 = ' '
        symb8 = ' '
        symb9 = ' '
        if self.glitter_indicator:
            symb7 = '*'
        if self.bump_indicator:
            symb8 = 'B'
        if self.scream_indicator:
            symb9 = '@'
        print(f"{symb7} {symb8} {symb9}", end='')

    def set_tingle(self):
        self.tingle_indicator = True

    def set_stench(self):
        self.stench_indicator = True
    def delete_stench(self):
        self.stench_indicator = False

    # def set_confounded(self):
    #     self.confounded_indicator = True
    def set_wall(self):
        self.wall = True

    def set_agent(self, direction: string):
        self.agent_indicator = True
        self.agent_direction = direction

    def delete_agent(self):
        self.agent_indicator = False

    # def set_bump(self):
    #     self.bump_indicator = True

    # def set_scream(self):
    #     self.scream_indicator = True

    def set_visited(self):
        self.visited = True

    def set_unvisited(self):
        self.visited = False

    def place_wumpus(self):
        self.wumpus = True

    def place_coin(self):
        self.glitter_indicator = True

    def place_portal(self):
        self.portal = True

    def get_agent_direction(self):
        return self.agent_direction

    def is_wall(self):
        return self.wall

    def is_wumpus(self) -> bool:
        return self.wumpus

    def kill_wumpus(self):
        self.wumpus = False

    def is_portal(self):
        return self.portal

    def has_coin(self):
        return self.glitter_indicator

    def delete_coin(self):
        self.glitter_indicator = False

    def get_sensory_list(self):
        sensory_list = [self.confounded_indicator, self.stench_indicator, self.tingle_indicator, self.glitter_indicator,
                        self.bump_indicator, self.scream_indicator]
        # list = {confounded,stench,tingle,glitter,bump,scream}
        return sensory_list

    def get_cell_position(self):
        return self.cell_position


if __name__ == "__main__":
    c1 = GridCell()
    c1.print_cell_l1()
    c1.print_cell_l2()
    c1.print_cell_l3()
