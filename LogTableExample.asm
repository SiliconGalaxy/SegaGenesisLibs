    ORG    $1000
    
EXPT    incbin 'EXPS10000H.bin'
LOGT    incbin 'LOGS8000H.bin'

START:                  ; How to use logaritmic tables

          LEA LOGT,A0
          LEA EXPT,A1
          
          MOVE.W #1322,D0   <-Dividend
          MOVE.W #220,D1    <-Divisor
          
          MOVE.B (A0,D0.W),D0 <- We get the logs for each value
          SUB.B  (A0,D1),D0
          BLT ZERO           <- IF LESS THAN QUOTIENT IS 0 (im not sure if this is right)

          AND.w #$ff,D0
          ADD.W  D0,D0
          MOVE.W (A1,D0),D2 <-Get Cuotient
          
ZERO
          MOVE.W #0,D2


    SIMHALT             ; halt simulator


    END    START        ; last line of source

