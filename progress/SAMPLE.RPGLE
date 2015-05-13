     h
      *------------------------------------------------------------------------*
      * Program     : SAMPLE                                                   *
      * Description : This is a sample program that uses PROGRESS to display a *
      *               simple progress bar. It is provided as an example of how *
      *               progress should be implemented.                          *   
      * Written by  : Paul Pritchard                                           *
      *                                                                        *
      * DSPPGMLCK is free software: you can redistribute it and/or modify it   *
      * under the terms of the GNU General Public License as published by the  *
      * Free Software Foundation, either version 3 of the License, or          *
      * (at your option) any later version.                                    *
      *                                                                        *
      * DSPPGMLCK is distributed in the hope that it will be useful, but       *
      * WITHOUT ANY WARRANTY; without even the implied warranty of             *
      * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                   *
      * See the GNU General Public License for more details.                   *
      *                                                                        *
      * You should have received a copy of the GNU General Public License      *
      * along with this program.  If not, see <http://www.gnu.org/licenses/>.  *
      *------------------------------------------------------------------------*
     fprogressd cf   e             workstn
      *------------------------------------------------------------------------*
      * Program Prototype
     dprogress         pr                  extpgm('PROGRESS')
     d current                        9s 0 const
     d maximum                        9s 0 const
     
      * Other fields
     d idx             s              3s 0
      /free

          write x01;
          for idx = 1 to 100;
              progress(idx: 100);
          endfor;

          *inlr=*on;

      /end-free
      *------------------------------------------------------------------------*
