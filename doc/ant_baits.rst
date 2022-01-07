:author: Akihiro Kuroiwa
:date: 2021/12/25
:abstract: Like AlphaFold developed by DeepMind, MCTS can be applied to bioinformatics and cheminformatics.
	   Chess-Ant is influenced by AlphaZero, but tries a different method.
	   I would like to show the possibility that the combination of MCTS Solver and Genetic Programming can be put to practical use.


Chess-Ant Article
=================

Influence from AlphaZero
------------------------

A variant of the Polynomial Upper Confidence Tree (PUCT) introduced in AlphaGo Zero and AlphaZero complements the exploration rate :math:`C(s)` with the prior probability :math:`P(s,a)`.  My chess-ant uses the conventional Upper Confidence Tree (UCT)
and replaces the adjustment of the constant :math:`C` with Genetic Programming
(GP) [#]_. From :math:`1/\sqrt{1}` to :math:`1/\sqrt{9}`, GP chooses the value of the constant :math:`C` according to the conditions.
Depending on the value of the constant :math:`C`,
:file:`chess_ant.py` will either actively or passively search.

AlphaZero's PUCT [#]_ [#]_ [#]_ [#]_:

.. math::

   a_{t} = arg\, max_{a}(Q(s_{t}, a) + U(s_{t}, a))

   U(s,a)=C(s)P(s,a)\frac{\sqrt{N(s)}}{{1+N(s,a)}}

   C(s)=log\frac{1+N(s)+c_{base}}{c_{base}}+c_{init}

A deep neural network :math:`(p, v) = f_{\theta}(s)` with parameters :math:`\theta` evaluates the leaf node :math:`s_{L}` :

.. math::

   (p, v) = f_{\theta}(s_{L})


Initialize:

.. math::

   N(s_{L} , a) = 0

   W(s_{L} , a) = 0

   Q(s_{L} , a) = 0

   P(s_{L} , a) = p_{a}

Update:

.. math::

   t \leq L

   N(s_{t} , a_{t}) = N(s_{t} , a_{t}) + 1

   W (s_{t} , a_{t}) = W(s_{t} , a_{t}) + v

   Q(s_{t} , a_{t}) = \frac{W(s_{t} , a_{t})}{N(s_{t} , a_{t})}

+-----------------+---------------------------------------------------------------------+
|                 |Details                                                              |
+=================+=====================================================================+
|(s,a)            |Each state-action pair.                                              |
+-----------------+---------------------------------------------------------------------+
|N(s)             |The parent visit count.                                              |
+-----------------+---------------------------------------------------------------------+
|N(s,a)           |The visit count.                                                     |
+-----------------+---------------------------------------------------------------------+
|W(s,a)           |The total action-value.                                              |
+-----------------+---------------------------------------------------------------------+
|Q(s,a)           |The mean action-value.                                               |
+-----------------+---------------------------------------------------------------------+
|P(s,a)           |The prior probability of selecting a in s.                           |
+-----------------+---------------------------------------------------------------------+
|C(s)             |The exploration rate.                                                |
+-----------------+---------------------------------------------------------------------+
|p                |A vector of Move probabilities (predicted by a deep neural network). |
+-----------------+---------------------------------------------------------------------+
|v                |A scalar value (predicted by a deep neural network).                 |
+-----------------+---------------------------------------------------------------------+

Chess-Ant's UCT [#]_ [#]_ [#]_ [#]_ [#]_:

.. math::

   a_{t} = arg\, max_{a}(Q(s_{t}, a) + C_{gp}\sqrt\frac{lnN(s_{t})}{N(s_{t},a)})

   C_{gp} = \begin{cases}
   1/\sqrt{1}, \\
   1/\sqrt{2}, \\
   1/\sqrt{3}, \\
   1/\sqrt{4}, \\
   1/\sqrt{5}, & \mbox{If the previously selected node state is under certain conditions} \\
   1/\sqrt{6}, \\
   1/\sqrt{7}, \\
   1/\sqrt{8}, \\
   1/\sqrt{9},
   \end{cases}

The judgment conditions are as follows:

+---------------+----------------------------------------------------------+
|Conditions     |Details                                                   |
+===============+==========================================================+
|if_improvement |If UCT increases from the previous time                   |
+---------------+----------------------------------------------------------+
|if_shortcut    |If move_stack is shorter than last time                   |
+---------------+----------------------------------------------------------+
|if_result      |Whether the last time rollout was a win, a loss or a draw |
+---------------+----------------------------------------------------------+
|if_pruning     |Whether UCT was infinity, -infinity or something else     |
+---------------+----------------------------------------------------------+
|if_is_check    |Is the board of the node selected last time checked?      |
+---------------+----------------------------------------------------------+

Also, since GP can be redone in each generation, it is possible to
prevent the UCT from being highly evaluated at the beginning of the
search based on the number of visits. It may get the effect of this
paper [#]_.


MCTS Solver
-----------

With the introduction of MCTS Solver [#]_  [#]_, chess-ant will cut branches to speed up
and reduce wrong answers.

The reason for the significant changes to the pseudocode in the paper is
that the code for `the package <https://github.com/pbsinclair42/MCTS>`__ referenced by the inherited classes is
written differently.

In addition, there is no ``goto`` in Python, so there is extra code. In the
pseudo code, everything is completed inside the MCTS Solver, but in
:file:`chess_ant.py`, it is written separately in ``_executeRound()``. Execute
rollout in ``mctsSolver()``, perform processing such as pruning, output
reward like rollout, and input it to ``backpropogate()``.

Like negamax, the MCTS solver is a recursive function and requires a stop condition.


Development Plan
----------------

.. todo::

   As another project, I will introduce deep learning [#]_  [#]_ for Natural Language Processing (NLP) in FEN’s win
   / loss evaluation.

   :file:`genPgn.py` automatically plays with stockfish and outputs PGN files. By
   the way, :file:`genPgn.py` contains the Walrus operator, so it only works with
   Python 3.8 or higher. :file:`importPgn.py` creates a dataset from PGN files.
   :file:`chess_classification.py` generates a trained model with simple
   transformers. I plan to use this trained model to replace the rollout of
   :file:`chess_ant.py`, like AlphaZero.

Reference
---------

.. [#] `Cazenave, Tristan. “Evolving Monte-Carlo Tree Search Algorithms.” (2007).
       <https://www.semanticscholar.org/paper/Evolving-Monte-Carlo-Tree-Search-Algorithms-Cazenave/336231ec5085098b35c573d885e18c3392e3703d>`__

.. [#] `AlphaZero: Shedding new light on chess, shogi, and Go
       <https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go>`__

.. [#] `Silver, David et al. “A general reinforcement learning algorithm that masters chess, shogi, and Go through self-play.” Science 362 (2018): 1140 - 1144.
       <https://www.semanticscholar.org/paper/A-general-reinforcement-learning-algorithm-that-and-Silver-Hubert/f9717d29840f4d8f1cc19d1b1e80c5d12ec40608>`__

.. [#] `Foster, David. (2017). AlphaGo Zero Explained In One
   Diagram <https://medium.com/applied-data-science/alphago-zero-explained-in-one-diagram-365f5abf67e0>`__

.. [#] `Tadao Yamaoka’s
   diary <https://tadaoyamaoka.hatenablog.com/entry/2018/12/08/191619>`__

.. [#] `Auer, Peter et al. “Finite-time Analysis of the Multiarmed Bandit Problem.” Machine Learning 47 (2004): 235-256.
       <https://www.semanticscholar.org/paper/Finite-time-Analysis-of-the-Multiarmed-Bandit-Auer-Cesa-Bianchi/1e1d35136b1bf3b13ef6b53f6039f39d9ee820e3>`__

.. [#] `Kocsis, Levente and Csaba Szepesvari. “Bandit Based Monte-Carlo Planning.” ECML (2006).
       <https://www.semanticscholar.org/paper/Bandit-Based-Monte-Carlo-Planning-Kocsis-Szepesvari/e635d81a617d1239232a9c9a11a196c53dab8240>`__

.. [#] `Swiechowski, Maciej et al. “Monte Carlo Tree Search: A Review of Recent Modifications and Applications.” ArXiv abs/2103.04931 (2021): n. pag.
       <https://www.semanticscholar.org/paper/Monte-Carlo-Tree-Search%3A-A-Review-of-Recent-and-Swiechowski-Godlewski/ad5fc69f2b092eab4171d1e87c59ef7992dfdc6e>`__

.. [#] `Wikipedia contributors. "Monte Carlo tree search." Wikipedia, The Free Encyclopedia. Wikipedia, The Free Encyclopedia, 18 Oct. 2021. Web. 25 Dec. 2021.
       <https://en.wikipedia.org/w/index.php?title=Monte_Carlo_tree_search&oldid=1050627850>`__

.. [#] `Wikipedia contributors. "モンテカルロ木探索." Wikipedia. Wikipedia, 8 Oct. 2021. Web. 25 Dec. 2021.
       <https://ja.wikipedia.org/w/index.php?title=%E3%83%A2%E3%83%B3%E3%83%86%E3%82%AB%E3%83%AB%E3%83%AD%E6%9C%A8%E6%8E%A2%E7%B4%A2&oldid=85943688>`__

.. [#] `Imagawa, Takahisa and Tomoyuki Kaneko. “Improvement of State’s Value Estimation for Monte Carlo Tree Search.” (2017).
       <https://www.semanticscholar.org/paper/Improvement-of-State%E2%80%99s-Value-Estimation-for-Monte-Imagawa-Kaneko/1b45c6e02944e2f4ec2dbc77083e8cc4eb7c9e8a>`__

.. [#] `Winands, Mark & Björnsson, Yngvi & Saito, Jahn-Takeshi. (2008). Monte-Carlo Tree Search Solver. 25-36. 10.1007/978-3-540-87608-3_3.
       <https://www.researchgate.net/publication/220962507_Monte-Carlo_Tree_Search_Solver>`__

.. [#] `Baier, Hendrik & Winands, Mark. (2015). MCTS-Minimax Hybrids. IEEE Transactions on Computational Intelligence and AI in Games. 7. 167-179. 10.1109/TCIAIG.2014.2366555.
   <https://dke.maastrichtuniversity.nl/m.winands/documents/mcts-minimax_hybrids_final.pdf>`__

.. [#] `Savransky, Dmitriy. (2020). How to Use GPT-2 for Custom Data Generation. INTERSOG Inc. <https://intersog.com/blog/the-gpt-2-usage-for-custom-data-generation-by-example-playing-chess/>`__

.. [#] `Noever, David et al. “The Chess Transformer: Mastering Play using Generative Language Models.” arXiv: Artificial Intelligence (2020): n. pag.
       <https://arxiv.org/pdf/2008.04057.pdf>`__


Bibliography
------------

-  `Home Page of John R.
   Koza <http://www.genetic-programming.com/johnkoza.html>`__
-  `Astro Teller \| Technical
   Papers <http://www.astroteller.net/work/papers>`__
-  `Lones, Michael. (2014). Genetic Programming: Memory, Loops and
   Modules. David Corne: Open Courseware. <https://www.macs.hw.ac.uk/~dwcorne/Teaching/bic1415_gp2.pdf>`__
-  `Alpha“Othello”
   Zero <https://github.com/tkhkaeio/AlphaZero>`__
-  `Czech, Johannes et al. “Monte-Carlo Graph Search for AlphaZero.” ArXiv abs/2012.11045 (2020): n. pag.
   <https://arxiv.org/abs/2012.11045>`__
-  `Prasad, Aditya. (2018). Lessons From Implementing
   AlphaZero <https://medium.com/oracledevs/lessons-from-implementing-alphazero-7e36e9054191>`__
-  `chess-alpha-zero <https://github.com/Zeta36/chess-alpha-zero>`__
-  `Yao, Yao. (2018). API Python Chess: Distribution of Chess Wins based on random
   moves <https://www.slideshare.net/YaoYao44/api-python-chess-distribution-of-chess-wins-based-on-random-moves>`__
-  `Stöckl, Andreas. (2018). Writing a chess program in one
   day <https://medium.com/@andreasstckl/writing-a-chess-program-in-one-day-30daff4610ec>`__
-  `Stöckl, Andreas. (2019). An incremental evaluation function and a test-suite for computer
   chess <https://medium.com/datadriveninvestor/an-incremental-evaluation-function-and-a-testsuite-for-computer-chess-6fde22aac137>`__
-  `Stöckl, Andreas. (2019). Reconstructing chess
   positions <https://medium.com/datadriveninvestor/reconstructing-chess-positions-f195fd5944e>`__
-  `Python Chess <https://www.chessprogramming.net/python-chess/>`__
-  `Fiekas, Niklas. (2015). An implementation of the Bratko-Kopec Test using
   python-chess <https://gist.github.com/niklasf/73c9565719d124af64ff>`__
-  `Bratko-Kopec
   Test <https://www.chessprogramming.org/Bratko-Kopec_Test>`__
-  `Kurt & Rolf Chess Homepage of Kurt
   Utzinger <http://www.utzingerk.com/test.htm>`__
-  `PGN Mentor <https://www.pgnmentor.com/>`__
-  `Hart, Alex. (2011). Alpha Beta pruning on a Minimax tree in
   Python <https://gist.github.com/exallium/1446104/5109388cfc21578f555dcac0ba54da680326af7b>`__
-  `PythonChessAi <https://github.com/AnthonyASanchez/python-chess-ai>`__
-  `easyAI <https://github.com/Zulko/easyAI>`__
-  `Shrott, Ryan. (2017). Genetic Programming applied to AI Heuristic
   Optimization <https://towardsdatascience.com/genetic-programming-for-ai-heuristic-optimization-9d7fdb115ee1>`__
-  `Alpha-Beta
   Pruning <https://www.javatpoint.com/ai-alpha-beta-pruning>`__
-  `Hartikka, Lauri. (2017). A step-by-step guide to building a simple chess
   AI <https://www.freecodecamp.org/news/simple-chess-ai-step-by-step-1d55a9266977/>`__
-  `Simplified Evaluation
   Function <https://www.chessprogramming.org/Simplified_Evaluation_Function>`__
-  `Brynjulfsson, Erlingur. A Genetic Minimax Game-Playing
   Strategy <https://notendur.hi.is/benedikt/Courses/Erlingur.pdf>`__
-  `Öberg, Viktor. “EVOLUTIONARY AI IN BOARD GAMES : An evaluation of the performance of an evolutionary algorithm in two perfect information board games with low branching factor.” (2015).
   <http://www.diva-portal.org/smash/get/diva2:823737/FULLTEXT01.pdf>`__
-  `Agapitos, Alexandros & Lucas, Simon. (2006). Learning Recursive Functions with Object Oriented Genetic Programming. 3905. 166-177. 10.1007/11729976_15.
   <https://www.researchgate.net/publication/221009242_Learning_Recursive_Functions_with_Object_Oriented_Genetic_Programming>`__
-  `Yu, Tina and Christopher D. Clack. “Recursion , Lambda Abstractions and Genetic Programming.” .
   <https://pdfs.semanticscholar.org/b0bc/b2e8c96c750c8cae70ad20c675023f314191.pdf>`__
-  `YouTube channel of David
   Beazley <https://www.youtube.com/channel/UCbNpPBMvCHr-TeJkkezog7Q>`__

