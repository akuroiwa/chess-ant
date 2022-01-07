from copy import deepcopy
from mcts import mcts, treeNode
import chess
import argparse
import numpy as np
import math
from scipy.stats import norm
import random

class ChessState():
    def __init__(self, fen):
        if not fen:
            self.board = chess.Board()
        else:
            self.board = chess.Board(fen)
        self.color = True if self.board.turn == chess.WHITE else False

    def getCurrentPlayer(self):
        return 1 if self.board.turn == self.color else -1

    def getPossibleActions(self):
        possibleActions = list(self.board.legal_moves)
        return possibleActions

    def takeAction(self, action):
        newState = deepcopy(self)
        newState.board.push(action)
        return newState

    def isTerminal(self):
        return self.board.is_game_over()

    def getReward(self):
        stack_len = len(self.board.move_stack)

        if stack_len <= 8:
            score = 1
        else:
            score = 0

        if self.color == chess.WHITE:
            if self.board.result() == "1-0":
                return 1
            elif self.board.result() == "0-1":
                return -1
            elif self.board.result() == "1/2-1/2":
                return 0
        else:
            if self.board.result() == "1-0":
                return -1
            elif self.board.result() == "0-1":
                return 1
            elif self.board.result() == "1/2-1/2":
                return 0

        return False


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-f", "--fen", dest='fen', default=None, type=str, help="Initial FEN.")
    args = parser.parse_args()

    initialState = ChessState(args.fen)
    # mcts = mcts(timeLimit=1000)
    mcts = mcts(iterationLimit=500)
    action = mcts.search(initialState=initialState)

    print(action)
