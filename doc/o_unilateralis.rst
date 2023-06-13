=====================
Chem-Ant Introduction
=====================

Select material candidates to output molecules similar to the target molecule with MCTS Solver and Genetic Programming.

:file:`similarity_ant.py` is based on the code of
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

   pip3 install deap
   pip3 install mcts
   pip3 install rdkit
   pip3 install global_chem_extensions
   pip3 install mcts-solver

Or:

.. code-block:: bash

   pip3 install chem-ant

If you want to use :mod:`chem-ant` with :mod:`chem-classification`:

.. code-block:: bash

   pip3 install simpletransformers

Or:

.. code-block:: bash

   pip3 install chem-classification

-  `DEAP <https://github.com/DEAP/deap>`__
-  `MCTS <https://github.com/pbsinclair42/MCTS>`__
-  `RDKit <https://www.rdkit.org/>`__
-  `rdkit-pypi <https://pypi.org/project/rdkit-pypi/>`__
-  `Global-Chem <https://github.com/Sulstice/global-chem>`__
-  `chem-ant <https://github.com/akuroiwa/chem-ant>`__
-  `chem-classification <https://github.com/akuroiwa/chem-classification>`__
-  `mcts-solver <https://github.com/akuroiwa/mcts-solver>`__


General Usage
=============

By default, you get a list of molecules from :file:`smiles.csv`. The target is Nirmatrelvir. From that list, the best material for the fragments is selected.  The output csv file also contains molecules created during the execution of mcts.  If you want to reuse the csv file as a smiles list, add :command:`--select` option.  If you want to run commands directly without installing the packages, execute just like :command:`python3 similarity_mcts.py --help`:

.. code-block:: bash

   similarity-mcts --help
   similarity-mcts -i -l1 -e3 -r10 -b500 -p train_smiles
   similarity-mcts -i -l1 -e3 -r10 -b500 -p eval_smiles

If you want to specify a target and execute:

.. code-block:: bash

   similarity-mcts -i -l1 -e3 -r10 -b500 -p train_smiles -t "CC(C)(C)C(NC(=O)C(F)(F)F)C(=O)N1CC2C(C1C1CCNC1=O)C2(C)C"
   similarity-mcts -i -l1 -e3 -r10 -b500 -p eval_smiles -t "CC(C)(C)C(NC(=O)C(F)(F)F)C(=O)N1CC2C(C1C1CCNC1=O)C2(C)C"

:command:`similarity-mcts` selects and outputs the candidates that can be the material of the fragments from the smiles list.
If you just want to output target-like molecules from the smiles list without running mcts:

.. code-block:: bash

   similarity-genMols --help
   similarity-genMols -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -m "CC1=CC=CC=C1C(C)C" "Cc1ccccc1CC(C#N)NC1CCNC1=O" -f "gen2.csv"


Chem-Classification
====================

Output dataset in json format for :mod:`chem-classification`:

.. code-block:: bash

   importSmiles -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -p "train_smiles"
   importSmiles -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -p "eval_smiles"

If you want to output the dataset for regression model:

.. code-block:: bash

   importSmiles -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -p "train_smiles" -r
   importSmiles -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -p "eval_smiles" -r

Train the classification model and predict the similarity between Nirmatrelvir and YH-53:

.. code-block:: python

   from chem_classification.similarity_classification import SimilarityClassification
   s = SimilarityClassification()
   s.train_and_eval("train_smiles/smiles.json", "eval_smiles/smiles.json")
   s.predict_smiles_pair(["CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C", "CC(C)CC(C(=O)NC(CC1CCNC1=O)C(=O)C2=NC3=CC=CC=C3S2)NC(=O)C4=CC5=C(N4)C=CC=C5OC"])

Loading a local save:

.. code-block:: python

   s = SimilarityClassification("local-path/your-outputs")

Train regression model to predict similarity between Nirmatrelvir and YH-53:

.. code-block:: python

   from chem_classification.similarity_classification import SimilarityRegression
   s = SimilarityRegression()
   s.train_and_eval("train_smiles/smiles.json", "eval_smiles/smiles.json")
   s.predict_smiles_pair(["CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C", "CC(C)CC(C(=O)NC(CC1CCNC1=O)C(=O)C2=NC3=CC=CC=C3S2)NC(=O)C4=CC5=C(N4)C=CC=C5OC"])

Another regression model trained by json files output by :command:`similarity-mcts` can predict the similarity with the target molecule from the material candidates and cooperate with :command:`similarity-ant`:

.. code-block:: bash

   similarity-mcts -i -l2 -e3 -r10 -b100 -p "train_smiles" -f "smiles.json" -j
   similarity-mcts -i -l2 -e3 -r10 -b100 -p "eval_smiles" -f "smiles.json" -j

.. note::

   From :mod:`chem-ant` 0.0.7,
   I changed it to create datasets with molecular fragments as tokens, so the difference between the two regression models is gone.

Cooperation between :mod:`chem-classification` and :command:`similarity-ant` (currently not working):

.. code-block:: bash

   similarity-ant -n20 -g5 -b 1 -p gen_smiles -d -o "local-path/your-outputs"

Cooperation between regression model of :mod:`chem-classification` and :command:`similarity-ant`:

.. code-block:: bash

   similarity-ant -n20 -g5 -b 1 -p gen_smiles -r -o "local-path/your-outputs"
