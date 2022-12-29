Þ    A      $              ,  C   -  X   q     Ê  G   Þ  A   &     h  M     E   Õ  N     1   j          ª     ·  g   È    0  O   4          $	     ;	  d   Å	  e   *
  i  
  5  ú  G   0  b   x     Û      ð  1     à   C  B   $  U   g  R   ½  |             ¥  Ñ   8    
  	     ª     ¡   Â  7   d  (     ¬  Å  d   r  Þ   ×  ¢   ¶  @   Y       0        Ð  Q   Ý  %   /  |   U  d   Ò  h   7  0      >  Ñ  Ô    /   å  T     )  j  ö      &  !  :   ²"    í"  A   n$  d   °$     %  G   )%  A   q%     ³%  g   Ò%  E   :&  N   &  6   Ï&     '     '     !'  b   1'  ,  '  h   Á(  º   *)      å)  ¢   *  m   ©*  ~   +  É  +  8  `.     /  l   0      0  $   ¬0  I   Ñ0     1  O   2     l2  g   ý2  v   e3     Ü3  Ì   ì3  -  ¹4  1  ç5     7  ã    7  Ô   8  L   Ù8  *   &9  ¼  Q9  m   ;  ý   |;  Ò   z<  E   M=     =  N   =     ç=  j   ô=  6   _>     >  d   ?  h   ?  0   ì?  >  @  Ô  \A  /   1C  T   aC  )  ¶C  ö   àD  &  ×E  :   þF   :command:`similarity-ant` is so slow that it is far from practical. :command:`similarity-mcts` now chose Catechin and the mysterious molecule Gnididin [#]_: :file:`gen2-2.csv`: :menuselection:`File --> Fetch Structure by ID --> PDB(mmCIF) --> 7tll` :menuselection:`File --> Open --> ligand.pdbqt --> file type PDB` :menuselection:`Move --> Play` :menuselection:`Presets --> Interactive 1 (ribbons)` with :command:`chimera`. :menuselection:`Tools --> Surface/Binding Analysis --> AutoDock Vina` :menuselection:`Tools --> Surface/Binding Analysis --> ViewDock --> all.pdbqt` After running, you would see something like this: AutoDock Vina Bibliography Chem-Ant Article Convert the relevant part to smiles with :mod:`rdkit`.  The range is from Phe140 to Glu166 in sequence. Create a ligand file with `Open Babel <http://openbabel.org/wiki/Main_Page>`__.  Open :file:`gen3.csv` and specify the smiles of high-scoring molecule with :command:`similarity-mcts`.  Don't forget to add hydrogen atoms and assign partial charges.  On Ubuntu: Create fragments of the target molecule Nirmatrelvir and output some molecules. Display a nucleotide or amino acid sequence alignment with :command:`chimera` from :menuselection:`Tools --> Sequence --> Sequence` and save it in fast format. Execute AutoDock Vina: From the output molecules, select the molecules with good results by docking simulation. Of course, it's a good result among the options. Get the `set difference <https://stackoverflow.com/questions/18180763/set-difference-for-pandas>`__. Hover your cursor over the receptor's active site amino acid on the binding site to see its location. I started writing :mod:`chess-ant` in 2019, but at first I was particular about minimax and the work did not proceed slowly. With the COVID-19 outbreak of the cruise ship Diamond Princess in 2020, when the pandemic was finally beginning to attract attention, I decided to use the :mod:`chess-ant` algorithm for the development of therapeutic agents. After that, I read the paper of MCTS solver and the performance improved. At the same time, I learned how to use the cheminformatics software. Even after the SARS-CoV-2 pandemic has converged, the next pandemic is waiting. Let's contribute to society with our skills. If you cast from a mold, the casting should fit the original mold. That's why I added amino acids and nucleotides to the file :file:`smiles.csv` [#]_. Whether the relationship between the binding site and the ligand in docking simulation can be said to be the same, let's experiment with the following method: If you need the target molecule itself, the above method may be useful. If you want to check the Active site amino acid, right-click on the relevant part of the sequence. Ignore short smiles: In :file:`~/.profile` on Ubuntu: In my case, there are two installation locations: In my case, when I specified the binding site with the mouse, the frame was not displayed unless I switched it with the :guilabel:`Presets` menu. When reconfirming the experimental results, open :file:`all.receptor.pdb` and: Is :command:`similarity-mcts` working properly in the first place? Is it possible to get a high score by docking simulation without the target molecule? Let's go back to UCSF Chimera. Open the above file and follow the menu as follows: Material candidates including the target molecule are selected by :command:`similarity-mcts`, and some molecules are output. Mold for Smiles Casting On my old laptop Fujitsu LIFEBOOK AH42/C, when I try to install `UCSF ChimeraX <https://www.cgl.ucsf.edu/chimerax/>`__, I get the following error: Our :guilabel:`Output file` is :file:`all`. Specify :guilabel:`Receptor` and :guilabel:`Ligand`. Check :guilabel:`Resize search volume using` for your mouse. Write vina path in :guilabel:`Executable location`. Prior to this experiment, get the latest release of the `AutoDock Vina installer from GitHub <https://github.com/ccsb-scripps/AutoDock-Vina>`__ and install it according to the manual.  You can check the location of the binary file with the following command: Reference Reuse the receptor file output by UCSF Chimera and experiment on the command line. You will prepare your own ligand file. The contents of :file:`conf.txt` are as follows: Run :command:`chimera` from the terminal on the command line, or right-click the desktop icon to give execute permission and double-click to launch UCSF Chimera. Run :command:`similarity-mcts` targeting that molecule. Separate MCTS solver as another package. The amino acid interaction described in this paper [#]_ is based on `PDB ID: 6LU7 <https://www.rcsb.org/structure/6lu7>`__, while our experiments are based on the SARS-CoV-2 Mpro Omicron P132H contained in `PDB ID: 7TLL <https://www.rcsb.org/structure/7tll>`__. The first three letters of active site amino acid are abbreviations for amino acids, and the rest represent the positions of sequences. Let's check with UCSF Chimera: The smiles string is so long, let's break it down into fragments and outputs them to some molecules. There are some things to keep in mind when running :command:`similarity-genMols`.  Python doesn't distinguish between single and double quotes, but bash and dash do.  In addition, you don't need commas on the command line: Therefore, in this experiment, I use `UCSF Chimera <https://www.rbvi.ucsf.edu/chimera/>`__. The advantage is that you can specify the binding site with the mouse. To verify the operation, proceed with the experiment as follows: Todo Type bool is output as 1.0 or 0.0 in a csv file. UCSF Chimera Unfortunately, this molecule is made up of fragments produced solely by Gnididin: Unravel the entangled spaghetti code. Version 0.0.3 of :command:`similarity-mcts` now imports MCTS solver, so the output is slightly different from this document. `@cat_lover. æ§é çæã¡ã¢. (2021). <https://qiita.com/cat_lover/items/9540a2d00daba3584a22>`__ `English version of Python for Chemoinformatics (pdf) <https://github.com/joofio/py4chemoinformatics>`__ `GB-GM <https://github.com/jensengroup/GB-GM>`__ `Jensen, J. (2019). Graph-based Genetic Algorithm and Generative Model/Monte Carlo Tree Search for the Exploration of Chemical Space. ChemRxiv. doi:10.26434/chemrxiv.7240751.v2 This content is a preprint and has not been peer-reviewed. <https://chemrxiv.org/engage/chemrxiv/article-details/60c7405af96a000e09286278>`__ `Panikar, S., Shoba, G., Arun, M., Sahayarayan, J. J., Usha Raja Nanthini, A., Chinnathambi, A., Alharbi, S. A., Nasif, O., & Kim, H. J. (2021). Essential oils as an effective alternative for the treatment of COVID-19: Molecular interaction analysis of protease (Mpro) with pharmacokinetics and toxicological properties. Journal of infection and public health, 14(5), 601â610. https://doi.org/10.1016/j.jiph.2020.12.037 <https://pubmed.ncbi.nlm.nih.gov/33848890/>`__ `PubChem <https://pubchem.ncbi.nlm.nih.gov/>`__ `Python for chemoinformatics <https://github.com/Mishima-syk/py4chemoinformatics>`__ `SAMANT, L., & Javle, V. (2020). Comparative Docking Analysis of Rational Drugs Against COVID-19 Main Protease. ChemRxiv. doi:10.26434/chemrxiv.12136002.v1 This content is a preprint and has not been peer-reviewed. <https://chemrxiv.org/engage/chemrxiv/article-details/60c749fd702a9b828b18b20c>`__ `Sharif, Suliman. Understanding drug-likeness filters with RDKit and exploring the WITHDRAWN database. (2020). <https://sharifsuliman1.medium.com/understanding-drug-likeness-filters-with-rdkit-and-exploring-the-withdrawn-database-ebd6b8b2921e>`__ `Sisakht, M., Mahmoodzadeh, A., & Darabian, M. (2021). Plant-derived chemicals as potential inhibitors of SARS-CoV-2 main protease (6LU7), a virtual screening study. Phytotherapy research : PTR, 35(6), 3262â3274. https://doi.org/10.1002/ptr.7041 <https://pubmed.ncbi.nlm.nih.gov/33759279/>`__ `åå­¦ã®æ°ããã«ã¿ã <https://future-chem.com/>`__ Project-Id-Version: Chess-Ant 
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2022-12-29 19:54+0900
PO-Revision-Date: 2022-12-29 20:02+0900
Last-Translator: Akihiro Kuroiwa <akuroiwa@env-reform.com>
Language: ja
Language-Team: Japanese
Plural-Forms: nplurals=1; plural=0;
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.11.0
 :command:`similarity-ant` ã¯éããã¦å®ç¨æ§ã«ç¨é ãã :command:`similarity-mcts` ã¯ä»åã¯ Catechin ã¨è¬ãããåå­ Gnididin [#]_ ãé¸ãã ï¼ :file:`gen2-2.csv`: :menuselection:`File --> Fetch Structure by ID --> PDB(mmCIF) --> 7tll` :menuselection:`File --> Open --> ligand.pdbqt --> file type PDB` :menuselection:`Move --> Play` :menuselection:`Presets --> Interactive 1 (ribbons)` ã¨ :command:`chimera` ã®ã¡ãã¥ã¼ã§è¾¿ãã :menuselection:`Tools --> Surface/Binding Analysis --> AutoDock Vina` :menuselection:`Tools --> Surface/Binding Analysis --> ViewDock --> all.pdbqt` å®è¡å¾ãæ¬¡ã®ããã«è¡¨ç¤ºãããã ããï¼ AutoDock Vina åèæç® Chem-Ant è«æ è©²å½ç®æã :mod:`rdkit` ã§ smiles ã«å¤æãããç¯å²ã¯ Phe140 ãã Glu166 è¿ã ã Ligand file ã `Open Babel <http://openbabel.org/wiki/Main_Page>`__ ã§ä½æããã:file:`gen3.csv` ãéãã :command:`similarity-mcts` ã§å¾ãé«å¾ç¹ã®åå­ã®smilesãæå®ããããæ°´ç´ åå­ãä»å ããé¨åé»è·ãå²ãå½ã¦ãã®ãå¿ããªãããã«ãUbuntuã§ï¼ ã¿ã¼ã²ããåå­ Nirmatrelvir ã®ã¿ããã©ã°ã¡ã³ãã«ããåå­ãå¹¾ã¤ãåºåããã :command:`chimera` ã§ :menuselection:`Tools --> Sequence --> Sequence` ãè¾¿ãããã¯ã¬ãªãããã¢ããé¸ã® sequence alignment ãè¡¨ç¤ºãã fast format ã§ä¿å­ããã AutoDock Vina ãå®è¡ããï¼ åºåãããåå­ãããããã­ã³ã°ã»ã·ãã¥ã¬ã¼ã·ã§ã³ã§å¥½æç¸¾ã¨ãªã£ãåå­ãé¸ã¶ãå¿è«ãé¸æè¢ã®ä¸­ã§ã®å¥½æç¸¾ã ãã ä¸¡èã® `å·®éåã <https://stackoverflow.com/questions/18180763/set-difference-for-pandas>`__ å¾ãã ã«ã¼ã½ã«ã binding site ä¸ã® receptor ã® active site amino acid ã«åãããã¨ããã®ä½ç½®ãè¡¨ç¤ºãããã 2019å¹´ã« :mod:`chess-ant` ãæ¸ãå§ããã®ã ããæåã¯ minimax ã«ãã ãããéãã¨ãã¦ä½æ¥­ã¯é²ã¾ãªãã£ãã2020å¹´ã«ã¯ã«ã¼ãºè¹ãã¤ã¤ã¢ã³ãã»ããªã³ã»ã¹å·ã® COVID-19 éå£ææãããããããããã³ãããã¯ãæ³¨ç®ããå§ããé ã :mod:`chess-ant` ã®ã¢ã«ã´ãªãºã ãæ²»çè¬ã®éçºã«å½¹ç«ã¦ããã¨æãç«ã£ãããã®å¾ã MCTS solver ã®è«æãèª­ã¿ãæ§è½ãåä¸ãããåæã« cheminformatics ã®ã½ããã¦ã§ã¢ã®ä½¿ãæ¹ãèº«ã«ã¤ãã¦ãã£ããSARS-CoV-2 ã®ãã³ãããã¯ãåæããå¾ããæ¬¡ãªããã³ãããã¯ãå¾ã¡æ§ãã¦ãããæãã®æè½ã§ç¤¾ä¼ã«è²¢ç®ãããã é³åããé³ç©ãé³é ããã°ãåã®é³åã«åãã¯ãã ãç§ã :file:`smiles.csv` [#]_ ã«ã¢ããé¸ã¨ãã¯ã¬ãªãããè¿½å ããçç±ã§ããããDocking simulation ã«ããã binding site ã¨ ligand ã®é¢ä¿ãåæ§ã ã¨è¨ãããã©ãããä»¥ä¸ã®æ¹æ³ã§å®é¨ããï¼ é¡ä¼¼æ§ã®ç®æ¨ã¨ãªãã¿ã¼ã²ããåå­ãã®ãã®ãå¿è¦ãªå ´åã¯ãä¸è¨ã®æ¹æ³ãå½¹ç«ã¤ããç¥ããªãã æ´»æ§é¨ä½ã®ã¢ããé¸ãç¢ºèªããããªãã°ãéåä¸ã®ãã®å ´æã§å³ã¯ãªãã¯ããã ç­ã smiles ã¯ç¡è¦ããï¼ Ubuntu ã® :file:`~/.profile` ã§ï¼ ç§ã®å ´åãã¤ã³ã¹ãã¼ã«ããå ´æã¯2ç®æã«åãããï¼ ç§ã®å ´åã binding site ããã¦ã¹ã§æå®ããã¨ã :guilabel:`Presets` ã¡ãã¥ã¼ã§åãæ¿ããã¾ã§æ ãè¡¨ç¤ºãããªããå®é¨çµæãå¾ç¨ãåç¢ºèªããããã° :file:`all.receptor.pdb` ãéããæ¬¡ã®ããã«ããï¼ ãããã :command:`similarity-mcts` ã¯æ­£ããåä½ãã¦ããã®ãï¼ ã¿ã¼ã²ããåå­ãç¡ãã¨ãããã­ã³ã°ã»ã·ãã¥ã¬ã¼ã·ã§ã³ã§é«å¾ç¹ãåããã·ãã¥ã¬ã¼ã·ã§ã³ã¯åºæ¥ããï¼ UCSF Chimera ã«æ»ãããä¸è¨ã®ãã¡ã¤ã«ãéããä»¥ä¸ã®ããã«ã¡ãã¥ã¼ãè¾¿ãï¼ ã¿ã¼ã²ããåå­ãå«ãææåè£ã :command:`similarity-mcts` ã§é¸ã³ãåå­ãå¹¾ã¤ãåºåããã é³åã¨é³ç© ç§ã®å¤ãã©ããããã Fujitsu LIFEBOOK AH42/C ã« `UCSF ChimeraX <https://www.cgl.ucsf.edu/chimerax/>`__ ãã¤ã³ã¹ãã¼ã«ãããã¨ããããæ¬¡ã®ãããªã¨ã©ã¼ãè¡¨ç¤ºãããï¼ æãã® :guilabel:`Output file` ã¯ :file:`all` ã ã:guilabel:`Receptor` ã¨ :guilabel:`Ligand` ãæå®ãããã:guilabel:`Resize search volume using` ããã¦ã¹æä½ã®çºã«ãã§ãã¯ãããä¸è¨ã®ã³ãã³ãã§å¾ã vina ã®ãã¹ã :guilabel:`Executable location` ã«æ¸ãã å®é¨ã«åç«ã¡ãææ°ãªãªã¼ã¹ã® `AutoDock Vina installer from GitHub <https://github.com/ccsb-scripps/AutoDock-Vina>`__ ãå¥æããããã¥ã¢ã«ã«æ²¿ãã¤ã³ã¹ãã¼ã«ããããã¤ããªã¼ãã¡ã¤ã«ï¼å®è¡ãã¡ã¤ã«ï¼ã®å¨ãå¦ã¯ãæ¬¡ã®ã³ãã³ãã§ç¢ºèªã§ããï¼ åç§ UCSF Chimera ã«ããåºåããã receptor file ãåå©ç¨ããã³ãã³ãã©ã¤ã³ã§ããªããç¬èªã«ä½æãã ligand file ãå®é¨ãããã ãããè¨­å®ãã¡ã¤ã« :file:`conf.txt` ãç¨æãããï¼ ã¿ã¼ããã«ãéãã¦ã³ãã³ãã©ã¤ã³ã§ :command:`chimera` ãå®è¡ãããããã¹ã¯ãããã«åºæ¥ãã¢ã¤ã³ã³ãå³ã¯ãªãã¯ããå®è¡æ¨©éãä¸ããããã«ã¯ãªãã¯ããã ãã®åå­ãã¿ã¼ã²ããã« :command:`similarity-mcts` ãåããã MCTS solver ãå¥ããã±ã¼ã¸ã«ãã åç§ããè«æã«æ¸ããã¦ããã¢ããé¸ç¸äºä½ç¨ã¯ [#]_ `PDB ID: 6LU7 <https://www.rcsb.org/structure/6lu7>`__ ã«åºã¥ããä¸æ¹ãæãã®å®é¨ã¯ the SARS-CoV-2 Mpro Omicron P132H ã«åºã¥ãã¦ããã `PDB ID: 7TLL <https://www.rcsb.org/structure/7tll>`__ ãä½¿ç¨ãããActive site amino acid ã®åé ­3æå­ã¯ã¢ããé¸ã®ç¥å·ã§ãæ®ãã¯éåä¸ã®ä½ç½®ãç¤ºããUCSF Chimera ã§ç¢ºèªãããï¼ ãã® smiles æå­åã¯é·éããã®ã§ã fragments ã«åè§£ããå¹¾ã¤ãã®åå­ã«åºåããã `similarity-genMols` ãå®è¡ããéã«æ°ãã¤ãããã¨ããããPython ã§ã¯ã·ã³ã°ã«ã¯ã©ã¼ãã¨ããã«ã¯ã©ã¼ããåºå¥ããªããã bash ã dash ã§ã¯åºå¥ãããæ´ã«ãã³ãã³ãã©ã¤ã³ã§ã«ã³ãã¯ä¸è¦ã ï¼ å¾ã£ã¦ããã®å®é¨ã§ã¯ã `UCSF Chimera <https://www.rbvi.ucsf.edu/chimera/>`__ ãç¨ããããã®å©ç¹ã¯ã binding site ã¨å¼ã°ããçµåé¨ä½ããã¦ã¹ã§æå®ã§ãããã¨ã«ããã åä½æ¤è¨¼ãããããã«ãæ¬¡ã®ããã«å®é¨ãé²ããï¼ Todo Type bool ã 1.0 ã 0.0 ã®ããã« csv file ã«åºåããã¦ãã¾ãã UCSF Chimera æ®å¿µãªããããã®åå­ã¯ Gnididin ã®ã¿ã§çæããããã©ã°ã¡ã³ãã«ããåºæ¥ãã çµ¡ã¿åã£ãã¹ãã²ããã£ã³ã¼ããè§£ãã Version 0.0.3 ã® :command:`similarity-mcts` ã¯ MCTS solverãã¤ã³ãã¼ãããã®ã§ããã®ææ¸ã¨åºåãè¥å¹²ç°ãªãã `@cat_lover. æ§é çæã¡ã¢. (2021). <https://qiita.com/cat_lover/items/9540a2d00daba3584a22>`__ `English version of Python for Chemoinformatics (pdf) <https://github.com/joofio/py4chemoinformatics>`__ `GB-GM <https://github.com/jensengroup/GB-GM>`__ `Jensen, J. (2019). Graph-based Genetic Algorithm and Generative Model/Monte Carlo Tree Search for the Exploration of Chemical Space. ChemRxiv. doi:10.26434/chemrxiv.7240751.v2 This content is a preprint and has not been peer-reviewed. <https://chemrxiv.org/engage/chemrxiv/article-details/60c7405af96a000e09286278>`__ `Panikar, S., Shoba, G., Arun, M., Sahayarayan, J. J., Usha Raja Nanthini, A., Chinnathambi, A., Alharbi, S. A., Nasif, O., & Kim, H. J. (2021). Essential oils as an effective alternative for the treatment of COVID-19: Molecular interaction analysis of protease (Mpro) with pharmacokinetics and toxicological properties. Journal of infection and public health, 14(5), 601â610. https://doi.org/10.1016/j.jiph.2020.12.037 <https://pubmed.ncbi.nlm.nih.gov/33848890/>`__ `PubChem <https://pubchem.ncbi.nlm.nih.gov/>`__ `Python for chemoinformatics <https://github.com/Mishima-syk/py4chemoinformatics>`__ `SAMANT, L., & Javle, V. (2020). Comparative Docking Analysis of Rational Drugs Against COVID-19 Main Protease. ChemRxiv. doi:10.26434/chemrxiv.12136002.v1 This content is a preprint and has not been peer-reviewed. <https://chemrxiv.org/engage/chemrxiv/article-details/60c749fd702a9b828b18b20c>`__ `Sharif, Suliman. Understanding drug-likeness filters with RDKit and exploring the WITHDRAWN database. (2020). <https://sharifsuliman1.medium.com/understanding-drug-likeness-filters-with-rdkit-and-exploring-the-withdrawn-database-ebd6b8b2921e>`__ `Sisakht, M., Mahmoodzadeh, A., & Darabian, M. (2021). Plant-derived chemicals as potential inhibitors of SARS-CoV-2 main protease (6LU7), a virtual screening study. Phytotherapy research : PTR, 35(6), 3262â3274. https://doi.org/10.1002/ptr.7041 <https://pubmed.ncbi.nlm.nih.gov/33759279/>`__ `åå­¦ã®æ°ããã«ã¿ã <https://future-chem.com/>`__ 