================
Chem-Ant Article
================

:author: Akihiro Kuroiwa
:date: 2022/07/08
:abstract:
   I started writing :mod:`chess-ant` in 2019, but at first I was particular about minimax and the work did not proceed slowly.
   With the COVID-19 outbreak of the cruise ship Diamond Princess in 2020, when the pandemic was finally beginning to attract attention,
   I decided to use the :mod:`chess-ant` algorithm for the development of therapeutic agents.
   After that, I read the paper of MCTS solver and the performance improved.
   At the same time, I learned how to use the cheminformatics software.
   Even after the SARS-CoV-2 pandemic has converged, the next pandemic is waiting.
   Let's contribute to society with our skills.

UCSF Chimera
============

On my old laptop Fujitsu LIFEBOOK AH42/C, when I try to install `UCSF ChimeraX <https://www.cgl.ucsf.edu/chimerax/>`__, I get the following error:

::

   ERROR: ChimeraX requires OpenGL graphics version 3.3.
   Your computer graphics driver provided version 2.1
   Try updating your graphics driver.

Therefore, in this experiment, I use `UCSF Chimera <https://www.rbvi.ucsf.edu/chimera/>`__. The advantage is that you can specify the binding site with the mouse.

.. code-block:: bash

   chmod u+x chimera-alpha-linux_x86_64.bin
   ./chimera-alpha-linux_x86_64.bin

In :file:`~/.profile` on Ubuntu:

.. code-block:: bash

   if [ -d "$HOME/.local/bin" ] ; then
       PATH="$HOME/.local/bin:$PATH"
   fi

In my case, there are two installation locations:

.. code-block:: bash

   ~/.local/bin/
   ~/.local/UCSF-Chimera64-2022-05-18/

Run :command:`chimera` from the terminal on the command line, or right-click the desktop icon to give execute permission and double-click to launch UCSF Chimera.

Prior to this experiment, get the latest release of the `AutoDock Vina installer from GitHub <https://github.com/ccsb-scripps/AutoDock-Vina>`__ and install it according to the manual.  You can check the location of the binary file with the following command:

.. code-block:: bash

   cd ~/.local/bin/
   ln -s vina_1.2.3_linux_x86_64 vina
   which vina

To verify the operation, proceed with the experiment as follows:

#. Create fragments of the target molecule Nirmatrelvir and output some molecules.
#. Material candidates including the target molecule are selected by :command:`similarity-mcts`, and some molecules are output.
#. Get the `set difference <https://stackoverflow.com/questions/18180763/set-difference-for-pandas>`__.

.. code-block:: bash

   similarity-genMols -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -m "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -b70 -p "gen_smiles" -f "gen1-1.csv"
   similarity-mcts -l2 -e3 -r10 -b100 -p "gen_smiles" -f "gen1-2.csv"

After running, you would see something like this:

::

   Material candidates: {'CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C', 'CCCC1=NC(=C(N1CC2=CC=C(C=C2)C3=CC=CC=C3C4=NNN=N4)C(=O)O)C(C)(C)O'}

There are some things to keep in mind when running :command:`similarity-genMols`.  Python doesn't distinguish between single and double quotes, but bash and dash do.  In addition, you don't need commas on the command line:

.. code-block:: bash

   similarity-genMols -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -m "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" "CCCC1=NC(=C(N1CC2=CC=C(C=C2)C3=CC=CC=C3C4=NNN=N4)C(=O)O)C(C)(C)O" -b100 -f gen1-2.csv
   similarity-genMols -t "CC1(C2C1C(N(C2)C(=O)C(C(C)(C)C)NC(=O)C(F)(F)F)C(=O)NC(CC3CCNC3=O)C#N)C" -m "CCCC1=NC(=C(N1CC2=CC=C(C=C2)C3=CC=CC=C3C4=NNN=N4)C(=O)O)C(C)(C)O" -b100 -f gen1-3.csv

.. code-block:: python

   import pandas as pd
   df1_1 = pd.read_csv("gen_smiles/gen1-1.csv", header=0, index_col=0)
   df1_2 = pd.read_csv("gen_smiles/gen1-2.csv", header=0, index_col=0)
   df1_3 = pd.read_csv("gen_smiles/gen1-3.csv", header=0, index_col=0)
   df1_4 = pd.concat([df1_1, df1_1, df1_2, df1_3, df1_3], axis=0)
   df1_4.drop_duplicates(subset="smiles", keep=False, inplace=True)
   df1_4.sort_values(["lipinski", "dice_similarity"], inplace=True, ascending=False)
   df1_4.reset_index(drop=True).to_csv("gen_smiles/gen1-4.csv")

