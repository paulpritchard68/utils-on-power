      *------------------------------------------------------------------------*
      * Program     : DSPOSRLS                                                 *
      * Description : Display Current OS Release                               *
      *               Displays the current OS release                          *
      * Written By  : Paul Pritchard                                           *
      * Date        :  5/08/2011                                               *
      *------------------------------------------------------------------------*
     h main(DSPOSRLS)
     h dftactgrp(*no) actgrp(*new)

      * Program Prototype
     D DspOsRls        PR                  EXTPGM('DSPOSRLS')
     D*
     D* External Prototypes
     D RetrieveProductInformation...
     D                 PR                  EXTPGM('QSZRTVPR')
     D  ReceiverVariable...
     D                              113A
     D  ReceiverVariableLength...
     D                               10I 0
     D  FormatName                    8A
     D  ProductInformation...
     D                               27A
     D  ErrorCode                     8A
     D*
     D DisplayLongText...
     D                 PR                  EXTPGM('QUILNGTX')
     D  TextString                    6A   CONST
     D  TextStringLngth...
     D                               10I 0 CONST
     D  MessageID                     7A   CONST
     D  MessageFileName...
     D                               20A   CONST
     D  ErrorCode                     8A
     D*
     D* Data Structures
     D ProductInformationDS...
     D                 DS
     D  Information            1     27A
     D  ProductID              1      7A   INZ('*OPSYS')
     D  ReleaseLevel           8     13A   INZ('*CUR')
     D  ProductOption         14     17A   INZ('0000')
     D  LoadID                18     27A   INZ('*CODE')
     D*
     D PRDR0100        DS
     D  Value                  1    113A
     D  Release               20     25A
     D*
     D* Other Fields
     D ValueLength     S             10I 0 INZ(113)
     D ValueFormat     S              8A   INZ('PRDR0100')
     D Error           S              8A
     D MessageID       S              7A   INZ('')
     D MessageFileName...
     D                 S             20A   INZ('')
      *------------------------------------------------------------------------*
     P DspOsRls        B
     D DspOsRls        PI
      /free

          RetrieveProductInformation(Value: ValueLength: ValueFormat:
                                     Information: Error);
          DisplayLongText(Release: %LEN(Release):
                          MessageID: MessageFileName: Error);

          *INLR=*ON;

      /end-free
     P DspOsRls        E
      *------------------------------------------------------------------------*
