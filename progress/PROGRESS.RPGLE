     h main(progress)

     fprogressd cf   e             workstn

     dprogress         pr                  extpgm('PROGRESS')
     d current                        9s 0 const
     d maximum                        9s 0 const

     pprogress         b
     dprogress         pi
     d current                        9s 0 const
     d maximum                        9s 0 const
     dlength           s              3s 0
     di                s              3s 0
      /free
          fld001 = *Blanks;

          if current>=maximum;
              length = 75;
              *inlr = *on;
          else;
              length = %int(current*75/maximum);
          endif;

          if length>*Zero;
              for i = 1 to length;
                  %subst(fld001: i: 1)='#';
              endfor;
          endif;
          write W01;
          return;
      /end-free
     pprogress         e
