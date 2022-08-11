"""
This is based on the code of
`deap/examples/gp/ant.py <https://github.com/DEAP/deap/blob/master/examples/gp/ant.py>`__.
"""

import copy
import random

import numpy

from functools import partial

from deap import algorithms
from deap import base
from deap import creator
from deap import tools
from deap import gp

import chess
import chess.pgn

from copy import deepcopy
# from mcts import mcts, treeNode
try:
    from mcts_solver.mcts_solver import AntLionTreeNode, AntLionMcts
except ImportError:
    from mcts_solver import AntLionTreeNode, AntLionMcts

try:
    from .chess_mcts import ChessState
except ImportError:
    from chess_mcts import ChessState
import math
import time
import os

import argparse
import pandas as pd
from collections import deque
# import sys
# from concurrent.futures.process import ProcessPoolExecutor


# def progn(*args):
#     with ProcessPoolExecutor(max_workers=os.cpu_count()) as executor:
#         for arg in args:
#             executor.submit(arg)

def progn(*args):
    for arg in args:
        arg()

def prog2(out1, out2):
    return partial(progn,out1,out2)

def prog3(out1, out2, out3):
    return partial(progn,out1,out2,out3)

def if_then_else(condition, out1, out2):
    out1() if condition() else out2()

def if_nest(condition, out1, out2, out3):
    out1() if condition() == 2 else out2() if condition() == 1 else out3()

class ChessAntSimulator(object):

    def __init__(self):
        self.previous_eaten = 0
        self.eaten = 0
        self.routine = None
        self.previous_length = float("inf")
        self.previous_is_check = False
        self.numVisits = 0
        self.improvement = 0
        self.shortcut = 0
        self.result = 0
        self.pruning = 0

    def _reset(self):
        self.previous_eaten = 0
        self.eaten = 0
        self.previous_length = float("inf")
        self.previous_is_check = False
        self.numVisits = 0
        self.improvement = 0
        self.shortcut = 0
        self.result = 0
        self.pruning = 0

    @property
    def get_prediction(self):
        bestChild = self.mcts_instance.getBestChild(self.root, 0)
        action=(action for action, node in self.root.children.items() if node is bestChild).__next__()
        return action

    def set_fen(self, fen):
        self.fen = fen
        self.initialState = ChessState(self.fen)
        self.mcts_instance = AntMcts(iterationLimit=10)
        # self.root = AntTreeNode(self.initialState, None)
        self.root = AntLionTreeNode(self.initialState, None)

    def set_dl(self):
        self.mcts_instance.dl = True
        try:
            from chess_classification.chess_classification import ChessClassification
        except ImportError:
            from chess_classification import ChessClassification
        self.mcts_instance.classification = ChessClassification()

    def selectNode_1(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(1))
        self._executeRound(node, 3)

    def selectNode(self):
        node = self.mcts_instance.selectNode(self.root)
        self._executeRound(node, 2)

    def selectNode_3(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(3))
        self._executeRound(node, 3)

    def selectNode_4(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(4))
        self._executeRound(node, 4)

    def selectNode_5(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(5))
        self._executeRound(node, 5)

    def selectNode_6(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(6))
        self._executeRound(node, 6)

    def selectNode_7(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(7))
        self._executeRound(node, 7)

    def selectNode_8(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(8))
        self._executeRound(node, 8)

    def selectNode_9(self):
        node = self.mcts_instance.selectNode_num(self.root, 1 / math.sqrt(9))
        self._executeRound(node, 9)

    def _executeRound(self, node, sqrt_num):
        # reward = self.mcts_instance.rollout(node.state)
        reward = self.mcts_instance.mctsSolver(node)
        length = len(node.state.board.move_stack)
        self.previous_is_check = node.state.board.is_check()
        self.mcts_instance.backpropogate(node, reward)
        self.numVisits = node.numVisits
        explorationValue = 1 / math.sqrt(sqrt_num)
        self.eaten = node.parent.state.getCurrentPlayer() * node.totalReward / node.numVisits + explorationValue * math.sqrt(
            2 * math.log(self.root.numVisits) / node.numVisits)
        self.improvement = 2 if self.eaten > self.previous_eaten else 1 if self.eaten == self.previous_eaten else 0
        self.previous_eaten = self.eaten
        self.shortcut = 2 if length > self.previous_length else 1 if length == self.previous_length else 0
        self.previous_length = length
        self.result = 2 if node.state.getReward() == 1 else 1 if node.state.getReward() == -1 else 0
        self.pruning = 2 if self.eaten == float("inf") else 1 if self.eaten == float("-inf") else 0

    def sense_improvement(self):
        return self.improvement

    def if_improvement(self, out1, out2, out3):
        return partial(if_nest, self.sense_improvement, out1, out2, out3)

    def sense_shortcut(self):
        return self.shortcut

    def if_shortcut(self, out1, out2, out3):
        return partial(if_nest, self.sense_shortcut, out1, out2, out3)

    def sense_result(self):
        return self.result

    def if_result(self, out1, out2, out3):
        return partial(if_nest, self.sense_result, out1, out2, out3)

    def sense_pruning(self):
        return self.pruning

    def if_pruning(self, out1, out2, out3):
        return partial(if_nest, self.sense_pruning, out1, out2, out3)

    def sense_is_check(self):
        return self.previous_is_check

    def if_is_check(self, out1, out2):
        return partial(if_then_else, self.sense_is_check, out1, out2)

    def run(self,routine):
        self._reset()
        routine()


