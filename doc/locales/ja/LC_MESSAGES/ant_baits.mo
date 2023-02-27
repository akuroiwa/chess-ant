��    v      �              |     }     �  �  �  {   O	  4   �	  @   
  D   A  �   �  %   	  �   /  1     �   8     �     �     �     �  )   �  
     �  &     �     �     �  '   �  '     0   /  �   `  @   �  `  6  �   �     6     O  4   [  "  �  T   �       �               J        c  k   j     �  	   �  �   �     n  '   �     �     �  *   �  �        �     �  ?   �     =     B     J  5   Q  9   �  r   �    4  I   K  �   �  C   /  M   s  	  �    �  J   �  z      �   �   �   n!  d   �!  �   d"  �   �"  �   �#  9    $  �   Z$  �   �$  P   �%    �%  �   �&  S   �'  �   8(  �   �(  +   �)  �   �)  A   Z*  F   �*  �   �*  �   �+  �   c,  2  -  d   I.  �   �.  �   B/  �   "0  .  �0  Y   �1  �   ;2  �   -3  �   ,4  �   	5  _   �5  �   *6  A   �6  ,   %7    R7  A  X8  �   �9  &   /:     V:     e:  
   q:  	   |:     �:     �:  �   �:     .;  �  0;     �<     �<    �<  �   �>  @   k?  +  �?  R   �A  �   +B  %   �B  �   �B  D   �C  �    D     �D     �D     �D     �D  )   �D     �D  �  �D     �F     �F  $   �F  $   �F  .   G  :   5G  �   pG  ^   5H  �  �H  �   J     �J     �J  *   �J  R  �J  T   AL     �L  B  �L     �M     �M  J   �M     <N  �   CN     �N     �N  �   �N  )   xO  '   �O     �O     �O  &   �O  �   &P     �P  	   	Q  B   Q     VQ  	   [Q     eQ  6   lQ  4   �Q  e   �Q    >R  I   US  �   �S  C   9T  M   }T  	  �T    �U  J   �V  z   %W  �   �W  �   xX  d   	Y  �   nY  �   �Y  �   �Z  9   *[  �   d[  �   �[  P   �\    �\  �   	^  S   �^  �   B_  �   �_  +   �`  �   �`  A   da  F   �a  �   �a  �   �b  �   mc  2   d  d   Se  �   �e  �   Lf  �   ,g  .  �g  Y   �h  �   Ei  �   7j  �   6k  �   l  _   �l  �   4m  A   �m  ,   /n    \n  A  bo  �   �p  /   9q     iq     xq  
   �q  	   �q     �q     �q  �   �q     Ar   (p, v) = f_{\theta}(s_{L}) (s,a) :file:`genPgn.py` automatically plays with stockfish and outputs PGN files. By the way, version 0.0.1 of :file:`genPgn.py` contains the walrus operator, so it only works with Python 3.8 or higher. :file:`importPgn.py` creates a dataset from PGN files. :file:`chess_classification.py` generates a trained model with simple transformers. I plan to use this trained model to replace the rollout of :file:`chess_ant.py`, like AlphaZero. A deep neural network :math:`(p, v) = f_{\theta}(s)` with parameters :math:`\theta` evaluates the leaf node :math:`s_{L}` : A scalar value (predicted by a deep neural network). A variant of the Polynomial Upper Confidence Tree (PUCT) introduced in AlphaGo Zero and AlphaZero complements the exploration rate :math:`C(s)` with the prior probability :math:`P(s,a)`.  My chess-ant uses the conventional Upper Confidence Tree (UCT) and replaces the adjustment of the constant :math:`C` with Genetic Programming (GP) [#]_. From :math:`1/\sqrt{1}` to :math:`1/\sqrt{9}`, GP chooses the value of the constant :math:`C` according to the conditions. Depending on the value of the constant :math:`C`, :file:`chess_ant.py` will either actively or passively search. A vector of Move probabilities (predicted by a deep neural network). According to `Issues #658 <https://github.com/DEAP/deap/issues/658>`_, Deap does not work with Python 3.10, but with version 3.11. AlphaZero's PUCT [#]_ [#]_ [#]_ [#]_: Also, since GP can be redone in each generation, it is possible to prevent the UCT from being highly evaluated at the beginning of the search based on the number of visits. It may get the effect of this paper [#]_. Another method is :command:`update-alternatives`. As another project, I will introduce deep learning [#]_  [#]_ for Natural Language Processing (NLP) in FEN’s win / loss evaluation. Bibliography C(s) Change History Chess-Ant Article Chess-Ant's UCT [#]_ [#]_ [#]_ [#]_ [#]_: Conditions Corrected by adding ``math.sqrt(2)`` since there was an error in the UCB1 algorithm until :mod:`chess-ant` 0.0.5 manual. It seems that the author of :mod:`mcts` initially set ``explorationConstant = 1 / math.sqrt(2)`` in :file:`mcts.py` to cancel out ``math.sqrt(2)``. I added a new terminal called ``selectNodeEphemeralConstant`` to replace the ephemeral constant in :mod:`chess-ant` 0.0.6. Details Development Plan Each state-action pair. If UCT increases from the previous time If move_stack is shorter than last time In :file:`~/.bashrc` or :file:`~/.bash_aliases`: In :mod:`chess-classification` 0.0.4, fen is separated into tokens to create a dataset. The fen is separated by columns instead of letter by letter. In :mod:`chess-classification` 0.0.5, you can load a local save. In addition, there is no ``goto`` in Python, so there is extra code. In the pseudo code, everything is completed inside the MCTS Solver, but in :file:`chess_ant.py`, it is written separately in ``_executeRound()``. Execute rollout in ``mctsSolver()``, perform processing such as pruning, output reward like rollout, and input it to ``backpropogate()``. In order to shorten the training time, [#]_ the conventional model was changed to the checkpoint google/electra-small-discriminator [#]_ of the electra model. Influence from AlphaZero Initialize: Is the board of the node selected last time checked? Like AlphaFold developed by DeepMind, MCTS can be applied to bioinformatics and cheminformatics. Chess-Ant is influenced by AlphaZero, but tries a different method. I would like to show the possibility that the combination of MCTS Solver and Genetic Programming can be put to practical use. Like negamax, the MCTS solver is a recursive function and requires a stop condition. MCTS Solver My pgn files are more like tactics [#]_  [#]_ than chess problems, so it's more efficient to create a dataset from tactics. More than 300 rows of pgn data are required for model training and model evaluation in order to increase the accuracy rate. N(s) N(s,a) N(s_{L} , a) = 0

W(s_{L} , a) = 0

Q(s_{L} , a) = 0

P(s_{L} , a) = p_{a} P(s,a) Please note that as of December 2022, gnome-terminal does not start with Python 3.11 on Ubuntu 22.04.1 LTS. Q(s,a) Reference Since both :mod:`chess-classification` and :mod:`chem-classification` use the same algorithm, I made similar changes at the same time. The exploration rate. The judgment conditions are as follows: The mean action-value. The parent visit count. The prior probability of selecting a in s. The reason for the significant changes to the pseudocode in the paper is that the code for `the package <https://github.com/pbsinclair42/MCTS>`__ referenced by the inherited classes is written differently. The total action-value. The visit count. To revert to the original version that was set as top priority: Todo Update: W(s,a) Whether UCT was infinity, -infinity or something else Whether the last time rollout was a win, a loss or a draw With the introduction of MCTS Solver [#]_  [#]_, chess-ant will cut branches to speed up and reduce wrong answers. `Agapitos, Alexandros & Lucas, Simon. (2006). Learning Recursive Functions with Object Oriented Genetic Programming. 3905. 166-177. 10.1007/11729976_15. <https://www.researchgate.net/publication/221009242_Learning_Recursive_Functions_with_Object_Oriented_Genetic_Programming>`__ `Alpha-Beta Pruning <https://www.javatpoint.com/ai-alpha-beta-pruning>`__ `AlphaZero: Shedding new light on chess, shogi, and Go <https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go>`__ `Alpha“Othello” Zero <https://github.com/tkhkaeio/AlphaZero>`__ `Astro Teller \| Technical Papers <http://www.astroteller.net/work/papers>`__ `Auer, Peter et al. “Finite-time Analysis of the Multiarmed Bandit Problem.” Machine Learning 47 (2004): 235-256. <https://www.semanticscholar.org/paper/Finite-time-Analysis-of-the-Multiarmed-Bandit-Auer-Cesa-Bianchi/1e1d35136b1bf3b13ef6b53f6039f39d9ee820e3>`__ `Baier, Hendrik & Winands, Mark. (2015). MCTS-Minimax Hybrids. IEEE Transactions on Computational Intelligence and AI in Games. 7. 167-179. 10.1109/TCIAIG.2014.2366555. <https://dke.maastrichtuniversity.nl/m.winands/documents/mcts-minimax_hybrids_final.pdf>`__ `Bratko-Kopec Test <https://www.chessprogramming.org/Bratko-Kopec_Test>`__ `Brynjulfsson, Erlingur. A Genetic Minimax Game-Playing Strategy <https://notendur.hi.is/benedikt/Courses/Erlingur.pdf>`__ `Cazenave, Tristan. “Evolving Monte-Carlo Tree Search Algorithms.” (2007). <https://www.semanticscholar.org/paper/Evolving-Monte-Carlo-Tree-Search-Algorithms-Cazenave/336231ec5085098b35c573d885e18c3392e3703d>`__ `Czech, Johannes et al. “Monte-Carlo Graph Search for AlphaZero.” ArXiv abs/2012.11045 (2020): n. pag. <https://arxiv.org/abs/2012.11045>`__ `Download tactics database <https://lichess.org/forum/lichess-feedback/download-tactics-database>`__ `ELECTRA: Pre-training Text Encoders as Discriminators Rather Than Generators <https://huggingface.co/google/electra-small-discriminator>`__ `Fiekas, Niklas. (2015). An implementation of the Bratko-Kopec Test using python-chess <https://gist.github.com/niklasf/73c9565719d124af64ff>`__ `Foster, David. (2017). AlphaGo Zero Explained In One Diagram <https://medium.com/applied-data-science/alphago-zero-explained-in-one-diagram-365f5abf67e0>`__ `Gorgonian's Chess Site <http://gorgonian.weebly.com/>`__ `Hart, Alex. (2011). Alpha Beta pruning on a Minimax tree in Python <https://gist.github.com/exallium/1446104/5109388cfc21578f555dcac0ba54da680326af7b>`__ `Hartikka, Lauri. (2017). A step-by-step guide to building a simple chess AI <https://www.freecodecamp.org/news/simple-chess-ai-step-by-step-1d55a9266977/>`__ `Home Page of John R. Koza <http://www.genetic-programming.com/johnkoza.html>`__ `Imagawa, Takahisa and Tomoyuki Kaneko. “Improvement of State’s Value Estimation for Monte Carlo Tree Search.” (2017). <https://www.semanticscholar.org/paper/Improvement-of-State%E2%80%99s-Value-Estimation-for-Monte-Imagawa-Kaneko/1b45c6e02944e2f4ec2dbc77083e8cc4eb7c9e8a>`__ `Kocsis, Levente and Csaba Szepesvari. “Bandit Based Monte-Carlo Planning.” ECML (2006). <https://www.semanticscholar.org/paper/Bandit-Based-Monte-Carlo-Planning-Kocsis-Szepesvari/e635d81a617d1239232a9c9a11a196c53dab8240>`__ `Kurt & Rolf Chess Homepage of Kurt Utzinger <http://www.utzingerk.com/test.htm>`__ `Lones, Michael. (2014). Genetic Programming: Memory, Loops and Modules. David Corne: Open Courseware. <https://www.macs.hw.ac.uk/~dwcorne/Teaching/bic1415_gp2.pdf>`__ `Noever, David et al. “The Chess Transformer: Mastering Play using Generative Language Models.” arXiv: Artificial Intelligence (2020): n. pag. <https://arxiv.org/pdf/2008.04057.pdf>`__ `PGN Mentor <https://www.pgnmentor.com/>`__ `Prasad, Aditya. (2018). Lessons From Implementing AlphaZero <https://medium.com/oracledevs/lessons-from-implementing-alphazero-7e36e9054191>`__ `Python Chess <https://www.chessprogramming.net/python-chess/>`__ `PythonChessAi <https://github.com/AnthonyASanchez/python-chess-ai>`__ `Rajapakse, Thilina. (2020). Battle of the Transformers: ELECTRA, BERT, RoBERTa, or XLNet <https://towardsdatascience.com/battle-of-the-transformers-electra-bert-roberta-or-xlnet-40607e97aba3>`__ `Savransky, Dmitriy. (2020). How to Use GPT-2 for Custom Data Generation. INTERSOG Inc. <https://intersog.com/blog/the-gpt-2-usage-for-custom-data-generation-by-example-playing-chess/>`__ `Shrott, Ryan. (2017). Genetic Programming applied to AI Heuristic Optimization <https://towardsdatascience.com/genetic-programming-for-ai-heuristic-optimization-9d7fdb115ee1>`__ `Silver, David et al. “A general reinforcement learning algorithm that masters chess, shogi, and Go through self-play.” Science 362 (2018): 1140 - 1144. <https://www.semanticscholar.org/paper/A-general-reinforcement-learning-algorithm-that-and-Silver-Hubert/f9717d29840f4d8f1cc19d1b1e80c5d12ec40608>`__ `Simplified Evaluation Function <https://www.chessprogramming.org/Simplified_Evaluation_Function>`__ `Stöckl, Andreas. (2018). Writing a chess program in one day <https://medium.com/@andreasstckl/writing-a-chess-program-in-one-day-30daff4610ec>`__ `Stöckl, Andreas. (2019). An incremental evaluation function and a test-suite for computer chess <https://medium.com/datadriveninvestor/an-incremental-evaluation-function-and-a-testsuite-for-computer-chess-6fde22aac137>`__ `Stöckl, Andreas. (2019). Reconstructing chess positions <https://medium.com/datadriveninvestor/reconstructing-chess-positions-f195fd5944e>`__ `Swiechowski, Maciej et al. “Monte Carlo Tree Search: A Review of Recent Modifications and Applications.” ArXiv abs/2103.04931 (2021): n. pag. <https://www.semanticscholar.org/paper/Monte-Carlo-Tree-Search%3A-A-Review-of-Recent-and-Swiechowski-Godlewski/ad5fc69f2b092eab4171d1e87c59ef7992dfdc6e>`__ `Tadao Yamaoka’s diary <https://tadaoyamaoka.hatenablog.com/entry/2018/12/08/191619>`__ `Wikipedia contributors. "Monte Carlo tree search." Wikipedia, The Free Encyclopedia. Wikipedia, The Free Encyclopedia, 18 Oct. 2021. Web. 25 Dec. 2021. <https://en.wikipedia.org/w/index.php?title=Monte_Carlo_tree_search&oldid=1050627850>`__ `Wikipedia contributors. "モンテカルロ木探索." Wikipedia. Wikipedia, 8 Oct. 2021. Web. 25 Dec. 2021. <https://ja.wikipedia.org/w/index.php?title=%E3%83%A2%E3%83%B3%E3%83%86%E3%82%AB%E3%83%AB%E3%83%AD%E6%9C%A8%E6%8E%A2%E7%B4%A2&oldid=85943688>`__ `Winands, Mark & Björnsson, Yngvi & Saito, Jahn-Takeshi. (2008). Monte-Carlo Tree Search Solver. 25-36. 10.1007/978-3-540-87608-3_3. <https://www.researchgate.net/publication/220962507_Monte-Carlo_Tree_Search_Solver>`__ `Yao, Yao. (2018). API Python Chess: Distribution of Chess Wins based on random moves <https://www.slideshare.net/YaoYao44/api-python-chess-distribution-of-chess-wins-based-on-random-moves>`__ `YouTube channel of David Beazley <https://www.youtube.com/channel/UCbNpPBMvCHr-TeJkkezog7Q>`__ `Yu, Tina and Christopher D. Clack. “Recursion , Lambda Abstractions and Genetic Programming.” . <https://pdfs.semanticscholar.org/b0bc/b2e8c96c750c8cae70ad20c675023f314191.pdf>`__ `chess-alpha-zero <https://github.com/Zeta36/chess-alpha-zero>`__ `easyAI <https://github.com/Zulko/easyAI>`__ `Öberg, Viktor. “EVOLUTIONARY AI IN BOARD GAMES : An evaluation of the performance of an evolutionary algorithm in two perfect information board games with low branching factor.” (2015). <http://www.diva-portal.org/smash/get/diva2:823737/FULLTEXT01.pdf>`__ a_{t} = arg\, max_{a}(Q(s_{t}, a) + C_{gp}\sqrt\frac{2lnN(s_{t})}{N(s_{t},a)})

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
\end{cases} a_{t} = arg\, max_{a}(Q(s_{t}, a) + U(s_{t}, a))

U(s,a)=C(s)P(s,a)\frac{\sqrt{N(s)}}{{1+N(s,a)}}

C(s)=log\frac{1+N(s)+c_{base}}{c_{base}}+c_{init} and execute :command:`source` command: if_improvement if_is_check if_pruning if_result if_shortcut p t \leq L

N(s_{t} , a_{t}) = N(s_{t} , a_{t}) + 1

W (s_{t} , a_{t}) = W(s_{t} , a_{t}) + v

Q(s_{t} , a_{t}) = \frac{W(s_{t} , a_{t})}{N(s_{t} , a_{t})} v Project-Id-Version: Chess-Ant 
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2023-02-26 18:05+0900
PO-Revision-Date: 2023-02-26 18:40+0900
Last-Translator: Akihiro Kuroiwa <akuroiwa@env-reform.com>
Language: ja
Language-Team: Japanese
Plural-Forms: nplurals=1; plural=0;
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.11.0
 (p, v) = f_{\theta}(s_{L}) (s,a) :file:`genPgn.py` はstockfishで自動対局をし、PGN filesを出力する。ちなみに、Version 0.0.1の :file:`genPgn.py` はウォルラス演算子を含むので、Python>=3.8でしか動作しない。 :file:`importPgn.py` はPGN filesからデータセットを作成する。 :file:`chess_classification.py` はSimple Transformersによる学習済みモデルを生成する。この学習済みモデルを用いて、AlphaZeroのように :file:`chess_ant.py` のrolloutの代用とする予定だ。 Deep neural network :math:`(p, v) = f_{\theta}(s)` はパラメータ :math:`\theta` により末端のノード :math:`s_{L}` を評価する： （Deep neural networkにより予測された）スカラー値 AlphaGo ZeroやAlphaZeroで導入されたPolynomial Upper Confidence Tree (PUCT)の変種は事前確率 :math:`P(s,a)` で定数 :math:`C(s)` を補完している。Chess-Antでは従来のConventional Upper Confidence Tree (UCT)を用い、定数 :math:`C(s)` の調整をGenetic Programming (GP)に置き換える [#]_。:math:`1/\sqrt{1}` から :math:`1/\sqrt{9}` までGPは状況に応じて定数 :math:`C` の値を選ぶ。定数 :math:`C` の値により、 :file:`chess_ant.py` は積極的に調べたり、消極的な調べ方をする。 （Deep neural networkにより予測された）手を選ぶ確率のベクトル `Issues #658 <https://github.com/DEAP/deap/issues/658>`_ によると、Deap は Python 3.10 で動作せず、version 3.11 で動作する。 AlphaZero's PUCT [#]_ [#]_ [#]_ [#]_: また、GPは各generationにおいて、やり直すことができるので、訪問回数による検索初期のUCTの高評価を防げる。この論文のような効果を得られるかも知れない [#]_。 別の方法として、 :command:`update-alternatives` がある。 別のプロジェクトとしてFENの勝敗評価に Natural Language Processing (NLP) 用の deep learning [#]_  [#]_ を導入する。 参考文献 C(s) 変更履歴 Chess-Ant 論文 Chess-Ant's UCT [#]_ [#]_ [#]_ [#]_ [#]_: 条件 :mod:`chess-ant` 0.0.5 までUCB1の数式に誤りがあったので ``math.sqrt(2)`` を追加し、訂正した。:mod:`mcts` の作者が、 :file:`mcts.py` 内で ``explorationConstant = 1 / math.sqrt(2)`` を初期値としたのは、 ``math.sqrt(2)`` を打ち消すためと思われる。新たに ``selectNodeEphemeralConstant`` という terminal を :mod:`chess-ant` 0.0.6 で追加し、 ephemeral constant の代替とした。 詳細 開発予定 それぞれのstate-actionのペア 前回よりもUCTが増加したら move_stackが前回よりも短くなったら :file:`~/.bashrc` 或いは :file:`~/.bash_aliases` で： :mod:`chess-classification` 0.0.4 で fen を token に区切ってデータセットを作成するようにした。その fen は1文字ずつではなく、一列ごとに区切ってある。 :mod:`chess-classification` 0.0.5 から、保存したモデルの読み込みが出来る。 さらに、Pythonでは ``goto`` が無いので、余計なコードがある。擬似コードではMCTS Solver内部で全て完結するが、 :file:`chess_ant.py` では ``_executeRound()`` に分けて書いてある。 ``mctsSolver()`` 内でrolloutを実行し、枝切りなどの処理をし、rolloutと同様にrewardを出力し、 ``backpropogate()`` に入力する。 学習時間を短縮するために、 [#]_ checkpoint が google/electra-small-discriminator [#]_ の electra modelに変更した。 AlphaZeroからの影響 初期化： 前回選ばれたnodeでcheckだったか DeepMind が開発した AlphaFold のように、 MCTS は bioinformatics や cheminformatics へ応用できる。Chess-Ant では AlphaZero に影響を受けつつも、それとは異なる方法を試す。MCTS Solver と Genetic Programming の組み合わせが実用に耐えうるか、その可能性を示すのが目標だ。 Negamaxと同様にMCTS solverも再帰関数であり、停止条件が必要だ。 MCTS Solver 私が用意した pgn ファイルは chess problems と言うよりも寧ろ tactics [#]_  [#]_ に近いので、データセットは tactics から作成する方が効率が良い。正解率を高めるためには、モデルの学習とモデルの評価にそれぞれ300行以上の pgn データが必要だ。 N(s) N(s,a) N(s_{L} , a) = 0

W(s_{L} , a) = 0

Q(s_{L} , a) = 0

P(s_{L} , a) = p_{a} P(s,a) 2022年12月現在、gnome-terminal は Ubuntu 22.04.1 LTS の Python 3.11 では起動しないことを覚えておいて欲しい。 Q(s,a) 参照 :mod:`chess-classification` と :mod:`chem-classification` は同じアルゴリズムを用いているので、同時期に同じ変更を施している。 Exploration（とExploitation）の割合 判断する条件は以下の通り： action-valueの平均 親（ノード）の訪問数 s での a を選択する事前確率 論文の擬似コードを大幅に変更している理由は、継承クラスが参照する `パッケージ <https://github.com/pbsinclair42/MCTS>`__ のコードの書き方が異なるからだ。 action-valueの合計 訪問数 最優先に設定した元のヴァージョンに戻すには： Todo 更新： W(s,a) UCTが無限大か無限小か、何れでもないか 前回のrolloutが勝ちか負けか引き分けか MCTS Solver [#]_  [#]_ の導入により、高速化と誤答を減らす為の枝切りを行う。 `Agapitos, Alexandros & Lucas, Simon. (2006). Learning Recursive Functions with Object Oriented Genetic Programming. 3905. 166-177. 10.1007/11729976_15. <https://www.researchgate.net/publication/221009242_Learning_Recursive_Functions_with_Object_Oriented_Genetic_Programming>`__ `Alpha-Beta Pruning <https://www.javatpoint.com/ai-alpha-beta-pruning>`__ `AlphaZero: Shedding new light on chess, shogi, and Go <https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go>`__ `Alpha“Othello” Zero <https://github.com/tkhkaeio/AlphaZero>`__ `Astro Teller \| Technical Papers <http://www.astroteller.net/work/papers>`__ `Auer, Peter et al. “Finite-time Analysis of the Multiarmed Bandit Problem.” Machine Learning 47 (2004): 235-256. <https://www.semanticscholar.org/paper/Finite-time-Analysis-of-the-Multiarmed-Bandit-Auer-Cesa-Bianchi/1e1d35136b1bf3b13ef6b53f6039f39d9ee820e3>`__ `Baier, Hendrik & Winands, Mark. (2015). MCTS-Minimax Hybrids. IEEE Transactions on Computational Intelligence and AI in Games. 7. 167-179. 10.1109/TCIAIG.2014.2366555. <https://dke.maastrichtuniversity.nl/m.winands/documents/mcts-minimax_hybrids_final.pdf>`__ `Bratko-Kopec Test <https://www.chessprogramming.org/Bratko-Kopec_Test>`__ `Brynjulfsson, Erlingur. A Genetic Minimax Game-Playing Strategy <https://notendur.hi.is/benedikt/Courses/Erlingur.pdf>`__ `Cazenave, Tristan. “Evolving Monte-Carlo Tree Search Algorithms.” (2007). <https://www.semanticscholar.org/paper/Evolving-Monte-Carlo-Tree-Search-Algorithms-Cazenave/336231ec5085098b35c573d885e18c3392e3703d>`__ `Czech, Johannes et al. “Monte-Carlo Graph Search for AlphaZero.” ArXiv abs/2012.11045 (2020): n. pag. <https://arxiv.org/abs/2012.11045>`__ `Download tactics database <https://lichess.org/forum/lichess-feedback/download-tactics-database>`__ `ELECTRA: Pre-training Text Encoders as Discriminators Rather Than Generators <https://huggingface.co/google/electra-small-discriminator>`__ `Fiekas, Niklas. (2015). An implementation of the Bratko-Kopec Test using python-chess <https://gist.github.com/niklasf/73c9565719d124af64ff>`__ `Foster, David. (2017). AlphaGo Zero Explained In One Diagram <https://medium.com/applied-data-science/alphago-zero-explained-in-one-diagram-365f5abf67e0>`__ `Gorgonian's Chess Site <http://gorgonian.weebly.com/>`__ `Hart, Alex. (2011). Alpha Beta pruning on a Minimax tree in Python <https://gist.github.com/exallium/1446104/5109388cfc21578f555dcac0ba54da680326af7b>`__ `Hartikka, Lauri. (2017). A step-by-step guide to building a simple chess AI <https://www.freecodecamp.org/news/simple-chess-ai-step-by-step-1d55a9266977/>`__ `Home Page of John R. Koza <http://www.genetic-programming.com/johnkoza.html>`__ `Imagawa, Takahisa and Tomoyuki Kaneko. “Improvement of State’s Value Estimation for Monte Carlo Tree Search.” (2017). <https://www.semanticscholar.org/paper/Improvement-of-State%E2%80%99s-Value-Estimation-for-Monte-Imagawa-Kaneko/1b45c6e02944e2f4ec2dbc77083e8cc4eb7c9e8a>`__ `Kocsis, Levente and Csaba Szepesvari. “Bandit Based Monte-Carlo Planning.” ECML (2006). <https://www.semanticscholar.org/paper/Bandit-Based-Monte-Carlo-Planning-Kocsis-Szepesvari/e635d81a617d1239232a9c9a11a196c53dab8240>`__ `Kurt & Rolf Chess Homepage of Kurt Utzinger <http://www.utzingerk.com/test.htm>`__ `Lones, Michael. (2014). Genetic Programming: Memory, Loops and Modules. David Corne: Open Courseware. <https://www.macs.hw.ac.uk/~dwcorne/Teaching/bic1415_gp2.pdf>`__ `Noever, David et al. “The Chess Transformer: Mastering Play using Generative Language Models.” arXiv: Artificial Intelligence (2020): n. pag. <https://arxiv.org/pdf/2008.04057.pdf>`__ `PGN Mentor <https://www.pgnmentor.com/>`__ `Prasad, Aditya. (2018). Lessons From Implementing AlphaZero <https://medium.com/oracledevs/lessons-from-implementing-alphazero-7e36e9054191>`__ `Python Chess <https://www.chessprogramming.net/python-chess/>`__ `PythonChessAi <https://github.com/AnthonyASanchez/python-chess-ai>`__ `Rajapakse, Thilina. (2020). Battle of the Transformers: ELECTRA, BERT, RoBERTa, or XLNet <https://towardsdatascience.com/battle-of-the-transformers-electra-bert-roberta-or-xlnet-40607e97aba3>`__ `Savransky, Dmitriy. (2020). How to Use GPT-2 for Custom Data Generation. INTERSOG Inc. <https://intersog.com/blog/the-gpt-2-usage-for-custom-data-generation-by-example-playing-chess/>`__ `Shrott, Ryan. (2017). Genetic Programming applied to AI Heuristic Optimization <https://towardsdatascience.com/genetic-programming-for-ai-heuristic-optimization-9d7fdb115ee1>`__ `Silver, David et al. “A general reinforcement learning algorithm that masters chess, shogi, and Go through self-play.” Science 362 (2018): 1140 - 1144. <https://www.semanticscholar.org/paper/A-general-reinforcement-learning-algorithm-that-and-Silver-Hubert/f9717d29840f4d8f1cc19d1b1e80c5d12ec40608>`__ `Simplified Evaluation Function <https://www.chessprogramming.org/Simplified_Evaluation_Function>`__ `Stöckl, Andreas. (2018). Writing a chess program in one day <https://medium.com/@andreasstckl/writing-a-chess-program-in-one-day-30daff4610ec>`__ `Stöckl, Andreas. (2019). An incremental evaluation function and a test-suite for computer chess <https://medium.com/datadriveninvestor/an-incremental-evaluation-function-and-a-testsuite-for-computer-chess-6fde22aac137>`__ `Stöckl, Andreas. (2019). Reconstructing chess positions <https://medium.com/datadriveninvestor/reconstructing-chess-positions-f195fd5944e>`__ `Swiechowski, Maciej et al. “Monte Carlo Tree Search: A Review of Recent Modifications and Applications.” ArXiv abs/2103.04931 (2021): n. pag. <https://www.semanticscholar.org/paper/Monte-Carlo-Tree-Search%3A-A-Review-of-Recent-and-Swiechowski-Godlewski/ad5fc69f2b092eab4171d1e87c59ef7992dfdc6e>`__ `Tadao Yamaoka’s diary <https://tadaoyamaoka.hatenablog.com/entry/2018/12/08/191619>`__ `Wikipedia contributors. "Monte Carlo tree search." Wikipedia, The Free Encyclopedia. Wikipedia, The Free Encyclopedia, 18 Oct. 2021. Web. 25 Dec. 2021. <https://en.wikipedia.org/w/index.php?title=Monte_Carlo_tree_search&oldid=1050627850>`__ `Wikipedia contributors. "モンテカルロ木探索." Wikipedia. Wikipedia, 8 Oct. 2021. Web. 25 Dec. 2021. <https://ja.wikipedia.org/w/index.php?title=%E3%83%A2%E3%83%B3%E3%83%86%E3%82%AB%E3%83%AB%E3%83%AD%E6%9C%A8%E6%8E%A2%E7%B4%A2&oldid=85943688>`__ `Winands, Mark & Björnsson, Yngvi & Saito, Jahn-Takeshi. (2008). Monte-Carlo Tree Search Solver. 25-36. 10.1007/978-3-540-87608-3_3. <https://www.researchgate.net/publication/220962507_Monte-Carlo_Tree_Search_Solver>`__ `Yao, Yao. (2018). API Python Chess: Distribution of Chess Wins based on random moves <https://www.slideshare.net/YaoYao44/api-python-chess-distribution-of-chess-wins-based-on-random-moves>`__ `YouTube channel of David Beazley <https://www.youtube.com/channel/UCbNpPBMvCHr-TeJkkezog7Q>`__ `Yu, Tina and Christopher D. Clack. “Recursion , Lambda Abstractions and Genetic Programming.” . <https://pdfs.semanticscholar.org/b0bc/b2e8c96c750c8cae70ad20c675023f314191.pdf>`__ `chess-alpha-zero <https://github.com/Zeta36/chess-alpha-zero>`__ `easyAI <https://github.com/Zulko/easyAI>`__ `Öberg, Viktor. “EVOLUTIONARY AI IN BOARD GAMES : An evaluation of the performance of an evolutionary algorithm in two perfect information board games with low branching factor.” (2015). <http://www.diva-portal.org/smash/get/diva2:823737/FULLTEXT01.pdf>`__ a_{t} = arg\, max_{a}(Q(s_{t}, a) + C_{gp}\sqrt\frac{2lnN(s_{t})}{N(s_{t},a)})

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
\end{cases} a_{t} = arg\, max_{a}(Q(s_{t}, a) + U(s_{t}, a))

U(s,a)=C(s)P(s,a)\frac{\sqrt{N(s)}}{{1+N(s,a)}}

C(s)=log\frac{1+N(s)+c_{base}}{c_{base}}+c_{init} 続いて  :command:`source` を実行する： if_improvement if_is_check if_pruning if_result if_shortcut p t \leq L

N(s_{t} , a_{t}) = N(s_{t} , a_{t}) + 1

W (s_{t} , a_{t}) = W(s_{t} , a_{t}) + v

Q(s_{t} , a_{t}) = \frac{W(s_{t} , a_{t})}{N(s_{t} , a_{t})} v 