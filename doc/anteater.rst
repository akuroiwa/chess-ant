======================
Chess-Ant Introduction
======================

Simulator to solve chess problems with MCTS Solver and Genetic
Programming.

:file:`chess_ant.py` is based on the code of
`deap/examples/gp/ant.py <https://github.com/DEAP/deap/blob/master/examples/gp/ant.py>`__.

Requirements
============

On Ubuntu:

.. code-block:: bash

   sudo -H -s
   apt install python3-pip
   pip3 install -r requirements.txt
   exit

Or:

.. code-block:: bash

   pip3 install chess
   pip3 install deap
   pip3 install mcts
   pip3 install mcts-solver

Or:

.. code-block:: bash

   pip3 install chess-ant

-  `python-chess: a chess library for
   Python <https://github.com/niklasf/python-chess>`__
-  `DEAP <https://github.com/DEAP/deap>`__
-  `MCTS <https://github.com/pbsinclair42/MCTS>`__
-  `chess-ant <https://github.com/akuroiwa/chess-ant>`__
-  `chess-classification <https://github.com/akuroiwa/chess-classification>`__
-  `mcts-solver <https://github.com/akuroiwa/mcts-solver>`__


General Usage
=============

Sample chess problems are available in :file:`pgn/`.
`Jerry <https://github.com/asdfjkl/jerry>`__ is useful for pasting
Forsyth-Edwards Notation (FEN).

.. code-block:: bash

   cd chess-ant/chess-ant/
   git checkout -b test-run
   python3 chess_ant.py --help
   python3 chess_ant.py --auto --fen "7k/1Q6/8/8/5N2/1B6/8/3K4 w - - 0 1"
   python3 chess_ant.py -a -c -p "my-pgn" -l1 -n100 -g10 -f "7k/1Q6/8/8/5N2/1B6/8/3K4 w - - 0 1"

If you installed :mod:`chess-ant` from PyPI:

.. code-block:: bash

   chess-ant --help
   chess-ant -a -n100 -g5 -f "7r/8/8/8/7k/2q5/6P1/6NK b - - 0 1"

This command will output the wrong answer.
It will take some time, but the following command will output correctly.

.. code-block:: bash

   chess-ant -a -n1000 -g5 -f "7r/8/8/8/7k/2q5/6P1/6NK b - - 0 1"

Chess-Classification
====================

Version 0.0.1 of :file:`genPgn.py` contains the Walrus operator, so it only works with Python 3.8 or higher.
Please install Pytorch before installing Simple Transformers.

.. code-block:: bash

   sudo -H -s
   pip3 install pandas
   pip3 install simpletransformers
   apt install stockfish
   pip3 install chess-classification
   exit
   genPgn --help
   genPgn -l 10 -t 1 -p "train-pgn" -f "3qkbnr/8/8/8/8/8/PPPPPPPP/RNBQKBNR w - - 0 1"
   cat train-pgn/train-*.pgn >> train-pgn/1.pgn
   rm train-pgn/train-*.pgn
   genPgn -l 10 -t 1 -p "train-pgn" -f "rnbqkbnr/pppppppp/8/8/8/8/8/3QKBNR w - - 0 1"
   cat train-pgn/train-*.pgn >> train-pgn/2.pgn
   rm train-pgn/train-*.pgn
   genPgn -l 10 -t 1 -p "train-pgn" -f "4k3/pppppppp/8/8/8/8/PPPPPPPP/4K3 w - - 0 1"
   cat train-pgn/train-*.pgn >> train-pgn/3.pgn
   rm train-pgn/train-*.pgn
   importPgn -p "train-pgn"
   genPgn -l 10 -t 1 -p "eval-pgn" -f "3qkbnr/8/8/8/8/8/PPPPPPPP/RNBQKBNR w - - 0 1"
   cat eval-pgn/train-*.pgn >> eval-pgn/1.pgn
   rm eval-pgn/train-*.pgn
   genPgn -l 10 -t 1 -p "eval-pgn" -f "rnbqkbnr/pppppppp/8/8/8/8/8/3QKBNR w - - 0 1"
   cat eval-pgn/train-*.pgn >> eval-pgn/2.pgn
   rm eval-pgn/train-*.pgn
   genPgn -l 10 -t 1 -p "eval-pgn" -f "4k3/pppppppp/8/8/8/8/PPPPPPPP/4K3 w - - 0 1"
   cat eval-pgn/train-*.pgn >> eval-pgn/3.pgn
   rm eval-pgn/train-*.pgn
   importPgn -p "eval-pgn"

.. code-block:: python

   from chess_classification.chess_classification import ChessClassification
   classification = ChessClassification()

Loading a local save:

.. code-block:: python

   classification = ChessClassification("local-path/your-outputs")

Train or retrain:

.. code-block:: python

   classification.train_and_eval("train-pgn/fen.json", "eval-pgn/fen.json")

Test:

.. code-block:: python

   my_fen = "7r/8/8/8/7k/2q5/6P1/6NK b - - 0 1"
   classification.predict_fen(my_fen)


+------------+-------+
|predictions |labels |
+------------+-------+
|1-0         |2      |
+------------+-------+
|0-1         |1      |
+------------+-------+
|1/2-1/2     |0      |
+------------+-------+

With :file:`chess_ant.py`:

.. code-block:: bash

   chess-ant -d -n100 -g5 -f "6rk/4pppp/8/8/3Q4/8/RB2PPPP/R6K w - - 0 1"

Loading a local save:

.. code-block:: bash

   chess-ant -d -n100 -g5 -f "6rk/4pppp/8/8/3Q4/8/RB2PPPP/R6K w - - 0 1" --model-outputs "local-path/your-outputs"

- `Simple Transformers <https://github.com/ThilinaRajapakse/simpletransformers>`__
- `Start Locally | PyTorch <https://pytorch.org/get-started/locally/>`__
- `pandas <https://pandas.pydata.org/>`__
- `Chess-Classification <https://github.com/akuroiwa/chess-classification>`__

.. todo::

   -  It’s too slow.
   -  Low correct answer rate.
   -  Parallelization.
   -  Support for other board games like shogi.
   -  Support for Universal Chess Interface (UCI).
   -  Docstring.
   -  Boil spaghetti code.
