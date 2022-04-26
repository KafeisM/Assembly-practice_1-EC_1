*--------------------------------------------
* Titulo : P1 (2021-2022) - Anagram
* Autores: Jordi Florit y Marc Ferrer
*--------------------------------------------
            ORG $1000
WORD_SIZE:  EQU 12
WORD_1:     DC.B 'demostracion'
WORD_2:     DC.B 'domesticaron'
IS_ANAGRAM: DS.B 1
NOT_FOUND:  DS.B 1
*--------------------------------------------
AUX:        DC.W 0

*El registro D0,D1 servirán para iterar en los bucles
*Los registros D2,D3 se guardarán las correspondientes letras a comparar
*Los Strings se recorrerán con el direcionamiente indexado

START:
    
    MOVE.W #WORD_SIZE, D0   ;Inicializamos el DBRA, iterará X veces el LOOP_1
    SUB.B #1,D0
    
    MOVE.L #0,A0            ;Ponemos el indice del vector WORD_1 a 0
 LOOP_1:
    MOVE.B WORD_1(A0),D2    
    ADDQ.L #1,A0            ;Aumentamos el índice
    
    MOVE.W #WORD_SIZE, D1   ;Inicializamos el dbra, iterará X veces el LOOP_2
    SUB.B #1,D1
    
    MOVE.L #0,A1            
LOOP_2:                     ;creamos un bucle anidado que compara todas
                            ;las letras con una única letra de WORD_1
    
    MOVE.B WORD_2(A1),D3    
    
    CMP D2,D3
    BNE NO_IGUALES          
    ADDQ.W #1,(AUX)         ;si las letras son iguales, augmentar el contador
    MOVE.B #0,WORD_2(A1)    ;ponemos 0 en la posición  
    BRA SALTO               ;salto incondicional para saltar NO_IGUALES
        
NO_IGUALES:                 ;sino son iguales no augmenta el contador
    
    ADDQ.L #1,A1            ;incrementamos el indice
 
    DBRA D1,LOOP_2
    
SALTO:  
    DBRA D0,LOOP_1          

    MOVE.W AUX,D4           
    MOVE.W #WORD_SIZE,D5
    MOVE.B #0,IS_ANAGRAM
    CMP D4,D5               ;comparamos el contador y la cantidad de letras
    BNE NO_ANAGRAM          
    MOVE.B #1,IS_ANAGRAM    ;si es anagrama, lo constatamos en memoria
    MOVE.B #0,NOT_FOUND
               
NO_ANAGRAM:     

   MOVE.W #0,D6 
   MOVE.W #0,D2             ;D2 como contador de letras no encontradas
   MOVE.L #0,A1
   
   MOVE.W #WORD_SIZE, D0    ;prepara el bucle 
   SUB.B #1,D0
   
LOOP_3:

    MOVE.B WORD_2(A1),D3    
    ADDQ.L #1,A1
    
    CMP D3,D6               ;comparamos las posiciones de WORD_2 con 0
    BEQ EXISTS              ;si son iguales, es que la letra si existe
    ADDQ.W #1,D2            ;si no existe, sumamos 1 a NOT_FOUND
    MOVE.B D2,NOT_FOUND
    
EXISTS:
   
    DBRA D0,LOOP_3
    
    
    SIMHALT             

    END    START       











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
