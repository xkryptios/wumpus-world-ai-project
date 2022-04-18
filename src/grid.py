from grid_cell import Grid_cell

class Grid:
    def __init__(self,x,y):
        # check for grid size to be >=6
        self.x = x
        self.y = y
        if x<6 or y<6:
            print("invalid grid size! Default grid of 6x6 is created.")
            self.x = 6
            self.y = 6
        
        #initialisation of grid 
        self.grid = []
        for i in range(self.y):
            temp = [] # array of cell
            for j in range(self.x):
                temp.append(Grid_cell())
            self.grid.append(temp)
        
        #set the border cells to walls
        for i in range(self.y):
            for j in range(self.x):
                if i == 0 or j == 0 or i == self.y-1 or j == self.x-1:
                    # print(type(self.grid[i][j]))
                    self.grid[i][j].set_wall()
        
        self.initialise_map()

        
    def display_grid(self):
        for i in range(self.y-1,-1,-1):
                for j in range(self.x):
                    self.grid[i][j].print_cell_l1()
                    print(' | ',end='')
                print()
                for j in range(self.x):
                    self.grid[i][j].print_cell_l2()
                    print(' | ',end='')
                print()
                for j in range(self.x):
                    self.grid[i][j].print_cell_l3()
                    print(' | ',end='')
                print()
                print('--------'*self.x)

    def initialise_map(self):
        # suppose to random the location of all the npcs
        # but for now imma do a static location of the npcs
        #need to set 1x wumpus assume
        self.set_wumpus_location(1,3)
        #need to set >= 1 coin
        self.set_coin_location(4,3)
        #need to set >= 1 portal
        self.set_portal_location(4,2)
        
    def set_wumpus_location(self,x,y):
        self.grid[y][x].place_wumpus()
        self.grid[y+1][x].set_stench()
        self.grid[y-1][x].set_stench()
        self.grid[y][x+1].set_stench()
        self.grid[y][x-1].set_stench()
    def set_portal_location(self,x,y):
        self.grid[y][x].place_portal()
        self.grid[y+1][x].set_tingle()
        self.grid[y-1][x].set_tingle()
        self.grid[y][x+1].set_tingle()
        self.grid[y][x-1].set_tingle()
    def set_coin_location(self,x,y):
        self.grid[y][x].place_coin()
        self.grid[y+1][x].set_glitter()
        self.grid[y-1][x].set_glitter()
        self.grid[y][x+1].set_glitter()
        self.grid[y][x-1].set_glitter()




if __name__ == "__main__":
    g = Grid(6,6)
    g.display_grid()