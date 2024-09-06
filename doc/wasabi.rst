Scripts Manual
==============

:author: Akihiro Kuroiwa, ChatGPT of OpenAI, Perplexity AI
:date: 2024/09/05

``create_vina_config.py`` Script Manual
---------------------------------------

Overview
~~~~~~~~

The ``create_vina_config.py`` script generates an AutoDock Vina
configuration file (``config.txt``) from a specified PDB or mmCIF
structure file. This script allows you to set a docking box focused on
specific residues.

Usage
~~~~~

.. code:: bash

   python create_vina_config.py input_file [-o OUTPUT] [-l LIGAND] [-r RESIDUES] [-p PATH]

Arguments
~~~~~~~~~

-  **input_file** (required): Specifies the input file in PDB or mmCIF
   format.
-  **-o OUTPUT, -–output OUTPUT** (optional): Specifies the name of the output
   configuration file. The default is ``config.txt``.
-  **-l LIGAND, –-ligand LIGAND** (optional): Specifies the name of the ligand file.
   The default is ``ligand.pdbqt``.
-  **-r RESIDUES, –-residues RESIDUES** (optional): Specifies the residue numbers for
   setting the docking box. Use a hyphen (``-``) for ranges and commas
   (``,``) for multiple residues (e.g., ``100-105,110,115-120``).
-  **-p PATH, –-path PATH** (optional): Specifies the output directory. The default
   is the current directory.
-  **-c CHAIN, --chain CHAIN** (optional): Chain ID to select (e.g., ``A``).

Output
~~~~~~

-  **config.txt**: The generated AutoDock Vina configuration file
   includes the following details:

   -  Receptor and ligand file names.
   -  Docking box center coordinates and size.
   -  Calculation settings (``exhaustiveness``, ``num_modes``,
      ``energy_range``, ``cpu``).
   -  If residue numbers are specified, they are included as a comment
      at the beginning of the file.

.. code:: text

   # Residue selection: 100-105,110,115-120

   receptor = protein.pdbqt
   ligand = ligand.pdbqt
   center_x = 25.0
   center_y = 20.0
   center_z = 30.0
   size_x = 10.0
   size_y = 10.0
   size_z = 10.0
   out = out.pdbqt
   log = log.txt
   exhaustiveness = 8
   num_modes = 9
   energy_range = 3
   cpu = 8

Notes
~~~~~

-  The ``config.txt`` file can be edited with a text editor, which is
   useful for fine-tuning the docking box size, position, and
   calculation settings.
-  If no residue numbers are specified, the docking box is set for the
   entire structure.

``prepare_experiment.py`` Script Manual
---------------------------------------

.. _overview-1:

Overview
~~~~~~~~

The ``prepare_experiment.py`` script automates the preparation of
experiments based on a specified PDB ID. It generates an AutoDock Vina
configuration file (``config.txt``), a fragment file
(``fragments.csv``), and a configuration file (``config.ini``) for
``similarity-ant`` and ``similarity-mcts``. The script creates fragments
based on specified residue numbers and outputs these fragments or
molecules generated from them in SMILES format to a CSV file.

.. _usage-1:

Usage
~~~~~

.. code:: bash

   python prepare_experiment.py pdb_id [-f FORMAT] [-o OUTPUT] [--output_fragments] [--num_smiles NUM]

.. _arguments-1:

Arguments
~~~~~~~~~

-  **pdb_id** (required): Specifies the PDB ID for the experiment. The
   script downloads the PDB file based on this ID.
-  **-f {pdb,cif}, –-format {pdb,cif}** (optional): Specifies the input file format. You can
   choose between ``pdb`` and ``cif``. The default is ``pdb``.
-  **-o OUTPUT, –-output OUTPUT** (optional): Specifies the name of the output
   directory. The default is ``test-{pdb_id}``.
-  **–-output_fragments** (optional): Outputs the fragments themselves in
   SMILES format. If not specified, the script generates molecules from
   the fragments and outputs their SMILES.
-  **-n NUM_SMILES, –-num_smiles NUM_SMILES** (optional): Specifies the number of SMILES to
   generate. The default is ``10``.
-  **-r RESIDUES, –-residues RESIDUES** (optional): Residue selection string (e.g., ``100-105,110,115-120``).
-  **-c CHAIN, --chain CHAIN** (optional): Chain ID to select (e.g., ``A``).

