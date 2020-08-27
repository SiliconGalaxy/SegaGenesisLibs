    ORG    $1000
    
EXPT    incbin 'EXPS10000H.bin'
LOGT    incbin 'LOGS8000H.bin'

START:                  

          ;This little example explains how to perform 
          ;an integer division by using logaritmic tables
          ;Instead of using div instruction, by using
          ;logaritmic and exponential tables its possible to
          ;perform the same operation by doing some indexing
          ;By doing this you can divide by using much less
          ;cycles than the standard div.s instruction
          
          ;----> Warning!!!! <----
          ;Dont forget this method has only around 5 bit precision and it wont give a 100% accurate result
          ;It will just provide reasonably accurate results for game development and some 3d geometry.

          LEA LOGT,A0       ;<-Put logaritmic table's pointer into a register
          LEA EXPT,A1       ;<-Same for exponential table
          
          MOVE.W #1322,D0   ;<-Dividend
          MOVE.W #220,D1    ;<-Divisor
          
          MOVE.B (A0,D0.W),D0 ;<-Take dividend's log value
          SUB.B  (A0,D1),D0   ;<-Substract divisor's log value 
          BLT ZERO            ;<- IF LESS THAN QUOTIENT IS 0 (im not sure if this is right)

          AND.w #$ff,D0       ;<-Remove high part of word to make sure its 00 and do not affect our indexing
          ADD.W  D0,D0        ;<-Exponential table is word based so we need to multiply by two
          
          MOVE.W (A1,D0),D2   ;<-Get Cuotient by reading our result's exponential value
          
          ;Remember that usually in graphical operations many values are repeated
          ;If this is your case, remember that you can save any of log values
          ;and perform only 1 table indexing instead of two. wich is even faster.
          ;In example, when trying to divide an X and a Y coordinate by Z to calculate projection
          ;you only need to read Z log once and substract it to X and Y wich will only take about 80 cycles
          ;instead of dividing two times wich will cost about 300 cycles
          
ZERO
          MOVE.W #0,D2


    SIMHALT             ; halt simulator


    END    START        ; last line of source

