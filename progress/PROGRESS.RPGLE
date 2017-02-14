     h
      *------------------------------------------------------------------------*
      * Program     : PROGRESS                                                 *
      * Description : Display a progress bar                                   *
      * Written by  : Paul Pritchard                                           *
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
