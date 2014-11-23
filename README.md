utils-on-power
==============
A collection of utilities for the IBM i on power

Display OS Release (DSPOSRLS)
-----------------------------
A utility to identify what OS release your IBM i is on.

Use the following commands to compile the source, replacing 'library' with the name of the library into which you copied the source.

CRTBNDRPG PGM(library/DSPOSRLS)

CRTPNLGRP PNLGRP(library/DSPOSRLS) SRCFILE(library/QPNLSRC)

CRTCMD CMD(library/DSPOSRLS) PGM(library/DSPOSRLS) SRCFILE(library/QCMDSRC) SRCMBR(*CMD) HLPPNLGRP(DSPOSRLS) HLPID(*CMD)

And you can execute this by typing DSPOSRLS from any command line.
