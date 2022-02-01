  ;Hi, nice to meet you, and welcome.
  ;My name is George Prescott 
  ;Because i like cool retro videogames i just made this code for helping the retro videogame developing comunity.
  ;This is my best effort doing a fast division for z80 processor.
  ;I just want people to know that even sometimes software is free, it needs a lot of work and effort of many people to be made.
  ;It took a long time to develop a solution like this. So if you find this code usefull i'll be glad and happy if you thank it to me.
  ;If you use my tables or copy my code credits would be greatly appreciated but not required. Feel free to use this code.
  
  ;Tables may be used by any other 8 bit processor but you will need to write the code for another cpu like 6502
  ;Remember that it can only divide when Divisor is lower than Dividend
  ;And remember that this code cant divide numbers bigger than 8 bit
  ;If you replace the sub instruction by an add the routine will multiply instead of divide.
  ;In case you change that instruction remember that multiply will overflow over 255.
  
    ;So here you have it.
    ;->Epic division routine<-
    LD	L,56      ;<-Dividend   ;This are just test values
    LD	B,4       ;<-Divisor    ;

    LD	H,ILT     ;ILT Hackery indexing table
    LD	A,(HL)    ;Get B data from that index
    LD	L,B       ;OFFSET HL CHANGING L VALUE BY B
    SUB	(HL)      ;SUBSTRACT INDEXED VALUE! 	
    LD	L,A       ;OFFSET HL CHANGING L VALUE BY A
    INC	H         ;INCREMENT H BY 1 TO POINT TO THE NEXT TABLE
    LD	B,(HL)    ;B HAS THE QUOTIENT. MATHEMATICAL PROPERTIES AND TABLES INDEX DO THE MAGIC.

    org 1A00      ;<-This address must be 256 multiple
ILT ;<-Magical indexing table
    db 0,0,32,51,64,74,82,90,96,101,106,110,114,118,121,125
    db 128,130,133,135,138,140,142,144,146,148,150,152,153,155,157,158
    db 159,161,162,164,165,166,167,169,170,171,172,173,174,175,176,177
    db 178,179,180,181,182,183,184,184,185,186,187,188,188,189,190,191
    db 191,192,193,193,194,195,196,196,197,197,198,199,199,200,200,201
    db 202,202,203,203,204,204,205,206,206,207,207,208,208,209,209,210
    db 210,211,211,211,212,212,213,213,214,214,215,215,215,216,216,217
    db 217,218,218,218,219,219,220,220,220,221,221,221,222,222,223,223
    db 223,224,224,224,225,225,225,226,226,226,227,227,227,228,228,228
    db 229,229,229,230,230,230,231,231,231,231,232,232,232,233,233,233
    db 234,234,234,234,235,235,235,236,236,236,236,237,237,237,237,238
    db 238,238,238,239,239,239,239,240,240,240,240,241,241,241,241,242
    db 242,242,242,243,243,243,243,244,244,244,244,245,245,245,245,245
    db 246,246,246,246,247,247,247,247,247,248,248,248,248,248,249,249
    db 249,249,249,250,250,250,250,250,251,251,251,251,251,252,252,252  
    db 252,252,253,253,253,253,253,254,254,254,254,254,254,255,255,255
IXT ;<-Second magical indexing table ;)
    db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    db 1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2
    db 2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3
    db 3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4
    db 4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,6
    db 6,6,6,6,6,6,6,7,7,7,7,7,7,8,8,8
    db 8,8,8,9,9,9,9,9,10,10,10,10,10,11,11,11
    db 11,12,12,12,12,13,13,13,14,14,14,14,15,15,15,16
    db 16,16,17,17,18,18,18,19,19,20,20,21,21,21,22,22
    db 23,23,24,24,25,25,26,27,27,28,28,29,30,30,31,32
    db 32,33,34,35,35,36,37,38,39,39,40,41,42,43,44,45
    db 46,47,48,49,50,51,52,53,55,56,57,58,59,61,62,63
    db 65,66,68,69,71,72,74,76,77,79,81,82,84,86,88,90
    db 92,94,96,98,100,102,105,107,109,112,114,117,119,122,124,127
    db 130,133,136,139,142,145,148,151,155,158,162,165,169,172,176,180
    db 184,188,192,196,201,205,210,214,219,224,229,234,239,244,250,255
