*-----------------------------------------------------------
* Title      : How to calculate 128 kbs dma boundary
* Written by : George Prescott
* Date       : 28/08/2020
*
* Description: This is a way to check if a dma boundary is
*              going to happen before a dma operation
*              I dont like to use .L instrcuctions because
*              they are slow. But i had not found a way to
*              make this code faster. There are probably
*              faster way to do this. I would suggest
*              to avoid placing bin files that are going to
*              be dmaed away from 128kbs boundaries. That
*              will be a little waste of memory but you will
*              not need to perform this check.
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

        MOVE.L #DATADMA,D0    ;<-Move the pointer to any register
        MOVE.L #DATAEND-DATADMA,D1    ;<-Put the length of the data in any register
        BSR CHECKBOUNDARY     ;<-This will result in a dma boundary
        
        
        MOVE.L #DATADMA2,D0    ;<-Move the pointer to any register
        MOVE.L #DATAEND2-DATADMA2,D1    ;<-Put the length of the data in any register
        BSR CHECKBOUNDARY     ;<-This will result in a no dma boundary


INFLOOP JMP INFLOOP    ;<- Just an infinite loop at the program's end 


CHECKBOUNDARY:
        MOVE.L D0,D2             ;<-Lets calculate last byte pointer on d2
        ADD.L  D1,D2             ;<-Add data length to pointer
        SUBQ.L #1,D2             ;<-Substract 1 to point to the last byte 
        
        MOVE.L  #$FFFE0000,D3    ;<-Mask negative $20000 IS 128KBS
        AND.L D3,D2              ;<-Mask last index
        AND.L D3,D0              ;<-Mask first index
        CMP.L D0,D2              ;<-Compare them
        
        BEQ NOBOUNDARY           ;<-If both are equals there is no dma boundary
        
BOUNDARY
        MOVE.L D2,D0   ;<-PUT IN D0 WHERE 128KBDMA BOUNDARY IS GOING TO HAPPEN
        RTS 
        
        
NOBOUNDARY                    
        MOVEQ.L #0,D0  ;<-IF 0 NO DMA BOUNDARY IS GOING TO HAPPEN. BE HAPPY
        RTS
        
*-----------------------------------------------------------------
*         Sample data for creating a dma boundary example
*-----------------------------------------------------------------
        
          ORG  $1C000  ;<- PLACE DATA AT 98304 
DATADMA:  DS.B $8000   ;<- 49152 bytes that will generate 128kb dma boundary at $20000
DATAEND:

DATADMA2: DS.B $8000   ;<-$8000=32768 bytes. Not in the place to generate a 128kb boundary
DATAEND2:                

* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~10~