.. _output-1:

Output
~~~~~~

-  **config.txt**: The AutoDock Vina configuration file. It includes
   receptor and ligand file names, docking box center coordinates and
   size, and calculation settings. This is a text file that can be
   edited. If residue numbers are specified, this information is
   included as a comment.
-  **fragments.csv**: A CSV file containing the SMILES of fragments or
   molecules generated from the specified residue numbers.
-  **config.ini**: An INI file containing the experimental settings for
   ``similarity-ant`` and ``similarity-mcts``. Common options are listed
   under the ``DEFAULT`` section, while experiment-specific options are
   listed under each respective section. The configuration file can be
   edited with a text editor.

.. _notes-1:

Notes
~~~~~

-  In ``config.ini``, do not use single or double quotes. If multiple
   values are required, separate them with spaces.
-  Boolean, integer, or string values are automatically identified by
   ``run_experiment.py``, but boolean options must be explicitly set
   with values like ``Yes``.
-  Options not specified in ``config.ini`` will be ignored.
-  When using ``select_ligands.py`` to create a ligand file, it is
   preferable to use the SMILES of generated molecules rather than
   fragment SMILES, as the latter may cause issues.

``run_experiment.py`` Script Manual
-----------------------------------

.. _overview-2:

Overview
~~~~~~~~

The ``run_experiment.py`` script reads settings from a ``config.ini``
file and executes either a ``similarity-ant`` or ``similarity-mcts``
experiment. The script outputs the generated molecules’ SMILES to a CSV
file, which can then be used with ``select_ligands.py`` to create a
ligand file.

.. _usage-2:

Usage
~~~~~

.. code:: bash

   python run_experiment.py config_file [-a | --ant] [-m | --mcts]

.. _arguments-2:

Arguments
~~~~~~~~~

-  **config_file** (required): Specifies the ``config.ini`` file
   containing the experiment settings.
-  **-a, –ant** (optional): Executes the ``similarity-ant`` experiment.
-  **-m, –mcts** (optional): Executes the ``similarity-mcts``
   experiment.

.. _output-2:

Output
~~~~~~

-  **generated_smiles.csv**: A CSV file containing the SMILES of the generated
   molecules from the experiment. This file can be used with
   ``select_ligands.py`` to create a ligand file.

.. _notes-2:

Notes
~~~~~

-  The ``config.ini`` file must include settings for either
   ``similarity-ant`` or ``similarity-mcts``. ``run_experiment.py``
   automatically identifies the necessary options and executes the
   experiment based on the provided settings.
-  The resulting SMILES in the CSV file can be used with
   ``select_ligands.py`` for ligand file creation.

``select_ligands.py`` Script Manual
-----------------------------------

``select_ligands.py`` is a Python script that selects top ligands from a CSV
file and converts them to PDBQT format.

.. _usage-3:

Usage
~~~~~

::

   python select_ligands.py <csv_file> [-o OUTPUT_DIR] [-n TOP_N]

.. _arguments-3:

Arguments
~~~~~~~~~

-  ``csv_file``: Input CSV file containing generated SMILES (required)
-  ``-o OUTPUT``, ``--output OUTPUT``: Output directory for ligand files (default:
   “ligands”)
-  ``-n TOP_N``, ``--top_n TOP_N``: Number of top ligands to select (default: 10)

Important Notes
~~~~~~~~~~~~~~~

1. **Fragment Processing**: This script is designed for complete
   molecule SMILES. Processing fragment SMILES (e.g.,
   ``[1*]C(=O)[C@@H]([4*])CCCCN``) directly may result in errors or
   inaccurate ligand files.

2. **Input Data Verification**: Ensure that the SMILES in your CSV file
   represent complete molecules. It is recommended to use SMILES of
   complete molecules generated by combining fragments.

3. **Error Handling**: The script may produce errors if it encounters
   invalid SMILES or unprocessable molecular structures. Check error
   messages and modify input data as necessary.

4. **Output Verification**: Always verify that the generated PDBQT files
   have the expected structure.

Recommended Usage
~~~~~~~~~~~~~~~~~

1. Generate complete molecule SMILES by combining fragments.
2. Save the generated SMILES in a CSV file.
3. Use this script to create ligand files from the complete molecule
   SMILES.
