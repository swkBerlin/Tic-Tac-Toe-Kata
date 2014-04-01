#!/usr/bin/env python
# encoding: utf-8

from __future__ import unicode_literals

import unittest

from ttt import winner, X, O, TIE


class KataTest(unittest.TestCase):
    def test_X_won_horizontal_begin(self):
        moves = 'xxx' \
                'o_o' \
                '___'
        self.assertEquals(winner(moves), X)

    def test_X_won_horizontal_middle(self):
        moves = '_o_' \
                'xxx' \
                'o_o'
        self.assertEquals(winner(moves), X)

    def test_X_won_horizontal_end(self):
        moves = '___' \
                'o_o' \
                'xxx'
        self.assertEquals(winner(moves), X)

    def test_O_won_horizontal_begin(self):
        moves = 'ooo' \
                'x_x' \
                '___'
        self.assertEquals(winner(moves), O)

    def test_O_won_horizontal_middle(self):
        moves = '_x_' \
                'ooo' \
                'x_x'
        self.assertEquals(winner(moves), O)

    def test_O_won_horizontal_end(self):
        moves = '___' \
                'x_x' \
                'ooo'
        self.assertEquals(winner(moves), O)
    def test_X_won_diagonal_left_to_right(self):
        moves = 'xo_' \
                'ox_' \
                '__x'
        self.assertEqual(winner(moves), X)

    def test_X_won_diagonal_right_to_left(self):
        moves = 'o_x' \
                'ox_' \
                'x__'
        self.assertEqual(winner(moves), X)

    def test_O_won_diagonal_left_to_right(self):
        moves = 'ox_' \
                'xo_' \
                '__o'
        self.assertEqual(winner(moves), O)

    def test_O_won_diagonal_right_to_left(self):
        moves = 'x_o' \
                'xo_' \
                'o__'
        self.assertEqual(winner(moves), O)

    def test_X_won_vertical_begin(self):
        moves = 'xo_' \
                'xo_' \
                'x__'
        self.assertEqual(winner(moves), X)

    def test_X_won_vertical_middle(self):
        moves = '_xo' \
                '_xo' \
                '_x_'
        self.assertEqual(winner(moves), X)

    def test_X_won_vertical_end(self):
        moves = '__x' \
                'o_x' \
                'o_x'
        self.assertEqual(winner(moves), X)

    def test_O_won_vertical_begin(self):
        moves = 'ox_' \
                'ox_' \
                'o__'
        self.assertEqual(winner(moves), O)

    def test_O_won_vertical_middle(self):
        moves = '_ox' \
                '_ox' \
                '_o_'
        self.assertEqual(winner(moves), O)

    def test_O_won_vertical_end(self):
        moves = '__o' \
                'x_o' \
                'x_o'
        self.assertEqual(winner(moves), O)

    def test_tie_1(self):
        moves = 'oxo' \
                'xox' \
                'xox'
        self.assertEqual(winner(moves), TIE)

    def test_tie_2(self):
        moves = 'xox' \
                'oxo' \
                'oxo'
        self.assertEqual(winner(moves), TIE)


if __name__=='__main__':
    unittest.main()

