class TicTacToe:

    def __init__(self):
        self.n = 0
        self.board = None

    def winner(self, n, x_moves, o_moves):
        self.n = n
        self.create_board(x_moves, o_moves)

        if self.player_wins("x"):
            return "x"
        elif self.player_wins("o"):
            return "o"
            
        return "nobody"

    def create_board(self, x_moves, o_moves):
        self.board = ["" for x in xrange(self.n*self.n)]
        for move in x_moves:
            self.board[self.n*move[0] + move[1]] = "x"
        for move in o_moves:
            self.board[self.n*move[0] + move[1]] = "o"

    def player_wins(self, player):
        return self.check_rows(player)


    def check_rows(self, player):
        for row_index in xrange(self.n):
            row = self.board[row_index*self.n : (row_index + 1)*self.n]
            if (row == [player for j in xrange(self.n)]):
                return True
        return False
        