class AntMcts(AntLionMcts):

    def dl_method(self, bestChild):
        prediction, raw_outputs = self.classification.predict_fen(bestChild.state.board.fen())
        if prediction == 2:
            dl_prediction = 1
        elif prediction == 1:
            dl_prediction = -1
        else:
            dl_prediction = 0
        reward = bestChild.state.getCurrentPlayer() * -dl_prediction


ant = ChessAntSimulator()

pset = gp.PrimitiveSet("MAIN", 0)
pset.addPrimitive(prog2, 2)
pset.addPrimitive(prog3, 3)
pset.addPrimitive(ant.if_improvement, 3)
pset.addPrimitive(ant.if_shortcut, 3)
pset.addPrimitive(ant.if_result, 3)
pset.addPrimitive(ant.if_pruning, 3)
pset.addPrimitive(ant.if_is_check, 2)
pset.addTerminal(ant.selectNode_1)
pset.addTerminal(ant.selectNode)
pset.addTerminal(ant.selectNode_3)
pset.addTerminal(ant.selectNode_4)
pset.addTerminal(ant.selectNode_5)
pset.addTerminal(ant.selectNode_6)
pset.addTerminal(ant.selectNode_7)
pset.addTerminal(ant.selectNode_8)
pset.addTerminal(ant.selectNode_9)

creator.create("FitnessMax", base.Fitness, weights=(1.0,))
creator.create("Individual", gp.PrimitiveTree, fitness=creator.FitnessMax)

toolbox = base.Toolbox()

# Attribute generator
toolbox.register("expr_init", gp.genGrow, pset=pset, min_=1, max_=2)

# Structure initializers
toolbox.register("individual", tools.initIterate, creator.Individual, toolbox.expr_init)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

def evalArtificialAnt(individual):
    # Transform the tree expression to functionnal Python code
    routine = gp.compile(individual, pset)
    ant.run(routine)
    return ant.eaten,

toolbox.register("evaluate", evalArtificialAnt)
toolbox.register("select", tools.selTournament, tournsize=7)
toolbox.register("mate", gp.cxOnePoint)
toolbox.register("expr_mut", gp.genFull, min_=0, max_=2)
toolbox.register("mutate", gp.mutUniform, expr=toolbox.expr_mut, pset=pset)