Create a ligand file with `Open Babel <http://openbabel.org/wiki/Main_Page>`__.  Open :file:`gen3.csv` and specify the smiles of high-scoring molecule with :command:`similarity-mcts`.  Don't forget to add hydrogen atoms and assign partial charges.  On Ubuntu:

.. code-block:: bash

   sudo apt install openbabel
   obabel -L
   obabel -L charges
   obabel -h -c -ican -:"CCCC1C2C(CN1C(=O)C1C3C(CN1C(=O)C(F)(F)F)C3(C)C)C2(C)C" -opdbqt -O ligand.pdbqt --gen3D --partialcharge gasteiger

Let's go back to UCSF Chimera. Open the above file and follow the menu as follows:

#. :menuselection:`File --> Fetch Structure by ID --> PDB(mmCIF) --> 7tll`
#. :menuselection:`File --> Open --> ligand.pdbqt --> file type PDB`
#. :menuselection:`Tools --> Surface/Binding Analysis --> AutoDock Vina`

Our :guilabel:`Output file` is :file:`all`.
Specify :guilabel:`Receptor` and :guilabel:`Ligand`.
Check :guilabel:`Resize search volume using` for your mouse.
Write vina path in :guilabel:`Executable location`.

In my case, when I specified the binding site with the mouse, the frame was not displayed unless I switched it with the :guilabel:`Presets` menu.
When reconfirming the experimental results, open :file:`all.receptor.pdb` and:

#. :menuselection:`Tools --> Surface/Binding Analysis --> ViewDock --> all.pdbqt`
#. :menuselection:`Move --> Play`


AutoDock Vina
=============

Reuse the receptor file output by UCSF Chimera and experiment on the command line.
You will prepare your own ligand file.
The contents of :file:`conf.txt` are as follows:

.. code-block::

   receptor = all.receptor.pdbqt
   ligand = ligand.pdbqt

   out = all.pdbqt

   center_x = -2.68714
   center_y = -1.23572
   center_z = 13.8821

   size_x = 25.747
   size_y = 22.6627
   size_z = 22.1881

