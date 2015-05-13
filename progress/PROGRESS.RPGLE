     h
      *------------------------------------------------------------------------*
      * Program     : PROGRESS                                                 *
      * Description : Display a progress bar                                   *
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
     dprogress         pr                  extpgm('progress')
     d current                        9s 0 const
     d maximum                        9s 0 const
     dprogress         pi
     d current                        9s 0 const
     d maximum                        9s 0 const
     
      * Other fields
     dlength           s              3s 0
     di                s              3s 0
      /free
          progbar = *Blanks;

          if current>=maximum;
              length = 75;
              *inlr = *on;
          else;
              length = %int(current*75/maximum);
          endif;

          if length>*Zero;
              for i = 1 to length;
                  %subst(progbar: i: 1)='#';
              endfor;
          endif;

          write W01;
          return;

      /end-free
      *------------------------------------------------------------------------*
