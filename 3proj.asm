;Definição de constantes
TempoL EQU 0x37 ; Valor do byte menos significativo para o temporizador
TempoH EQU 0x37 ; Valor do byte mais significativo para o temporizador
fimTempo EQU 100 ; timer = 0.2ms -> fimTempo=100*0.2ms=20ms
referencia EQU 3 ; valor da referencia
limite EQU 0 ; var aux
zero EQU 3 ; //3*0.2ms=0.6ms -> 0º
centoOitenta EQU 12 ; Indica que é para deslocar para a esquerda
atraso EQU 15 
servo EQU P1.0 ; pin do servo
led EQU P1.1 ; pin do led


CSEG AT 0000h
JMP Inicio

; Tratamento da interrupção externa
CSEG AT 0003h
JMP InterrupcaoExt0

; Tratamento da interrupção de temporização 0, para contar 20ms
CSEG AT 000Bh
JMP InterrupcaoTemp0

CSEG AT 0050h
Inicio:
MOV SP, #7 ; endereço inicial da stack point
Call Inicializacoes ; Chamada a rotina inicializações
Call PrioridadeInterrupcoes ; Rotina para definir as prioridades das interrupções
Call ActivaInterrupcoes ; Rotina para ativar as interrupçõe
CALL ActivaTemporizador ; ativa temporizador



; apenas entra no ciclo se o conta tiver sido incrementado
Espera:
MOV A, R6 ;a=var
MOV B, #0 ; b=0
CJNE A, B , Conta ;compara a var com 0 se for diferente salta para a rotina Conta
JMP Espera ; continua no ciclo ate conta ser incrementado

; if(conta == referencia)
Conta:
MOV R6, #0  ; var=varAnt
MOV A, R2 ; a = conta
MOV B, R1 ; b = referencia
CJNE A, B, FTempo ;compara a conta com a referencia e se nao forem iguais salta para a rotina FTempo 
CLR servo ; poe o sinal do servo a 0 ate chegar aos 20ms

; if(conta == fimTempo)
FTempo:
MOV A, R2 ;a=conta
MOV B, #fimTempo ; b=fimTempo
CJNE A, B, AtrasoL ; compara conta com fimTempo e se for diferente salta para a rotina AtrasoL
MOV R4, #0 ; poe o sianl de controlo da int externa a 0 antes de analisar
MOV IE, #10000011b ; volta a ligar int externas
MOV R2, #0 ; conta = 0;
SETB servo ; impulso positivo ate atingir o valor de referencia
INC R3 ; conta2++

;if(conta2==atraso)
AtrasoL:
MOV A, R3 ; a=conta2
MOV B, #atraso ; b=atraso
CJNE A, B, Espera ;compara conta2 com atraso e se for diferente salta para a rotina Espera
MOV A, R4 ; a= led 
JNZ TrataInt ; liga o led e conta2=0
SETB led  ; desliga o led
MOV A, R1 ; a=referencia
MOV B, R0 ; b= zero
CJNE A , B , LimZero ;poe limite a zero
MOV R7, #0 ; limite = 0
JMP Movimento

;verifica limite
LimZero:
MOV A, R1 ;a=referencia
MOV B, R5 ;b=centoOitenta
CJNE A, B, Movimento  ;compara referencia com centoOitenta e se for diferente salta para a rotina Movimento
MOV R7, #1 ; limite = 1

Movimento:
MOV A, R7 ; a=limite
JNZ Decrementa ; se limite for diferente de 0 salta para a rotina Decrementa
INC R1 ; referencia++
MOV R3, #0 ; conta2=0
JMP Espera ;volta ao inicio do ciclo

Decrementa:
DEC R1 ;referencia--
MOV R3, #0 ; conta2=0
JMP Espera ;volta ao inicio do ciclo

TrataInt:
CLR led ; led =0
MOV R3, #0 ; conta2=0
JMP Espera ;volta ao inicio do ciclo

;Rotina inicializações
Inicializacoes:
MOV R0, #zero ; Estado inicial
MOV R1, #referencia ; inicializa referenvia
SETB led ; led = 1(desligado)
MOV R2, #0 ; inicializa conta
MOV R3, #0 ; incializa conta2
MOV R5, #centoOitenta ; R5 tem o valor 12
MOV R7, #limite ; inicializa limite
RET

;Rotina para ativar a interrupção externa e overflow do temporizador
ActivaInterrupcoes:
MOV IE, #10000011b ; Activa as interrupções timer 0 e externa 0
CLR IT0 ; A interrupção externa vai ser detectada enquanto estiver a 0
RET

; Definição da rotina de prioridades
PrioridadeInterrupcoes:
MOV IP, #00000010b ; o timer 0 tem prioridade mais elevada
RET

; Rotina de ativação de temporizador
ActivaTemporizador:
SETB TR0 ; Activa o temporizador 0, para fazer contagens de 20 ms (Clk de 12MHz)
MOV TMOD, #00000010b ; Activa temporizador no modo de leitura de 16 bits
MOV TL0, #TempoL ; Valor do byte menos significativo
MOV TH0, #TempoH ; Valor do byte mais significativo
RET

;Tratamento da Interrupção externa
InterrupcaoExt0:
MOV IE, #10000010b ; descliga as interrupçoes externas
MOV R4, #1 ; manda sinal de controlo para dizer que ouve interrupcao externa
RETI

; Tratamento da Interrupção de fim de contagem (quando ocorre overflow)
InterrupcaoTemp0:
INC R2 ; incrementa conta
MOV R6, #1 ; var=~varAnt
RETI

End
