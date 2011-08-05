     H DFTACTGRP(*NO)
      *------------------------------------------------------------------------*
      * Program     : DSPOSRLS                                                 *
      * Description : Display current OS release                               *
      * Written by  : Paul Pritchard                                           *
      *                                                                        *
      * DSPOSRLS is free software: you can redistribute it and/or modify it    *
      * under the terms of the GNU General Public License as published by the  *
      * Free Software Foundation, either version 3 of the License, or          *
      * (at your option) any later version.                                    *
      *                                                                        *
      * DSPOSRLS is distributed in the hope that it will be useful, but        *
      * WITHOUT ANY WARRANTY; without even the implied warranty of             *
      * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                   *
      * See the GNU General Public License for more details.                   *
      *                                                                        *
      * You should have received a copy of the GNU General Public License      *
      * along with this program.  If not, see <http://www.gnu.org/licenses/>.  *
      *------------------------------------------------------------------------*
      * Program Prototype
     D DspOsRls        PR                  EXTPGM('DSPOSRLS')
     D DspOsRls        PI
     D*
     D* External Prototypes
     D RetrieveProductInformation...
     D                 PR                  EXTPGM('QSZRTVPR')
     D  ReceiverVariable...
     D                               27A
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
     D  Value                  1     27A
     D  Release               20     25A
     D*
     D* Other Fields
     D ValueLength     S             10i 0 Inz(27)
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
