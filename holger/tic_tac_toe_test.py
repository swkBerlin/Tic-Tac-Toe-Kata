import unittest
from tic_tac_toe import TicTacToe

class TicTacToeTest(unittest.TestCase):

    def test_x_wins(self):
        game = TicTacToe()
        winner = game.winner(1, [(0,0)], [])
        self.assertEquals(winner, "x")

    def test_o_rows_board(self):
        game = TicTacToe()
        winner = game.winner(3, [], [(0,0), (0,1), (0,2)])
        self.assertEquals(winner, "o")

    def test_x_second_line(self):
        game = TicTacToe()
        winner = game.winner(3, [], [(1,0), (1,1), (1,2)])
        self.assertEquals(winner, "o")

    def test_nobody_wins(self):
        game = TicTacToe()
        winner = game.winner(3, [], [])
        self.assertEquals(winner, "nobody")

if __name__ == '__main__':
    unittest.main()