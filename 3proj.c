#include <reg51.h>
#define fimTempo 100 //timer = 0.2ms -> fimTempo=100*0.2ms=20ms
#define zero 3 //3*0.2ms=0.6ms -> 0�
#define centoOitenta 12 //12*0.2=2.4ms -> 180�
#define atraso 20
bit led = 0; //pino do led
bit var; //variavel auxiliar
bit varAnt = 1; //variavel auxiliar
sbit servo = P1^0;//pino de controlo do servo motor
sbit ledp = P1^1; //pino de controlo do led
unsigned char conta = 0; //contador que incrementa a cada 200us
unsigned char limite = 0; //define se a referencia deve incrementar ou decrementar
unsigned char conta2=0; //contador auxiliar define o atraso do movimento
unsigned char referencia = zero; //o servo motor come�a nos 0�


//declara��o de fun��es
void Init(void);

void Init(void)
{
//Configuracao Registo IE
EA = 1; //ativa interrupcoes globais
ET0= 1; //ativa timer 0
EX0 = 1;	// ativa interrupcao externa 0
//Configuracao Registo TMOD
TMOD &= 0xF0; //limpa os 4 bits do timer 0 (8 bits � auto reload)
TMOD |= 0x02; //modo 2 do timer 0
//Configuracao Timer 0
TH0 = 0x37; //Timer 0 - 200us
TL0 = 0x37;
//Configuracao Registo TCON
TR0 = 1; //comeca o timer 0
IT0 = 0; //interrupcao externa ativa quando esta a 0
}

//interrupcao externa
void External0_ISR(void) interrupt 0
{
led = 1; //assinala que o sensor foi ativado
EX0=0; //desliga as interrupçoes externas
}

//interrupcao tempo
void Timer0_ISR(void) interrupt 1
{
conta++; //incrementa a cada contagem de 200us
	var=~varAnt; // variavel auxiliar
}

void main(void)
{
//inicializa��es
Init();

while(1) //loop infinito
{
	if(var != varAnt){
		var = varAnt; //para nao voltar a executar esta parte sem ter havido interrupçao de tempo
if(conta == referencia){
servo =0; //coloca a sa�da a 0 at� atingir os 20ms
	
}
//atingiu os 20ms
if(conta == fimTempo)
{
led=0; //coloca a variavel a 0 antes de analisar se houve interrupçao
EX0 = 1 ; //ativa as interrupcoes externas
conta = 0; //reinicia conta
servo =1; //impulso positivo at� atingir o valor de referencia
conta2++ ; 
	
}


	
if(atraso == conta2)
{
if(led == 0)
{
	ledp = 1; // desliga o led
if(referencia == zero)
{	
	limite = 0; //como esta a zero a referencia incrementa
}
if(referencia == centoOitenta)
{
	limite = 1; // como esta a 1 a referencia decrementa
}

if(limite==1)
{
	referencia--; // anda em direcao ao zero
}
if(limite==0)
{
	referencia++; //anda em direcao ao 180
}
conta2=0;

}

if(led == 1)
{
referencia = referencia; //mantem o sinal de tempo no mesmo sitio
ledp=0;                  //liga o led
	conta2=0;              
}

}
}
}
}
