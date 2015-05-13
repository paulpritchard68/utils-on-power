# utils-on-power #
A collection of utilities for the IBM i on power


## Display OS Release (DSPOSRLS) ##
A utility to identify what OS release your IBM i is on.

### Compiling DSPOSRLS ###
Use the following commands to compile the source, replacing 'library' with the name of the library into which you copied the source.

CRTBNDRPG PGM(library/DSPOSRLS)

CRTPNLGRP PNLGRP(library/DSPOSRLS) SRCFILE(library/QPNLSRC)

CRTCMD CMD(library/DSPOSRLS) PGM(library/DSPOSRLS) SRCFILE(library/QCMDSRC) SRCMBR(*CMD) HLPPNLGRP(DSPOSRLS) HLPID(*CMD)

### Using DSPOSRLS ###
And you can execute this by typing DSPOSRLS from any command line.


## Display Program Locks (DSPPGMLCK) ##
An IBM i utility to identify which jobs are using a specific program

### Compiling DSPPGMLCK ###
Use the following commands to compile the source, replacing 'library' with the name of the library into which you copied the source.

CRTDSPF FILE(library/DSPPGMLCKD) SRCFILE(library/QDDSSRC)

CRTBNDRPG PGM(library/DSPPGMLCKR)

CRTPNLGRP PNLGRP(library/dsppgmlck) SRCFILE(library/QPNLSRC)

CRTCMD CMD(library/dsppgmlck) PGM(*LIBL/dsppgmlckr) SRCFILE(library/QCMDSRC) SRCMBR(*CMD) HLPPNLGRP(dsppgmlck) HLPID(*CMD)

### Using DSPPGMLCK ###
Type DSPPGMLCK from any command line to list all jobs that have the specified program in their call stack.


## Reorganise Library (RGZLIB) ##
A simple command to reorganise all of the physical file members in a selected library.

### Compiling RGZLIB ###
Use the following commands to compile the source, replacing 'library' with the name of the library into which you copied the source. 

DSPFD File(library/*ALL) Type(*MBR) Output(*OUTFILE) Outfile(QTEMP/RGZLIBF)

CRTBNDCL PGM(library/RGZLIBC) SRCFILE(library/QCLSRC) 

CRTPNLGRP PNLGRP(library/RGZLIB) SRCFILE(library/QPNLSRC)

CRTCMD CMD(library/RGZLIB) PGM(library/RGZLIBC) SRCFILE(library/QCMDSRC) SRCMBR(*CMD) HLPPNLGRP(library/RGZLIB) HLPID(*CMD)

### Using RGZLIB ###
For a large library this command can take a while to complete, so it should be submitted to batch unless you have an insanely good reason to run it interactively. To submit this to batch, type the following where 'library' is, of course, the library you want to reorganise.

SBMJOB CMD(RGZLIB LIBRARY(library)) JOB(RGZLIB)


## Progress ##
A progress bar, because everything is better with a progress bar.

This is quite a simple program that displays a progress bar across the bottom of the screen. You need to provide the current and maximum values so that the program can calculate the percentage complete and the length of the progress bar.


## A Progress bar (PROGRESS) ##
Because everything is better with a progress bar.

This is quite a simple program that displays a progress bar across the bottom of the screen. You need to provide the current and maximum values so that the program can calculate the percentage complete and the length of the progress bar.

Also included is a sample program (SAMPLE.RPGLE) that demonstrates how the progress bar is implemented.

### Compiling PROGRESS ###
Use the following commands to compile the source, replacing 'library' with the name of the library into which you copied the source. 

CRTDSPF FILE(library/PROGRESSD) SRCFILE(library/QDDSSRC)

CRTBNDRPG PGM(library/PROGRESS)

### Compiling the Sample program ###
CRTBNDRPG PGM(library/SAMPLE)

### Using PROGRESS ###
The calling program needs to include display file PROGRESSD in the f-spec and needs to write record X01 immediately before it starts doing whatever processing you want to measure. Then you just need call program PROGRESS with two parameters: current and maximum within whatever loop you you want to use it.
