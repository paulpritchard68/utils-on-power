     H DFTACTGRP(*NO)
      *------------------------------------------------------------------------*
      * Program     : DSPPGMLCK                                                *
      * Description : Display program locks                                    *
      *               Lists all jobs with a selected program in their call     *
      *               stack                                                    *
      * Written by  : Paul Pritchard                                           *
      *------------------------------------------------------------------------*
     FDSPPGMLCKDCF   E             WORKSTN sfile(DSPPGMLCKS:RRN1)
      *------------------------------------------------------------------------*
      * Program Prototype
     D DspPgmLck       PR                  EXTPGM('DSPPGMLCKR')
     D  ProgramName                  10A
     D DspPgmLck       PI
     D  ProgramName                  10A
     D*
     D* Internal Prototypes
     D BuildJobList    PR
     D*
     D DisplayJobList  PR
     D*
     D* External Prototypes
     D CreateUserSpace...
     D                 PR                  EXTPGM('QUSCRTUS')
     D  QualifiedUserSpace...
     D                               20A
     D  ExtendedAttribute...
     D                               10A
     D  InitialSize                  10i 0
     D  InitialValue                  1A
     D  PublicAuthority...
     D                               10A
     D  Description                  50A
     D*
     D DeleteUserSpace...
     D                 PR                  EXTPGM('QUSDLTUS')
     D  UserSpace                    10A
     D  ErrorCode                     8A
     D*
     D ListJobs        PR                  EXTPGM('QUSLJOB')
     D  QualifiedUserSpace...
     D                               20A
     D  FormatName                    8A
     D  QualifiedJobName...
     D                               26A
     D  Status                       10A
     D*
     D RetrieveUserSpaceMeta...
     D                 PR                  EXTPGM('QUSRTVUS')
     D  QualifiedUserSpace...
     D                               20A
     D  StartingPosition...
     D                               10i 0
     D  LengthOfData                 10i 0
     D  ReceiverVariable...
     D                               10i 0
     D*
     D RetrieveUserSpace...
     D                 PR                  EXTPGM('QUSRTVUS')
     D  QualifiedUserSpace...
     D                               20A
     D  StartingPosition...
     D                               10i 0
     D  LengthOfData                 10i 0
     D  ReceiverVariable...
     D                               56A
     D*
     D RetrieveJobInformation...
     D                 PR                  EXTPGM('QUSRJOBI')
     D  ReceiverVariable...
     D                               86A
     D  LengthOfData                 10i 0
     D  FormatName                    8A
     D  QualifiedJobName...
     D                               26A
     D  InternalJobIdentifier...
     D                               16A
     D*
     D RetrieveCallStack...
     D                 PR                  EXTPGM('QWVRCSTK')
     D  ReceiverVariable...
     D                            32767A
     D  LengthOfdata                 10i 0 CONST
     D  FormatName                    8A   CONST
     D  JobIdentificationInfo...
     D                               56A
     D  JobIdentificationFormat...
     D                                8A   CONST
     D  ErrorCode                 32767A   OPTIONS(*VARSIZE)
     D*
     D* Global Variables
     D ProgramLocks    DS                  OCCURS(45)
     D  LockingSession...
     D                         1     10A
     D  LockingUser...
     D                        11     20A
      *------------------------------------------------------------------------*
      /Free

          BuildJobList();
          DisplayJobList();

          // And exit
          *INLR=*ON;

      /End-free
      *------------------------------------------------------------------------*
      * Procedure: Build Job List                                              *
      *------------------------------------------------------------------------*
     P BuildJobList    B
     D BuildJobList    PI
     D*
     D* API Fields
     D JobUserSpace    S             20A
     D ErrorCode       S              8A
     D UserSpaceAtt    S             10A
     D UserSpaceSize   S             10i 0
     D UserSpaceValue  S              1A
     D UserSpaceAuth   S             10A
     D UserSpaceText   S             50A
     D JobFormat       S              8A
     D JobName         S             26A
     D JobStatus       S             10A
     D SpaceStart      S             10i 0
     D SpaceLength     S             10i 0
     D JobCount        S             10i 0
     D EntryLength     S             10i 0
     D EntryOffset     S             10i 0
     D JobListEntry    S             56A
     D InfoData        S             86A
     D InfoLength      S             10i 0
     D InfoIdentifier  S             16A
     D StackData       S          32767A
     D StackLength     S             10i 0
     D StackFormat     S              8A
     D StackIdInfo     S             56A
     D StackIdFormat   S              8A
     D StackError      S          32767A
      *
      * Other Fields
     D i               S             10i 0
     D j               S             10i 0
     D k               S             10i 0
     D*
     D Jobdata         DS
     D  JobSession             1     10
     D  JobUser               11     20
     D  JobNumber             21     26
     D  JobType               53     53
     D*
     D InfoDataDS      DS
     D  InfoJobName            9     18
     D  InfoUsername          19     28
     D  InfoJobNumber         29     34
      *
     D StackIdInfoDS   DS
     D  StackJobName           1     10A
     D  StackUsername         11     20A
     D  StackJobNumber...
     D                        21     26A
     D  StackInternalId...
     D                        27     42A
     D  StackReserved         43     44A   INZ(*Allx'00')
     D  StackThreadIndicator...
     D                        45     48i 0 INZ(2)
     D  StackThreadIdentifier...
     D                        49     56A   INZ(*Allx'00')
     D*
     D ApiErrorDS      DS
     D  ApiBytes                     10i 0 inz(%size(ApiErrorDS))
     D  ApiBytesAvail                10i 0 inz(0)
     D  ApiMessage                    7A
     D  ApiReserved                   1A
     D  ApiMessageData...
     D                             1000A
     D*
     D StackDataDS     DS
     D  StackDataEntries...
     D                         9     12i 0
     D  StackDataOffset...
     D                        13     16i 0
     D  StackDataEntriesReturned...
     D                        17     20i 0
     D  StackDataEntryList...
     D                        33  32767A
     D*
     D StackEntryDS    DS                  BASED(pStackEntryDS)
     D  StackEntryLength...
     D                               10i 0
     D  StackEntryDisplacement...
     D                               10i 0
     D  StackEntryStatements...
     D                               10i 0
     D  StackEntryProcedureDisplacement...
     D                               10i 0
     D  StackEntryProcedureNameLength...
     D                               10i 0
     D  StackEntryRequestLevel...
     D                               10i 0
     D  StackEntryProgram...
     D                               10A
     D  StackEntryLibrary...
     D                               10A
      /Free

          // Generate a name for the user space
          InfoLength=X'00000086';
          JobFormat='JOBI0100';
          Jobname='*';
          RetrieveJobInformation (Infodata : InfoLength : JobFormat :
                                  JobName : InfoIdentifier);
          InfoDataDS=InfoData;
          JobUserSpace=%subst(InfoJobName: 1: 4) + InfoJobNumber + 'QTEMP';

          // Delete the user space if it already exists, then recreate
          DeleteUserSpace (JobUserSpace : ErrorCode);
          UserSpaceAtt='CONTROL';
          UserSpaceSize=X'00000100';
          UserSpaceValue=' ';
          UserSpaceAuth='*ALL ';
          UserSpaceText='DSPPGMLCK TEMPORARY USER SPACE';
          CreateUserSpace (JobUserSpace : UserSpaceAtt : UserSpaceSize :
                           UserSpaceValue : UserSpaceAuth : UserSpaceText);

          // List all currently active jobs
          JobFormat='JOBL0100';
          JobName='*ALL      ' + '*ALL      ' + '*ALL';
          JobStatus='*ACTIVE';
          ListJobs (JobUserSpace : JobFormat : JobName : JobStatus);

          // Retrieve number on entries returned
          // If not zero, loop and process
          SpaceStart=X'00000085';
          SpaceLength=X'00000004';
          RetrieveUserSpaceMeta (JobUserSpace : SpaceStart : SpaceLength :
                                 JobCount);

          if JobCount>0;
             // Retrieve list entry length and offset
             SpaceStart=X'00000089';
             SpaceLength=X'00000004';
             RetrieveUserSpaceMeta (JobUserSpace : SpaceStart :
                                    SpaceLength : EntryLength);
             SpaceStart=X'0000007D';
             SpaceLength=X'00000004';
             RetrieveUserSpaceMeta (JobUserSpace : SpaceStart :
                                    SpaceLength : EntryOffset);
             EntryOffset=EntryOffset + 1;

             // Loop through the found jobs
             for i = 1 to JobCount;
                RetrieveUserSpace (JobUserSpace : EntryOffset :
                                   EntryLength : JobListEntry);
                JobData=JobListEntry;

                // We only care about batch and interactive jobs
                if Jobtype='I' or Jobtype='B';

                   // This is where the processing will happen
                   StackLength=%size(StackData);
                   StackFormat='CSTK0100';
                   StackJobName=JobSession;
                   StackUsername=JobUser;
                   StackJobNumber=JobNumber;
                   StackIdInfo=StackIdInfoDS;
                   StackIdFormat='JIDF0100';
                   RetrieveCallStack (StackData : StackLength : StackFormat :
                                      StackIdInfo : StackIdFormat : ApiErrorDS);

                   // Parse the call stack
                   StackDataDS=StackData;
                   pStackEntryDS=%Addr(StackData) + StackDataOffset;

                   if StackDataEntriesReturned > 0;
                      For j = 1 to StackDataEntriesReturned;
                         if StackEntryProgram=ProgramName;
                            k=%occur(ProgramLocks);
                            LockingUser=JobUser;
                            LockingSession=JobSession;
                            %occur(ProgramLocks) = k + 1;
                            leave;
                         endif;
                         pStackEntryDS=PStackEntryDS + StackEntryLength;
                      endfor;
                   endif;

                endif;

                // Point to next entry
                EntryOffset=EntryOffset + EntryLength;

             endfor;
          endif;

          // Delete the user space
          DeleteUserSpace (JobUserSpace : ErrorCode);

      /End-Free
     P                 E
      *------------------------------------------------------------------------*
      * Procedure: Display Job List                                            *
      *------------------------------------------------------------------------*
     P DisplayJobList  B
     D DisplayJobList  PI
     D*
     D k               S             10i 0
     D*
      * Screen indicators
     D IndicatorPtr    S               *   INZ(%ADDR(*IN))
     D                 DS                  BASED(IndicatorPtr)
     D iExit                   3      3
     D iCancel                12     12
     D iValidCmdKey           25     25
     D iPageDown              26     26
     D iError                 30     30
     D iSflInit               80     80
     D iSflEnd                81     81
     D iSflEmpty              82     82
      /Free

          // Initialise subfile
          CTLPROGRAM=ProgramName;
          iSflInit=*ON;
          write DSPPGMLCKC;
          iSflInit=*OFF;
          %occur(ProgramLocks)=1;
          RRN1=0;

          // Populate subfile
          dow LockingUser<>*BLANKS;
             RRN1=RRN1+1;
             k=%occur(ProgramLocks);
             SFLJOB=LockingSession;
             SFLUSER=LockingUser;
             write DSPPGMLCKS;
             k=k+1;
             %occur(ProgramLocks)=k;
          enddo;
          iSflEnd=*ON;

          // Display Subfile
          if RRN1=*ZERO;
             iSflEmpty=*ON;
          else;
             iSflEmpty=*OFF;
          endif;

          write DSPPGMLCKT;

          dou iExit=*ON or iCancel=*ON;
             exfmt DSPPGMLCKC;
          enddo;

      /End-Free
     P                 E
      *------------------------------------------------------------------------*
