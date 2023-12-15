py-chessboardjs
===============

Chess GUI using pywebview and chessboard.js.
The main files are :file:`start.py`, :file:`js/my-script.js` and :file:`index.html`.

Chess-Ant is currently too slow to function as a chess engine. To make
matters worse, there is a glitch in the call to chess-ant. It is
possible to experiment by loading pgn and having it solve the problem.

Installation
------------

Please read the `pywebview <https://pywebview.flowrl.com/>`__ and
`PyGObject <https://pygobject.readthedocs.io/en/latest/>`__ manuals, and
install dependent packages before proceeding.

If you are Ubuntu user:

.. code:: bash

   sudo apt install python3-venv
   python3.11 -m venv ~/.venv3.11
   source ~/.venv3.11/bin/activate
   which pip
   pip install py-chessboardjs[gtk]

If you want to install it on local repository:

.. code:: bash

   cd py-chessboardjs
   pip install .[gtk]

QT user:

.. code:: bash

   pip install py-chessboardjs[qt]

CEF user:

.. code:: bash

   pip install py-chessboardjs[cef]

Install your favorite UCI engine:

.. code:: bash

   sudo apt install stockfish

Usage
-----

.. code:: bash

   py-chessboardjs-gtk

.. code:: bash

   py-chessboardjs-qt

.. code:: bash

   py-chessboardjs-cef

Related Links
-------------

-  `pywebview <https://pywebview.flowrl.com/>`__
-  `chessboard.js <https://chessboardjs.com/>`__
-  `chess.js <https://github.com/jhlywa/chess.js>`__
-  `Bootstrap <https://getbootstrap.com/>`__
