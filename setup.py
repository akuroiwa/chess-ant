# -*- coding: utf-8 -*-

import glob
from setuptools import setup, find_packages

setup(
    name='chess_ant',
    version='0.1.0',
    url='https://github.com/akuroiwa/chess-ant',
    # # PyPI url
    # download_url='',
    license='GNU/GPLv3+',
    author='Akihiro Kuroiwa, ChatGPT of OpenAI',
    author_email='akuroiwa@env-reform.com, ',
    description='Simulator to solve chess problems with MCTS Solver and Genetic Programming.',
    # long_description="\n%s" % open('README.md').read(),
    long_description=open("README.md", "r").read(),
    long_description_content_type='text/markdown',
    zip_safe=False,
    python_requires=">=3.7, !=3.10.*",
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Intended Audience :: Education',
        'Operating System :: OS Independent',
        'License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)',
        'Programming Language :: Python :: 3 :: Only',
        'Topic :: Scientific/Engineering',
        'Topic :: Software Development',
        'Topic :: Games/Entertainment :: Board Games',
        'Topic :: Software Development :: Libraries :: Python Modules'
    ],
    platforms='any',
    keywords=['evolutionary algorithms', 'genetic programming', 'gp', 'chess', 'fen', 'pgn'],
    packages=find_packages(),
    # py_modules=['chess_ant.chess_ant', 'chess_ant.chess_mcts'],
    include_package_data=True,
    install_requires=['chess', 'mcts', 'deap', 'mcts-solver', 'scipy', 'pandas'],
    extras_require={
        "classification": ["transformers", "chess_classification"]},
    entry_points={
        'console_scripts': [
            'chess-ant = chess_ant.chess_ant:console_script',
            'chess-mcts = chess_ant.chess_mcts:console_script'
            ]},
    # data_files=[
    #     ('', glob.glob('*.pgn'))
    #     ],
)
