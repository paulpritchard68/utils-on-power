     H DFTACTGRP(*NO)
      *------------------------------------------------------------------------*
      * Program     : DSPOSRLS                                                 *
      * Description : Display current OS release                               *
      *               Displays the current OS release                          *
      * Written by  : Paul Pritchard                                           *
      * Date        :  5/08/2011                                               *
      *------------------------------------------------------------------------*
      * Program Prototype
     D DspOsRls        PR                  EXTPGM('DSPOSRLS')
     D DspOsRls        PI
     D*
     D* External Prototypes
     D RetrieveProductInformation...
     D                 PR                  EXTPGM('QSZRTVPR')
     D  ReceiverVariable...
     D                              113A
     D  ReceiverVariableLength...
     D                               10i 0
     D  FormatName                    8A
     D  ProductInformation...
     D                               27A
     D  ErrorCode                     8A
     D*
     D* Data Structures
     D ProductInformationDs...
     D                 DS
     D  Information            1     27A
     D  ProductID              1      7A   Inz('*OPSYS')
     D  ReleaseLevel           8     13A   Inz('*CUR')
     D  ProductOption         14     17A   Inz('0000')
     D  LoadID                18     27A   Inz('*CODE')
     D*
     D PRDR0100        DS
     D  Value                  1    113A
     D  Release               20     25A
     D*
     D* Other Fields
     D ValueLength     S             10i 0 Inz(113)
     D ValueFormat     S              8A   Inz('PRDR0100')
     D Error           S              8A
      *------------------------------------------------------------------------*
      /Free

          RetrieveProductInformation(Value: ValueLength: ValueFormat:
                                     Information: Error);
          Dsply Release;

          *INLR=*ON;

      /End-Free
      *------------------------------------------------------------------------*