:command:`similarity-mcts` now chose Catechin and the mysterious molecule Gnididin [#]_:

.. code-block:: bash

   similarity-mcts -l2 -e3 -r10 -b100 -p "gen_smiles" -f "gen2-2.csv"

::

   Material candidates: {'C1C(C(OC2=CC(=CC(=C21)O)O)C3=CC(=C(C=C3)O)O)O', 'CCCCCC=CC=CC(=O)OC1C(C23C4C=C(C(=O)C4(C(C5(C(C2C6C1(OC(O6)(O3)C7=CC=CC=C7)C(=C)C)O5)CO)O)O)C)C'}

:file:`gen2-2.csv`:

::

   ,smiles,dice_similarity,lipinski
   0,C=C(C)C12OC3(CO)OC1C1C4OC4(CO)C(O)C4(O)C(=O)C(C)=CC4C1(O3)C(C)C2CO,0.19672131147540983,1.0

Unfortunately, this molecule is made up of fragments produced solely by Gnididin:

.. code-block:: bash

   obabel -h -c -ican -:"C=C(C)C12OC3(CO)OC1C1C4OC4(CO)C(O)C4(O)C(=O)C(C)=CC4C1(O3)C(C)C2CO" -opdbqt -O ligand.pdbqt --gen3D --partialcharge gasteiger

Execute AutoDock Vina:

.. code-block:: bash

   vina --config conf.txt

::

   mode |   affinity | dist from best mode
	| (kcal/mol) | rmsd l.b.| rmsd u.b.
   -----+------------+----------+----------
      1       -8.765          0          0
      2        -8.31       1.82      6.828
      3       -8.252      2.441      4.152
      4       -8.086      1.664      7.041
      5        -7.85      2.301      7.148
      6       -7.825      1.726      6.693
      7       -7.797      3.008      6.184
      8       -7.412      2.183      7.011
      9       -7.339      2.426      4.168


Mold for Smiles Casting
=======================

The amino acid interaction described in this paper [#]_ is based on `PDB ID: 6LU7 <https://www.rcsb.org/structure/6lu7>`__, while our experiments are based on the SARS-CoV-2 Mpro Omicron P132H contained in `PDB ID: 7TLL <https://www.rcsb.org/structure/7tll>`__.
The first three letters of active site amino acid are abbreviations for amino acids, and the rest represent the positions of sequences.
Let's check with UCSF Chimera:

#. :menuselection:`Presets --> Interactive 1 (ribbons)` with :command:`chimera`.
#. Hover your cursor over the receptor's active site amino acid on the binding site to see its location.
#. Display a nucleotide or amino acid sequence alignment with :command:`chimera` from :menuselection:`Tools --> Sequence --> Sequence` and save it in fast format.
#. If you want to check the Active site amino acid, right-click on the relevant part of the sequence.

If you cast from a mold, the casting should fit the original mold.
That's why I added amino acids and nucleotides to the file :file:`smiles.csv` [#]_.
Whether the relationship between the binding site and the ligand in docking simulation can be said to be the same, let's experiment with the following method:

#. Convert the relevant part to smiles with :mod:`rdkit`.  The range is from Phe140 to Glu166 in sequence.
#. The smiles string is so long, let's break it down into fragments and outputs them to some molecules.

.. code-block:: python

   from rdkit import Chem
   from rdkit.Chem import BRICS
   Chem.MolToSmiles(Chem.MolFromFASTA("FLNGSCGSVGFNIDYDCVSFCYMHHME"))
   smiles = 'CC[C@H](C)[C@H](NC(=O)[C@H](CC(N)=O)NC(=O)[C@H](Cc1ccccc1)NC(=O)CNC(=O)[C@@H](NC(=O)[C@H](CO)NC(=O)CNC(=O)[C@H](CS)NC(=O)[C@H](CO)NC(=O)CNC(=O)[C@H](CC(N)=O)NC(=O)[C@H](CC(C)C)NC(=O)[C@@H](N)Cc1ccccc1)C(C)C)C(=O)N[C@@H](CC(=O)O)C(=O)N[C@@H](Cc1ccc(O)cc1)C(=O)N[C@@H](CC(=O)O)C(=O)N[C@@H](CS)C(=O)N[C@H](C(=O)N[C@@H](CO)C(=O)N[C@@H](Cc1ccccc1)C(=O)N[C@@H](CS)C(=O)N[C@@H](Cc1ccc(O)cc1)C(=O)N[C@@H](CCSC)C(=O)N[C@@H](Cc1c[nH]cn1)C(=O)N[C@@H](Cc1c[nH]cn1)C(=O)N[C@@H](CCSC)C(=O)N[C@@H](CCC(=O)O)C(=O)O)C(C)C'
   allfrags = set()
   allfrags.update(BRICS.BRICSDecompose(Chem.MolFromSmiles(smiles), returnMols=True))
   builder = BRICS.BRICSBuild(allfrags)
   generated_smiles = []
   for i in range(30):
       mol = next(builder)
       mol.UpdatePropertyCache(strict=True)
       generated_smiles.append(Chem.MolToSmiles(mol))
   generated_smiles
   ['CSCC[C@H](SC)C(=O)N[C@@H](CCC(=O)O)C(=O)O', 'CSCC[C@H](SC)C(=O)Nc1c[nH]cn1', 'CSCC[C@H](SC)C(=O)Nc1ccc(O)cc1', 'CSCC[C@H](SC)C(=O)Nc1ccccc1', 'CS[C@@H](CC(C)C)C(=O)Nc1ccc(O)cc1', 'CC(C)C[C@H](N[C@@H](CCC(=O)O)C(=O)O)C(=O)Nc1ccc(O)cc1', 'CC(C)C[C@H](Nc1ccc(O)cc1)C(=O)Nc1ccc(O)cc1', 'CC(C)C[C@H](Nc1ccccc1)C(=O)Nc1ccc(O)cc1', 'CC(C)C[C@H](Nc1c[nH]cn1)C(=O)Nc1ccc(O)cc1', 'CS[C@@H](CC(C)C)C(=O)Nc1c[nH]cn1', 'CS[C@@H](CC(C)C)C(=O)Nc1ccccc1', 'CS[C@@H](CC(C)C)C(=O)N[C@@H](CCC(=O)O)C(=O)O', 'CS[C@@H](CC(=O)O)C(=O)NC(=O)[C@H](CC(C)C)SC', 'CS[C@@H](CC(C)C)C(=O)NC(=O)[C@@H](SC)C(C)C', 'CS[C@@H](CC(N)=O)C(=O)NC(=O)[C@H](CC(C)C)SC', 'CS[C@@H](CC(C)C)C(=O)NC(=O)[C@H](CS)SC', 'CS[C@@H](CC(C)C)C(=O)NC(=O)[C@@H](N)Cc1c[nH]cn1', 'CS[C@@H](CC(C)C)C(=O)NC(=O)[C@@H](N)Cc1ccc(O)cc1', 'CS[C@@H](CC(C)C)C(=O)NC(=O)[C@@H](N)Cc1ccccc1', 'CS[C@@H](CO)C(=O)NC(=O)[C@H](CC(C)C)SC', 'CS[C@@H](CC(C)C)C(=O)NC(=O)[C@H](CC(C)C)SC', 'CC[C@H](C)[C@H](SC)C(=O)NC(=O)[C@H](CC(C)C)SC', 'CSCC(=O)NC(=O)[C@H](CC(C)C)SC', 'CC(C)C[C@H](N[C@@H](CCC(=O)O)C(=O)O)C(=O)Nc1ccccc1', 'CC(C)C[C@H](Nc1c[nH]cn1)C(=O)Nc1ccccc1', 'CC(C)C[C@H](Nc1ccc(O)cc1)C(=O)Nc1ccccc1', 'CC(C)C[C@H](Nc1ccccc1)C(=O)Nc1ccccc1', 'CC(C)C[C@H](Nc1ccc(O)cc1)C(=O)N[C@@H](CCC(=O)O)C(=O)O', 'CC(C)C[C@H](Nc1ccccc1)C(=O)N[C@@H](CCC(=O)O)C(=O)O', 'CC(C)C[C@H](N[C@@H](CCC(=O)O)C(=O)O)C(=O)N[C@@H](CCC(=O)O)C(=O)O']

#. From the output molecules, select the molecules with good results by docking simulation. Of course, it's a good result among the options.
#. Run :command:`similarity-mcts` targeting that molecule.

.. code-block:: bash

   obabel -h -c -ican -:"CC(C)C[C@H](Nc1ccc(O)cc1)C(=O)N[C@@H](CCC(=O)O)C(=O)O" -opdbqt -O ligand.pdbqt --gen3D --partialcharge gasteiger
   vina --config conf.txt

::

   mode |   affinity | dist from best mode
	| (kcal/mol) | rmsd l.b.| rmsd u.b.
   -----+------------+----------+----------
      1       -7.192          0          0
      2       -7.014      2.837      4.843
      3       -7.002      1.339      2.292
      4       -7.001      2.143      4.417
      5       -6.894      1.303       2.67
      6       -6.759      2.539       6.62
      7       -6.578      2.329      7.121
      8       -6.547      3.004      7.767
      9        -6.51        1.3      2.908

.. code-block:: bash

   similarity-mcts -i -l2 -e3 -r10 -b100 -p "gen_smiles" -f "gen3-2.csv" -t "CC(C)C[C@H](Nc1ccc(O)cc1)C(=O)N[C@@H](CCC(=O)O)C(=O)O"

::

   Material candidates: {'CC1CCC2C(C(OC3C24C1CCC(O3)(OO4)C)OC)C', 'C(CCN)CC(C(=O)O)N', 'CC(C)C[C@H](Nc1ccc(O)cc1)C(=O)N[C@@H](CCC(=O)O)C(=O)O'}

::

   ,smiles,dice_similarity,lipinski
   0,CCNC1CCNC1=O,0.5454545454545454,1.0
   1,CC(Nc1ccccc1)C(=O)Oc1ccccc1,0.5269607843137255,1.0
   2,COC(=O)[C@H](CC(C)C)Nc1ccc(O)cc1,0.5084427767354597,1.0
   3,CC(C)C(=O)OC(=O)C(C)C,0.5078125,1.0
   4,O=C1NCCC1Nc1ccc(F)cc1,0.5066162570888468,1.0
   5,COC(=O)[C@H](CC(C)C)OC,0.5040983606557377,1.0
   6,C(c1nn[nH]n1)c1nn[nH]n1,0.4921875,1.0
   7,CCOc1nn[nH]n1,0.4765625,1.0
   8,COc1ccc(O)cc1,0.46875,1.0
   9,CO[C@@H](CCC(=O)O)C(=O)O,0.4609053497942387,1.0
   10,CC(C(=O)N1Cc2ccccc2CC1C(=O)O)N1Cc2ccccc2CC1c1ccccc1,0.4494649227110582,1.0
   11,CC(C(=O)N1Cc2ccccc2CC1C(=O)O)N1Cc2ccccc2CC1C(=O)O,0.4436183395291202,1.0
   12,c1ccc(C2CC3CCCC3N2c2ccccc2)cc1,0.4426666666666666,1.0
   13,COC(=O)[C@H](CC(C)C)NC1OC2OC3(C)CCC4C(C)CCC(C1C)C24OO3,0.43861607142857145,1.0
   14,O=C(O)C1Cc2ccccc2CN1c1ccccc1,0.4348387096774193,1.0
   15,CC1CCC2C(C)C(Nc3ccc(O)cc3)OC3OC4(C)CCC1C32OO4,0.4311717861205916,1.0
   16,CO[C@@H](CC(C)C)C(=O)NC1OC2OC3(C)CCC4C(C)CCC(C1C)C24OO3,0.4242761692650334,1.0
   17,CC(C(=O)Oc1ccccc1)N1C(c2ccccc2)CC2CCCC21,0.4230287859824781,1.0
   18,CCOc1ccccc1C(=O)O,0.4228971962616822,1.0
   19,Cc1cc(NC2CCNC2=O)no1,0.4113924050632911,1.0

Ignore short smiles:

.. code-block:: bash

   obabel -h -c -ican -:"CC(C(=O)N1Cc2ccccc2CC1C(=O)O)N1Cc2ccccc2CC1c1ccccc1" -opdbqt -O ligand.pdbqt --gen3D --partialcharge gasteiger
   vina --config conf.txt

::

   mode |   affinity | dist from best mode
	| (kcal/mol) | rmsd l.b.| rmsd u.b.
   -----+------------+----------+----------
      1       -8.417          0          0
      2       -8.302      2.467      6.754
      3       -8.003       4.96      7.503
      4       -7.624      3.907      6.517
      5       -7.506      5.171      7.983
      6       -7.485      2.979      5.385
      7       -7.433      5.416      9.353
      8       -7.375      2.857      5.204
      9       -7.296      2.998      5.526

If you need the target molecule itself, the above method may be useful.

.. todo::

   -  Separate MCTS solver as another package.
   -  Is it possible to get a high score by docking simulation without the target molecule?
   -  Type bool is output as 1.0 or 0.0 in a csv file.
   -  :command:`similarity-ant` is so slow that it is far from practical.
   -  Is :command:`similarity-mcts` working properly in the first place?
   -  Version 0.0.3 of :command:`similarity-mcts` now imports MCTS solver, so the output is slightly different from this document.
   -  Unravel the entangled spaghetti code.


Reference
=========

.. [#] `Sisakht, M., Mahmoodzadeh, A., & Darabian, M. (2021).
   Plant-derived chemicals as potential inhibitors of SARS-CoV-2 main protease (6LU7), a virtual screening study. Phytotherapy research : PTR, 35(6), 3262–3274.
   https://doi.org/10.1002/ptr.7041
   <https://pubmed.ncbi.nlm.nih.gov/33759279/>`__

.. [#] `SAMANT, L., & Javle, V. (2020).
   Comparative Docking Analysis of Rational Drugs Against COVID-19 Main Protease.
   ChemRxiv. doi:10.26434/chemrxiv.12136002.v1 This content is a preprint and has not been peer-reviewed.
   <https://chemrxiv.org/engage/chemrxiv/article-details/60c749fd702a9b828b18b20c>`__

.. [#] `PubChem <https://pubchem.ncbi.nlm.nih.gov/>`__

Bibliography
============

-  `化学の新しいカタチ <https://future-chem.com/>`__
-  `Python for chemoinformatics <https://github.com/Mishima-syk/py4chemoinformatics>`__
-  `English version of Python for Chemoinformatics (pdf) <https://github.com/joofio/py4chemoinformatics>`__
-  `Sharif, Suliman. Understanding drug-likeness filters with RDKit and exploring the WITHDRAWN database. (2020).
   <https://sharifsuliman1.medium.com/understanding-drug-likeness-filters-with-rdkit-and-exploring-the-withdrawn-database-ebd6b8b2921e>`__
-  `Panikar, S., Shoba, G., Arun, M., Sahayarayan, J. J., Usha Raja Nanthini, A., Chinnathambi, A., Alharbi, S. A., Nasif, O., & Kim, H. J.
   (2021).
   Essential oils as an effective alternative for the treatment of COVID-19: Molecular interaction analysis of protease (Mpro) with pharmacokinetics and toxicological properties. Journal of infection and public health, 14(5), 601–610. https://doi.org/10.1016/j.jiph.2020.12.037
   <https://pubmed.ncbi.nlm.nih.gov/33848890/>`__
-  `@cat_lover. 構造生成メモ. (2021). <https://qiita.com/cat_lover/items/9540a2d00daba3584a22>`__
-  `GB-GM <https://github.com/jensengroup/GB-GM>`__
-  `Jensen, J. (2019). Graph-based Genetic Algorithm and Generative Model/Monte Carlo Tree Search for the Exploration of Chemical Space.
   ChemRxiv. doi:10.26434/chemrxiv.7240751.v2 This content is a preprint and has not been peer-reviewed.
   <https://chemrxiv.org/engage/chemrxiv/article-details/60c7405af96a000e09286278>`__
