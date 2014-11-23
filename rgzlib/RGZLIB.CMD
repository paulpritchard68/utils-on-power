/*----------------------------------------------------------------------------*/
/* Command     : RGZLIB                                                       */
/* Description : Reorganise library                                           */
/*               Reorganises all physical files in a library                  */
/* Written By  : Paul Pritchard                                               */
/* Date        : 19/12/2011                                                   */
/*----------------------------------------------------------------------------*/
cmd prompt('Reorganise Library')

Parm Kwd(LIBRARY) Type(*CHAR) Len(10) Min(1) Max(1) Prompt('Library')
