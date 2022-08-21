from copy import deepcopy
# from mcts import mcts, treeNode
try:
    from mcts_solver.mcts_solver import AntLionTreeNode, AntLionMcts
except ImportError:
    from mcts_solver import AntLionTreeNode, AntLionMcts

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


class AntMcts(AntLionMcts):
    def search(self, initialState, needDetails=False):
        self.root = AntLionTreeNode(initialState, None)

        if self.limitType == 'time':
            timeLimit = time.time() + self.timeLimit / 1000
            while time.time() < timeLimit:
                self.executeRound()
        else:
            for i in range(self.searchLimit):
                self.executeRound()

        bestChild = self.getBestChild(self.root, 0)
        action=(action for action, node in self.root.children.items() if node is bestChild).__next__()
        if needDetails:
            return {"action": action, "expectedReward": bestChild.totalReward / bestChild.numVisits}
        else:
            return action

    def executeRound(self):
        """
            execute a selection-expansion-simulation-backpropagation round
        """
        node = self.selectNode(self.root)
        # reward = self.rollout(node.state)
        reward = self.mcts_instance.mctsSolver(node)
        self.backpropogate(node, reward)


def console_script():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-f", "--fen", dest='fen', default=None, type=str, help="Initial FEN.")
    parser.add_argument("-r", "--iterationLimit", dest='iterationLimit', default=500, type=int, help="MCTS iterationLimit.  Default is 500.")
    args = parser.parse_args()

    initialState = ChessState(args.fen)
    # mymcts = mcts(timeLimit=1000)
    # mymcts = mcts(iterationLimit=500)
    mymcts = AntLionMcts(iterationLimit=args.iterationLimit)
    action = mymcts.search(initialState=initialState)

    print(action)


if __name__ == "__main__":
    console_script()
