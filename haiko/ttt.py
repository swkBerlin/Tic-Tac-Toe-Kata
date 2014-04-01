#!/usr/bin/env python
# encoding: utf-8

from __future__ import unicode_literals

X = 'x'
O = 'o'
TIE = 't'


def is_horizontal(moves, player, start, end):
    return moves[start:end] == 3 * player


def is_diagonal(moves, player):
    left = moves[0] == player and moves[4] == player and moves[-1] == player
    right = moves[2] == player and moves[4] == player and moves[6] == player
    return left or right


def is_vertical(moves, player, offset):
    return moves[offset] == player and moves[offset+3] == player and \
           moves[offset+6] == player


def check_horizontal(moves, player):
    return is_horizontal(moves, player, 0, 3) or \
        is_horizontal(moves, player, 3, -3) or \
        is_horizontal(moves, player, 6, 9)


def check_vertical(moves, player):
    return is_vertical(moves, player, 0) or \
           is_vertical(moves, player, 1) or \
           is_vertical(moves, player, 2)


def check_all(moves, player):
    return is_diagonal(moves, player) or check_horizontal(moves, player) or \
        check_vertical(moves, player)


def winner(moves):
    return (check_all(moves, X) and X) or (check_all(moves, O) and O) or TIE

