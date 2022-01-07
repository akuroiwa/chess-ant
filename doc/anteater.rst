Chess-Ant Introduction
======================

Simulator to solve chess problems with MCTS Solver and Genetic
Programming.

:file:`chess-ant.py` is based on the code of
`deap/examples/gp/ant.py <https://github.com/DEAP/deap/blob/master/examples/gp/ant.py>`__.

Requirements
------------

On Ubuntu:

.. code:: bash

   sudo -H -s
   apt install python3-pip
   pip3 install -r requirements.txt
   exit

Or:

.. code:: bash

   pip3 install chess
   pip3 install deap
   pip3 install mcts

-  `python-chess: a chess library for
   Python <https://github.com/niklasf/python-chess>`__
-  `DEAP <https://github.com/DEAP/deap>`__
-  `MCTS <https://github.com/pbsinclair42/MCTS>`__

General Usage
-------------

Sample chess problems are available in :file:`pgn/`.
`Jerry <https://github.com/asdfjkl/jerry>`__ is useful for pasting
Forsyth-Edwards Notation (FEN).

.. code:: bash

   cd chess-ant/chess-ant/
   git checkout -b test-run
   python3 chess_ant.py --help
   python3 chess_ant.py --auto --fen "7k/1Q6/8/8/5N2/1B6/8/3K4 w - - 0 1"


Chess-Classification
--------------------

:file:`genPgn.py` contains the Walrus operator, so it only works with Python 3.8 or higher.

.. code:: bash

   sudo -H -s
   pip3 install pandas
   pip3 install simpletransformers
   apt install stockfish
   exit
   python3 genPgn.py --help
   python3 genPgn.py -p train-pgn -l 30 -t 20
   python3 genPgn.py -p eval-pgn -l 30 -t 20

.. code:: python

   from chess_classification import ChessClassification
   classification = ChessClassification()

Train or retrain:

.. code:: python

   classification.train_and_eval("train-pgn/fen.json", "eval-pgn/fen.json")

Test:

.. code:: python

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

With :file:`chess-ant.py`:

.. code:: bash

   python3 chess_ant.py -d -n100 -g5 -f "6rk/4pppp/8/8/3Q4/8/RB2PPPP/R6K w - - 0 1"

- `Simple Transformers <https://github.com/ThilinaRajapakse/simpletransformers>`__
- `pandas <https://pandas.pydata.org/>`__


.. todo::

   -  It’s too slow.
   -  Low correct answer rate.
   -  Parallelization.
   -  Support for other board games like shogi.
   -  Cooperation with deep learning.
   -  Support for Universal Chess Interface (UCI).
   -  Application to cheminformatics.
   -  Boil spaghetti code.