def main(fen=None, population=500, generation=15, dl=False):
    random.seed(69)
    ant.set_fen(fen)
    if dl:
        ant.set_dl()
    pop = toolbox.population(n=population)
    hof = tools.HallOfFame(100)
    stats = tools.Statistics(lambda ind: ind.fitness.values)
    stats.register("avg", numpy.mean)
    stats.register("std", numpy.std)
    stats.register("min", numpy.min)
    stats.register("max", numpy.max)

    with numpy.errstate(invalid='ignore'):
        algorithms.eaSimple(pop, toolbox, 0.5, 0.2, generation, stats, halloffame=hof)

    move = ant.get_prediction
    print('\nBest choice:\n', move)

    best_ind = tools.selBest(pop, 1)[0]
    print("\nBest individual is %s, %s" % (best_ind, best_ind.fitness.values))

    # return pop, hof, stats
    return pop, hof, stats, move

def run(fen=None, population=500, generation=15, dl=False):
    if not fen:
        board = chess.Board()
    else:
        board = chess.Board(fen)
    n = 0
    print(board)
    print("\n")
    while n < 100:
        if n%2 == 0:
            move = input("Enter move: ")
            move = chess.Move.from_uci(str(move))
            board.push(move)
        else:
            print("Computers Turn:")
            pop, hof, stats, move = main(board.fen(), population, generation, dl)
            board.push(move)
        print("\n")
        print(board)
        n += 1

def selfPlay(fen=None, population=500, generation=15, dl=False, path="train-pgn", loop=1, create_pgn=False):
    if create_pgn:
        os.makedirs(path, exist_ok=True)
    for i in range(loop):
        if not fen:
            board = chess.Board()
        else:
            board = chess.Board(fen)
        if create_pgn:
            game = chess.pgn.Game()
            game.headers["Event"]
            game.setup(board)
            node = game
        print("\n")
        print(board)
        print("\n")
        while not board.is_game_over():
            pop, hof, stats, move = main(board.fen(), population, generation, dl)
            board.push(move)
            print("\n")
            print(board)
            print("\n")
            if create_pgn:
                node = node.add_variation(move)
        if create_pgn:
            game.headers["Result"] = board.result()
            print(game)
            with open(os.path.join(path, f"train-{i}.pgn"), mode='w') as f:
                exporter = chess.pgn.FileExporter(f)
                game.accept(exporter)
        print("Result is: ", board.result())

def console_script():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-f", "--fen", dest='fen', default=None, type=str, help="Initial FEN.")
    parser.add_argument("-n", "--population", dest='population', default=500, type=int, help="Population size.  Default is 500.")
    parser.add_argument("-g", "--generation", dest='generation', default=15, type=int, help="The number of generation.  Default is 15")
    parser.add_argument("-y", "--play", dest='play', action='store_true', help="Play chess on console.")
    parser.add_argument("-a", "--auto", dest='auto', action='store_true', help="Self-play chess.")
    parser.add_argument("-d", "--deep-learning", dest='dl', action='store_true', help="With deep learning.")
    parser.add_argument("-p", "--path", dest='path', default="train-pgn", type=str, help="Directory to save PGN files when create_pgn option is True.  Default is train-pgn.")
    parser.add_argument("-l", "--loop", dest='loop', default=1, type=int, help="How many PGN files you want when create_pgn option is True.  Default is 1")
    parser.add_argument("-c", "--create_pgn", dest='create_pgn', action='store_true', help="Create PGN files when self-play chess.")
    args = parser.parse_args()

    if args.play is True:
        run(args.fen, population=args.population, generation=args.generation, dl=args.dl)
    elif args.auto is True:
        selfPlay(args.fen, population=args.population, generation=args.generation, dl=args.dl, path=args.path, loop=args.loop, create_pgn=args.create_pgn)
    else:
        main(args.fen, population=args.population, generation=args.generation, dl=args.dl)

if __name__ == "__main__":
    console_script()
