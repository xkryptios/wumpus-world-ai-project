
import numpy as np

N = [0, 0, 0, 0, 0, 0]  # Confounded, Stench, Tingle, Glitter,Bump, Scream
# s = [0,1,0,0,0,0] #stench
# c = [0,0,0,1,0,0] #glitter


def initialize_grid(grid):
    wumpus = (2, 2)  # x , y
    portal = (2, 4)
    coin = (1, 4)
    for row in range(6):  # row
        # Add an empty array that will hold each cell
        # in this row
        grid.append([])
        for column in range(7):  # col
            if(column == wumpus[0]-1 and row == wumpus[1] or column == wumpus[0]+1 and row == wumpus[1] or column == wumpus[0] and row == wumpus[1]+1 or column == wumpus[0] and row == wumpus[1]-1):  # stench
                s = N.copy()
                s[1] = 1
                if(column == coin[0] and row == coin[1]):  # stench and glitter
                    s_c = s.copy()
                    s_c[3] = 1
                    # stench , glitter  , tingle
                    if(column == portal[0]-1 and row == portal[1] or column == portal[0]+1 and row == portal[1] or column == portal[0] and row == portal[1]+1 or column == portal[0] and row == portal[1]-1):
                        s_c_t = s_c.copy()
                        s_c_t[2] = 1
                        grid[row].append(s_c_t)
                        continue
                    grid[row].append(s_c)
                    continue
                if(column == portal[0]-1 and row == portal[1] or column == portal[0]+1 and row == portal[1] or column == portal[0] and row == portal[1]+1 or column == portal[0] and row == portal[1]-1):  # stench and tingle
                    s_t = s.copy()
                    s_t[2] = 1
                    # stench , tingle , glitter
                    if(column == coin[0] and row == coin[1]):
                        s_t_g = s_t.copy()
                        s_t_g[3] = 1
                        grid[row].append(s_t_g)
                        continue
                    grid[row].append(s_t)
                    continue
                grid[row].append(s)
                continue
            if(column == coin[0] and row == coin[1]):  # glitter
                c = N.copy()
                c[3] = 1
                if(column == portal[0]-1 and row == portal[1] or column == portal[0]+1 and row == portal[1] or column == portal[0] and row == portal[1]+1 or column == portal[0] and row == portal[1]-1):  # glitter and tingle
                    c_t = c.copy()
                    c_t[2] = 1
                    # glitter , tingle and stench
                    if(column == wumpus[0]-1 and row == wumpus[1] or column == wumpus[0]+1 and row == wumpus[1] or column == wumpus[0] and row == wumpus[1]+1 or column == wumpus[0] and row == wumpus[1]-1):
                        c_t_s = c_t.copy()
                        c_t_s[1] = 1
                        grid[row].append(c_t_s)
                        continue
                    grid[row].append(c_t)
                    continue
                if(column == wumpus[0]-1 and row == wumpus[1] or column == wumpus[0]+1 and row == wumpus[1] or column == wumpus[0] and row == wumpus[1]+1 or column == wumpus[0] and row == wumpus[1]-1):  # glitter , stench
                    c_s = c.copy()
                    c_s[1] = 1
                    # glitter,stench and tingle
                    if(column == portal[0]-1 and row == portal[1] or column == portal[0]+1 and row == portal[1] or column == portal[0] and row == portal[1]+1 or column == portal[0] and row == portal[1]-1):
                        c_s_t = c_s.copy()
                        c_s_t[2] = 1
                        grid[row].append(c_s_t)
                        continue
                    grid[row].append(c_s)
                    continue
                grid[row].append(c)
                continue
            if(column == portal[0]-1 and row == portal[1] or column == portal[0]+1 and row == portal[1] or column == portal[0] and row == portal[1]+1 or column == portal[0] and row == portal[1]-1):  # tingle
                t = N.copy()
                t[2] = 1
                if(column == coin[0] and row == coin[1]):  # tingle and glitter
                    t_g = t.copy()
                    t_g[3] = 1
                    # tingle , glitter and stench
                    if(column == wumpus[0]-1 and row == wumpus[1] or column == wumpus[0]+1 and row == wumpus[1] or column == wumpus[0] and row == wumpus[1]+1 or column == wumpus[0] and row == wumpus[1]-1):
                        t_g_s = t_g.copy()
                        t_g_s[1] = 1
                        grid[row].append(t_g_s)
                        continue
                    grid[row].append(t_g)
                    continue
                if(column == wumpus[0]-1 and row == wumpus[1] or column == wumpus[0]+1 and row == wumpus[1] or column == wumpus[0] and row == wumpus[1]+1 or column == wumpus[0] and row == wumpus[1]-1):  # tingle and stench
                    t_s = t.copy()
                    t_s[1] = 1
                    # tingle , stench and glitter
                    if(column == coin[0] and row == coin[1]):
                        t_s_g = t_s.copy()
                        t_s_g[3] = 1
                        grid[row].append(t_s_g)
                        continue
                    grid[row].append(t_s)
                    continue
                grid[row].append(t)
                continue
            grid[row].append(N)  # Append a cell
        print(grid[row])


def print_grid(grid):
    grid = np.array(grid)
    rows = grid.shape[0]
    cols = grid.shape[1]
    for i in range(row-1):
        print(grid[i], end=""),
    print()
    # print()


class agent:
    x = 0
    y = 0
    location = (x, y)  # starting location

    def reset(self):
        location = (0, 0)
        print("you have been resetted to 0,0.")

    def moveUp(self):
        self.x += 1
        self.check_pos()
        location = (self.x, self.y)
        print("you have moved up to position:", self.x, self.y)

    def moveLeft(self):
        self.y -= 1
        self.check_pos()
        location = (self.x, self.y)
        print("you have moved up to position:", self.x, self.y)

    def moveRight(self):
        self.y += 1
        self.check_pos()
        location = (self.x, self.y)
        print("you have moved up to position:", self.x, self.y)

    def current_pos(self):
        return (self.x, self.y)

    def check_pos(self):
        if(self.x > 5):
            print("unsucessfull move , you have hit a wall")
            print("bump!!!")
            self.x -= 1
        elif(self.y < 0):
            print("unsucessfull move , you have hit a wall")
            print("bump!!!")
            self.y += 1
        elif(self.y > 6):
            print("unsucessfull move , you have hit a wall")
            print("bump!!!")
            self.y -= 1
        else:
            print("successfull move!")


if __name__ == "__main__":
    grid = []
    initialize_grid(grid)  # create grid
    agent = agent()
    print(agent.location)
    move = input("Please enter your move: ")
    while(move != "-1"):
        if(move == "up"):
            agent.moveUp()
            print("Assesing position row[", agent.x, "] " "col[", agent.y, "]")
            print(grid[agent.x][agent.y])
        if(move == "left"):
            agent.moveLeft()
            print("Assesing position row[", agent.x, "] " "col[", agent.y, "]")
            print(grid[agent.x][agent.y])
        if(move == "right"):
            agent.moveRight()
            print("Assesing position row[", agent.x, "] " "col[", agent.y, "]")
            print(grid[agent.x][agent.y])
        move = input("Please enter your next move: ")
