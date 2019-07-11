
    ;-----------------------------
    ;-     VAR   PERIFERICOS     -
    ;-----------------------------

OnOff EQU 00A0H ; serve para aceder ao site(quando ativo mostra o MBoasVindas(funcionalidade extra))
Username EQU 00B0H ; periferico de inserção de Username
UsernameEnd EQU 00B8H ; enderco onde termina o username
Password EQU 00C0H ; periferico de inserçao de password
PasswordEnd EQU 00C8H ; endereco onde terminha a password
BotaoOk EQU 00D0H ; periferico para validação da opção escolhida
BotaoOpcao EQU 00E0H ; periferico para especificar a opção pretendida
BaseRegisto EQU 7000H ;inicio do registo de users
FimUser EQU 7007H ; fim do endereco que guarda os users
BasePass EQU 10H ; inicio do registo de passwords
TamRegisto EQU 0040H ; tamanho de cada registo (espaço que ocupa em memoria)
EnderecoProxRegisto EQU 6FE0H ; endereco que tem o valor do endereco do proxregisto
InicioPeriferico EQU 00A0H ; endereco do inicio dos perifericos
FimPeriferico EQU 00F0H ; endereco do fim dos perifericos
ConstantePass EQU 2A2AH ; constante que indica o valor ASCII do esterisco
UserSessaoIniciada EQU 6FC0H ; endereco que aponta para o user com sessao iniciada
AcessoValorCompras EQU 20H ; variavel auxiliar para acesso ao valor ja gasto
EnderecoFlagDescontoPizza EQU 6FD0H ; Endereco onde vai ser guardada a flag de possivel desocnto
CompraDisplay EQU 110H
DescontoDisplay EQU 130H ; variavel auxiliar
DescontadoDisplay EQU 150H ;variavel auxiliar
ZeroASCII EQU 30H ;
CincoASCII EQU 35H ;
DoisASCII EQU 32H ;
VirgulaASCII EQU 2CH;
Nr_TOT_CHAR EQU 3
    ;-----------------------------
    ;-      VAR   DISPLAY        -
    ;-----------------------------

Display EQU 0100H ; inicio do display
Display_end EQU 0016FH ; fim do display
CaracterVazio EQU 0020H ; caracter que representa o espaço a ser usado aquando da limpeza do display
CaracterVazioE EQU 0020H ; caracter que representa o espaço a ser usado aquando da limpeza do display
InicioUserDisp EQU 0120H ; aponta
InicioPassDisp EQU 0150H ; aponta para onde começa a escrever a pass no display
StackPointer EQU 9000H

    ;-----------------------------
    ;-       MENUS USADOS        -
    ;-----------------------------

PLACE 1000H
; menu de boas vindas aquando do acesso ao site
  MBoasVindas:

      String "    BEM-VINDO   "
      String "      PizzO     "
      String "                "
      String " 1-Login        "
      String "                "
      String " 2-Registar     "
      String "                "
; menu de login para inserçao dos dados de login
PLACE 1080H
    MLogin:

      String "Insira os dados:"
      String "Username:       "
      String "                "
      String "                "
      String "Password:       "
      String "                "
      String "                "

; menu mostrado aquando da introduçao de dados incorretos no login
PLACE 1100H
    MErroLogin:

      String "ERRO            "
      String "                "
      String "DADOS           "
      String "INCORRETOS      "
      String "                "
      String "TENTE           "
      String "NOVAMENTE!      "

; menu aquando da criaçao de um novo reisto
  PLACE 1180H
    MRegisto:

        String "Escolha         "
        String "username:       "
        String "                "
        String "Escolha         "
        String "password:       "
        String "                "
        String "                "

; menu mostrado quando o username inserido ja esta em utilização
    PLACE 1200H
      MErroRegisto:

        String "Username        "
        String "em utilizacao   "
        String "                "
        String "Escolha         "
        String "outro username  "
        String "                "
        String "                "

; menu mostrado quando o registo é efetuado com sucesso
    Place 1280H
      MRegistoSucesso:

        String "Registo         "
        String "efectuado       "
        String "com             "
        String "sucesso         "
        String "                "
        String "                "
        String "                "

; menu mostrado se o login for efetuado com sucesso
    PLACE 1300H
      MPizzaria:
        String "   Selecione    "
        String "     opcao:     "
        String "                "
        String "1-Fazer pedido  "
        String "                "
        String "2-Logout        "
        String "                "

; menu mostrado se no menu anterir a este (MPizzaria) for escolhida a opção 1
    PLACE 1380H
      MPedido:
        String "                "
        String "1-Pizzas        "
        String "2-Bebidas(2e)   " ; funcionalidade extra (adiciona uma bebida com um preço fixo de 2€)
        String "3-Sobremesas(4e)" ; funcionalidade extra (adiciona uma sobremesa com um preço fixo de 4€)
        String "                "
        String "4-Finalizar     "
        String "5-Logout        "

  ; menu mostrado se no menu anterior a este (MPedido) for escolhida a oção 1
    PLACE 1400H
      MEscolhaPizza:
        String "Pizza:          "
        String "1-Camarao       "
        String "2-Atum          "
        String "3-Frango        "
        String "4-Marguerita    "
        String "5-Carbonara     "
        String "6-Voltar        "

  ; menu que é mostrado após a escolha da pizza atraves do menu (MEscolhaPizza), este menu permite a escolha do tamanho da pizza
      PLACE 1480H
        MEscolhaTamanho:
          String "Escolha o       "
          String "tamanho:        "
          String "                "
          String "1- Pequena (5e) "
          String "2- Grande  (8e) "
          String "                "
          String "3-Voltar        "

; menu mostrado se no menu anteror a este (MPedido) for escolhida a opçao 2 (funcionalidade extra)
    PLACE 1500H
      MEscolhaBebida:
        String "Bebida:         "
        String "1-Ice Tea Limão "
        String "2-Fanta Laranja "
        String "3-Coca Cola     "
        String "4-7 UP          "
        String "5-Voltar        "
        String "                "

; menu mostrado se no menu anterior a este (MPedido) for escolhida a opção 3 (funcionalidade extra)
    PLACE 1580H
      MEscolhaSobremesa:
        String "Sobremesa:      "
        String "1-Mousse Choc.  "
        String "2-Gelado Choc.  "
        String "3-Crepes        "
        String "4-Tiramissu     "
        String "5-Voltar        "
        String "                "


;  menu mostrado se no menu (MPedido) for escolhida a opção 5
    PLACE 1600H
      MPagamento:
        String "Valor encomenda:"
        String "           euros"
        String "Valor Desconto: "
        String "           euros"
        String "Total a pagar:  "
        String "           euros"
        String "1-Pagar         "

 ; mensagem mostrada quando a opção introduzida nao existe no menu atual
    PLACE 1680H
      MErroGeral:
        String "    ERRO!!      "
        String "                "
        String "   OPCAO        "
        String "   ESCOLHIDA    "
        String "   NAO          "
        String "   E            "
        String "   VALIDA       "

    PLACE 1700H
      MErroPassword:

        String "Password        "
        String "nao contem o    "
        String "numero minimo   "
        String "de 3 caracteres "
        String "                "
        String "     TENTE      "
        String "   NOVAMENTE!   "

      PLACE 1780H
        MErroUserNaoValido:
          String "User            "
          String "nao e           "
          String "valido          "
          String "                "
          String "                "
          String "     TENTE      "
          String "   NOVAMENTE!   "

      PLACE 1800H
        MAddCompra:
        String "Item            "
        String "adicionado      "
        String "com             "
        String "sucesso         "
        String "                "
        String "                "
        String "                "

        PLACE 1880H
          MLoginSucesso:
          String "login           "
          String "efetuado        "
          String "com             "
          String "sucesso         "
          String "                "
          String "                "
          String "                "

PLACE 0000H
; como o PC começa no endereço 0, temos de indicar que este salte para o inicio do codigo
Inicio: Mov R0, Principio
        JMP R0



PLACE 2000H

Principio:
              MOV SP, StackPointer
              MOV R10, BaseRegisto           ; move o valor do endereco do primeiro para um espaço de memoria escolhido
              MOV R9, EnderecoProxRegisto    ; move o valor do endereco para R9
              MOV [R9], R10                  ; coloca o valor da base de registo no enderecoProxRegisto
              MOV R10, 0                     ; apenas para limpar o valor do registo 10
              MOV R8, BasePass               ; move para R8 o endereco base da palavra pass
              CALL LimpaDisplay
              CALL LimpaPerifericos
              MOV R0, OnOff                   ;move para R0 o valor do endereco do botao OnOff


Liga:
      MOVB R1, [R0] ; move o valor que se encontra no endereco indicado por OnOff
      CMP R1, 1 ; compara com 1
      JNE Liga ; enquanto nao for igual a 1 continua no ciclo ate receber o valor 1

    Ligado:
      CALL LimpaDisplay
      CALL LimpaPerifericos
;-------------------------------------------------------------------------------
;                           MENU BOAS VINDAS
;-------------------------------------------------------------------------------

MenuBoasVindas:
        MOV R2, MBoasVindas ; move o valor do endereco onde esta o Menu boas vinda para R2
        CALL MostraDisplay
        CALL LimpaPerifericos
        MOV R0, BotaoOpcao ; move para R0 o endereco do botao opcao
        MOV R1, 1 ; move 1 para R1
        MOV R2, 2 ; move 2  para R2


      CicloOpcao:
        CALL RotinaOk ; verificia se o botao ok esta ativo
        MOVB R3, [R0] ; move para R3 o valor do periferico botao opcao
        CMP R3, R1 ; compara o valor do botao opcao com 1
        JEQ LoginS ; se for igual a 1 salta para a trotina login
        CMP R3 , R2 ; compara o valor do botao opcao com 2
        JEQ Registo ; se for igual a 2 salta para o menu registo
        JMP  CicloOpcao ; se nao for nem 1 nem 2 faz o ciclo outra vez

        LoginS:
        JMP Login
;-------------------------------------------------------------------------------
;                           OPCOES MENU BOAS VINDAS
;-------------------------------------------------------------------------------

Registo:
        MOV R2, MRegisto ; move para R2 o endereco onde se encontra o menu registo
        CALL MostraDisplay ; mostra o menu no display
        CALL LimpaPerifericos
        CALL RegistoUsers  ;regista os usernames
        CALL RegistoPassword ; regista as passwords
        JMP MenuBoasVindas ; salta para o menu boas vindas (menu anterior )

;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------




; Mostra no display as Mensagens selecionadas pelo registo R2
MostraDisplay:
            PUSH R0
            PUSH R1
            PUSH R3
            MOV R0, Display ; poe o valor da constante em R0
            MOV R1, Display_end  ; poe o valor da constante em R1
          Ciclo:
            MOV R3, [R2] ; move para R3 o endereco onde esta escrito o menu escolhido
            MOV [R0], R3 ; escreve na posicao do display indicada por R3 o valor que esta escrito em memoria
            ADD R2, 2 ; incrementa 2 ao ao endereco de memoria onde esta escrito o menu
            ADD R0, 2 ; adiciona 2 a contstane display guardada em R0
            CMP R0, R1 ; compara R0 com R1
            JLE Ciclo ; apenas termina se o endereco de display for maior que o endereco de Display_end
            POP R3
            POP R1
            POP R0
            RET


; restora o valor dos perifericos para 0
LimpaPerifericos:
            PUSH R0
            PUSH R1
            PUSH R2
            MOV R0, InicioPeriferico ; move para R0 o endereco de inicio dos perifericos
            MOV R1, FimPeriferico ; move para R1 o endereco de fim dos perifericos
            MOV R2, 0 ; move 0 para R3 para repor o valor 0 nos perifericos

          CicloLimpaP:
            MOVB [R0], R2 ; repoe o endereco do periferico com 0
            ADD R0, 1 ; incrementa o endereço
            CMP R0, R1  ; compara o endereco atual com o ultimo endereco dos perifericos
            JLE CicloLimpaP ; continua a repor o valor 0 ate o endereco atual ser maior que o fim dos perifericos
            POP R2
            POP R1
            POP R0
            RET


; Altera todos os valores do display para 20H que representa o espaço em codigo ASCII
LimpaDisplay:
              PUSH R0
              PUSH R1
              PUSH R2
              MOV R0, Display ; move para R0 o endreco de inicio do display
              MOV R1, Display_end ; move para R1 o endereco de fim do display

            CicloLimpa:
              MOV R2, CaracterVazio ; move para R2 o valor 20 que em ASCII e o espaco
              MOVB [R0], R2 ; move o valor 20 para cada endereco
              ADD R0, 1 ; incremeta o valor do endereco
              CMP R0, R1 ; compara o endereco atual com o endereco do fim
              JLE CicloLimpa ; continua a por o valor 20 ate o endereco altual ser maior que o endereco indicado por Display_end
              POP R2
              POP R1
              POP R0
              RET

              ;-----------------------------
              ;-       Registo Users       -
              ;-----------------------------

; Responsavel por guardar user
RegistoUsers:
              PUSH R0
              PUSH R1
              PUSH R2
              PUSH R4
              PUSH R5
              PUSH R6
              PUSH R7
              PUSH R8
              PUSH R9
              PUSH R10

            RegistoUsersSP:
              MOV R0, Username ; move para R0 o valor do  endereço do periferico de username
              MOV R1, UsernameEnd ; move para R1 o valor do endereco do fim do periferico de username
              MOV R4, EnderecoProxRegisto ; move para R2 onde começam a ser guardados os Usernames
              MOV R2, [R4] ; move para R2 onde começam a ser guardados os Usernames
              CALL RotinaOk ; verifica se o botao Ok esta a 1
              MOV R3, [R0] ; guarda em r3 o vlaor do primeiro caracter do periferico
              CMP R3, 0      ; compara o valor do primeiro endereco do periferico do username com 0
              JEQ ErroPVazio ; verifica se o primeiro valor do periferico é 0 se for significa que o periferico e vazio logo nao pode ser registado
              JMP UserJaExiste


          CicloRegistoUsers:
              MOV R3, [R0] ; move para R3 o valor do endereço atual do periferico username
              MOV [R2], R3 ; move o caractere para o endereco no espaco de memoria em que vai ser guardado
              ADD R0, 2 ; adiciona 2 ao valor do username, para escreve o proximo caractere
              ADD R2, 2 ; adiciona 2 ao valor da base de registo para gravar o proximo caratere
              CMP R0, R1 ; verifica se ja chegou ao fim do periferico username
              JLT CicloRegistoUsers ; enquanto o endereço atual nao for igual ao ultimo endereco do periferico continua a gravar no espaço de memoria cada caractere
              POP R10
              POP R9
              POP R8
              POP R7
              POP R6
              POP R5
              POP R4
              POP R2
              POP R1
              POP R0
              RET


            UserJaExiste:
              MOV R5, BaseRegisto          ; Mete em R5 endereco do inicio do primeiro utilizador ja guardado
              MOV R6, EnderecoProxRegisto  ; R6 guarda o endereco onde ira ser introduzido o utilizador actual
              MOV R6, [R6]                  ; guarda o valor que esta na posicao de memoria indicada por R6 em R6
              MOV R7, Username             ; R7 guarda o endereco do inicio do periferico de introducao do username
              MOV R9, BaseRegisto          ; R9 atualiza o endereco

            CicloUserExiste:
              MOV R10, [R5]                ; mete em R10 o valor que esta no endereco R5
              MOV R8, [R7]                ; mete em R8 o valor que esta guardado no R7
              CMP R10, R8                  ; Compara os valores de R10 e R5 ou seja verifica se os caracteres sao iguais
              JNE AtualizaEndercoExiste   ; Se R10 é diferente de R5 quer dizer que os carateres sao diferentes logo passa para o proximo user a ser comparado
              ADD R5, 2                   ; soma 2 ao R5
              ADD R7, 2                   ; soma 2 ao R7
              CMP R7, R1                   ; compara R7 com R1
              JLE CicloUserExiste           ; enquanto for menor ou igaull continua no Ciclo
              JMP NaoPodeRegistar          ; salta para a etiqueta indicada




            AtualizaEndercoExiste:
              MOV R7, TamRegisto ; poe o valor da constante em R7
              ADD R9, R7 ; adiciona o valor do tamanha a base do registo
              MOV R7, Username ;move o valor da constante para R7
              MOV R5, R9 ; move o valor de R9 para R5
              CMP R5, R6 ; compara R5 com R6
              JEQ CicloRegistoUsers ;quando forem diferentes sai do ciclo
              JMP CicloUserExiste ; salta para a etiqueta indicada



            NaoPodeRegistar:
              MOV R2, MErroRegisto ; move o valor da constante para R2
              CALL MostraDisplay ; escreve no display o menu indicado por R2
              CALL LimpaPerifericos ; limpa o valor do perifericos
              CALL RotinaOk ; espera pelo sinal do botao Ok
              MOV R2, MRegisto ; move o valor da constante par R2
              CALL MostraDisplay ; escreve no display o menu indicado pela constante R2
              CALL LimpaPerifericos ; limpa os perifericos
              JMP RegistoUsersSP ; salta para a etiqueta indicada

            ErroPVazio:
              Mov R2, MErroUserNaoValido ; move o valor da constante para R2r
              CALL MostraDisplay ; escreve no display o menu indicado por R2
              CALL LimpaPerifericos ; limpa o valor dos perifericos
              CALL RotinaOk ; espera pelo sinal do botao Ok
              MOV R2, MRegisto ; move para R2 o valor da constante
              CALL MostraDisplay ; escreve no display o menu indicado por R2
              CALL LimpaPerifericos ; limpa o valor dos perfiericos
              JMP RegistoUsersSP ; salta para a etiqueta indicada

; Responsavel por guardar a password no user correspondente
RegistoPassword:
                PUSH R0
                PUSH R1
                PUSH R2
                PUSH R3
                PUSH R4
                PUSH R5
                PUSH R6
                PUSH R7
                PUSH R8

            CicloPassword:
                MOV R5, 1                         ; Conta Caracteres inseridos
                MOV R0, Password                  ; move para R0 o valor do  endereço do periferico da password
                MOV R1, PasswordEnd               ; move para R1 o valor do endereco do fim do periferico de password
                MOV R7, EnderecoProxRegisto       ; mete o endereco em R7
                MOV R7 , [R7]                     ; coloca o valor do endereco R7 em R7
                MOV R8, BasePass                  ; guarda o endereco da base pass em r8
                ADD R7, R8                        ; Soma em R7 o valor do passo de user para password
                MOV R2, R7                        ; move para R2 onde começam a ser guardados as Passwords
                MOV R3, [R0]                      ; move para R3 o valor do endereço atual do periferico password
                CALL RotinaOk                     ; espera pelo sinal do botao ok
                JMP VerificaComprimento           ;salta para a etiqueta

                ; regista a passord
              CicloRegistoPassword:
                MOV [R2], R3 ; move para a posicao de memoria indicada por R2 o valor de R3
                ADD R2, 2 ;adiciona 2 ao R2
                ADD R0, 2 ; adiciona 2 ao R0
                MOV R3, [R0] ; mova o valor na posicao de memoria indicada por R0 para R3
                CMP R3, 0 ; compara R3 com 0
                JNE CicloRegistoPassword ; enqanto dor diferente continua no ciclo
                CALL MensagemRegistoSucesso
                CALL AtualizaEnderecoParaNovoRegisto
                POP R8
                POP R7
                POP R6
                POP R5
                POP R4
                POP R3
                POP R2
                POP R1
                POP R0
                RET


                ; conta o numero de caracteres na pass
              VerificaComprimento:
                CMP R3, 0 ; compara R3 com 0
                JEQ VerificaNumeroDeCaracteres ; se for igual salta para a etiqueta indicada
                ADD R0, 2 ; adiciona 2 ao R0
                ADD R5, 1 ; adiciona 1 ao R5
                MOV R3, [R0] ; move o valor no espalo de memoria indicado por R0 para R3
                JMP VerificaComprimento ; salta para a etiqueta indicada

                ;verifica se a pass tem o numero minimo de Caracteres
              VerificaNumeroDeCaracteres:
                  CMP R5, 3 ; compara R5 com 3
                  JLT MensagemErroPassword ; enquanto for menor continua no ciclo
                  MOV R0, Password ; move o valor da constante para R0
                  MOV R3, [R0] ; move o valor na memoria indicado por R0 par R3
                  JMP CicloRegistoPassword ;salta para a etiqueta indicada

                  ; mosta a mensagem de erro
              MensagemErroPassword:
                Mov R2, MErroPassword    ;Guarda no registo R2, a mensagem de erro na password
                CALL MostraDisplay       ; Escreve no display a mensagem guardada em R2
                CALL LimpaPerifericos    ; Limpa os valores do periferico
                CALL RotinaOk             ; Pressionar ok para dispensar mensagem e voltar ao menu registo
                MOV R2, MRegisto         ;Guarda no registo R2 o valor da constante
                CALL MostraDisplay        ; Escreve no display a mensagem guardada em R2
                CALL LimpaPerifericos    ; Limpa os valores do periferico
                CALL RotinaOk
                JMP CicloPassword        ; Volta para o ciclo password




              MensagemRegistoSucesso:
                PUSH R2
                CALL EscreveDisplayUser    ;Guarda no registo R2 o valor da constante
                CALL EscreveDisplayPass         ; Escreve no display a mensagem guardada em R2
                CALL LimpaPerifericos        ; Limpa os valores do periferico
                CALL RotinaOk               ; Pressionar ok para dispensar mensagem e voltar ao menu registo
                MOV R2, MRegistoSucesso  ;Guarda no registo R2, a mensagem Registo com sucesso
                CALL MostraDisplay       ; Escreve no display a mensagem guardada em R2
                CALL LimpaPerifericos    ; Limpa os valores do periferico
                CALL RotinaOk            ; Pressionar ok para dispensar mensagem e voltar ao menu registo
                POP R2
                RET



; Responsavel pela espera da confirmação do botao ok
RotinaOk:
                  PUSH R4
                  PUSH R5
                CicloOK:
                  MOV R4, BotaoOk ; move o endereco do botao ok para R4
                  MOVB R5, [R4] ;move para R5 o valor do botao OK
                  CMP R5, 0 ; compra com 0
                  JEQ CicloOK ; enquanto for igual fica no ciclo
                  POP R5
                  POP R4
                  RET

; atualiza o endereco onde deve registo os novos users
AtualizaEnderecoParaNovoRegisto:
                PUSH R0
                PUSH R1
                PUSH R2
                MOV R0, EnderecoProxRegisto ; move o valor da constante para R0
                MOV R1, [R0] ; move o valor indicado pelo valor de R0 para R1
                MOV  R2, TamRegisto ; move a constante para R2
                ADD R1, R2 ; adiciona R1 a R2 e guarda em R1
                MOV [R0] , R1 ; move o valor de R1 para o espaco de memoria indicado por R0
                POP R2
                POP R1
                POP R0
                RET

; escreve o username no display
EscreveDisplayUser:
                PUSH R0
                PUSH R1
                PUSH R2
                PUSH R3
                PUSH R4
                MOV R0, InicioUserDisp ; move o valor da constante par R0
                MOV R1, Username ; move o valor da constante pra R1
                MOVB R2, [R1] ; move o valor em enderecamento por byte indicado por R1 para R2

              CicloEU:

                MOVB [R0], R2 ; move o valor em enderecamento por byte indicado por R2 para R0
                ADD R0, 1 ; adiciona 1 ao R0
                ADD R1, 1 ; adiciona 1 ao R1
                MOVB R2, [R1] ; move o valor em enderecamento por byte indicado por R1 para R2
                CMP R2, 0 ; compara com 0
                JNE CicloEU ; apenas termina se o endereco de display for diferente de 0
                POP R4
                POP R3
                POP R2
                POP R1
                POP R0
                RET

EscreveDisplayPass:
                PUSH R0
                PUSH R1
                PUSH R2
                PUSH R3
                MOV R0, InicioPassDisp ; mostra no display o que esta no endereço indicado em R2
                MOV R1, Password ; move o valor da constante para R1
                MOV R2, ConstantePass ; move o valor da constante para R2
                MOVB R3, [R1] ; move o valor em enderecamento por byte indicado por R1 para R3

             CicloEP:

                MOVB [R0], R2  ; move o valor em enderecamento por byte em R2 para a posicao indicado por R0
                ADD R0, 1
                ADD R1, 1
                MOVB R3, [R1] ; move o valor em enderecamento por byte indicado por R1 para R3
                CMP R3, 0 ; comprar com 0
                JNE CicloEP ; equanto for diferente continua no ciclo
                POP R3
                POP R2
                POP R1
                POP R0
                RET


; verifica se o login ocorreu com sucesso
Login:
        MOV R2, MLogin ; move a cosntante para R2
        CALL MostraDisplay ; mostra no disply o indicado por R2
        CALL LimpaPerifericos ; poe os perfiericos a 0
        CALL RotinaOk                 ; espera pelo sinal do botao ok

        VerificaUserLogin:
          MOV R1, BaseRegisto          ; Mete em R1 endereco do inicio do primeiro utilizador ja guardado
          MOV R2, EnderecoProxRegisto  ; R2 guarda o endereco onde ira ser introduzido o utilizador actual
          MOV R2, [R2]                 ; guarda o valor que esta na posicao de memoria indicada por R2 em R2
          MOV R3, Username             ; R3 guarda o endereco do inicio do periferico de introducao do username
          MOV R4, UsernameEnd          ; R4 guarda o endereco dE fim do periferico de introducao do username
          MOV R5, BaseRegisto          ; R5 atualiza o endereco
          MOV R8, UserSessaoIniciada     ; move o valor da constante para R8

        CicloUserLogin:
          MOV R6, [R1]                    ; mete em R6 o valor que esta no endereco R1
          MOV R7, [R3]                    ; mete em R7 o valor que esta guardado no R3
          CMP R6, R7                      ; Compara os valores de R6 e R7 ou seja verifica se os caracteres sao iguais
          JNE AtualizaEndercoUserLogin    ; Se R6 é diferente de R7 quer dizer que os carateres sao diferentes logo passa para o proximo user a ser comparado
          ADD R1, 2                       ; soma 2 ao R1
          ADD R3, 2                       ; soma 2 ao R3
          CMP R3, R4                      ; compara R3 com R4
          JLE CicloUserLogin              ; enquanto for menor ou igaul continua no Ciclo
          MOV [R8], R5                    ; move para a posicao indicada por R8 o valor do R5
          JMP VerificaPassword            ; salta para a etiqueta indicada


        AtualizaEndercoUserLogin:
          MOV R3, TamRegisto ; poe o valor da constante em R3
          ADD R5, R3 ; adiciona o valor do tamanha a base do registo
          MOV R3, Username ;move o valor da constante para R3
          MOV R1, R5 ; move o valor de R5 para R1
          CMP R1, R2 ; compara R1 com R2
          JEQ MostraErroLogin ;quando forem diferentes sai do ciclo
          JMP CicloUserLogin   ; salta para a etiqueta indicada
        ;  CALL EscreveDisplayUser
        ;  CALL EscreveDisplayPass
        ;  CALL LimpaPerifericos
        ;  CALL RotinaOk

        MostraErroLogin:
          MOV R2, MErroUserNaoValido  ; move a cosntante para R2
          CALL MostraDisplay  ; mostra no disply o indicado por R2
          CALL LimpaPerifericos ; poe os perfiericos a 0
          CALL RotinaOk    ; espera pelo sinal do botao ok
          CALL LimpaPerifericos ; poe os perfiericos a 0
          JMP Login

        VerificaPassword:
          MOV R1, Password ; move o valor do inicio do periferico password para R1
          MOV R2, PasswordEnd ; move para R2 o valor do fim do periferico password
          MOV R4, BasePass ; move para R4 o valor da constante
          MOV R5, [R8] ; move para R5 o endereco do user atual
          ADD R5, R4 ; adiciona R4 ao R5 e guarda em R5

        CicloVerificaPassword:
          MOV R6, [R1]                    ; mete em R6 o valor que esta no endereco R1
          MOV R7, [R5]                    ; mete em R7 o valor que esta guardado no R5
          CMP R6, R7                      ; Compara os valores de R6 e R7 ou seja verifica se os caracteres sao iguais
          JNE MostraErroLogin             ; se for diferente mostra erro
          ADD R1, 2                       ; soma 2 ao R1
          ADD R5, 2                       ; soma 2 ao R3
          CMP R1, R2                      ; compara R3 com R4
          JLE CicloVerificaPassword       ; enquanto for menor ou igaul continua no Ciclo


        LoginSucesso:
          CALL EscreveDisplayUser
          CALL EscreveDisplayPass
          CALL LimpaPerifericos
          CALL RotinaOk
          MOV R2, MLoginSucesso ; move o valor da constante para R2
          CALL MostraDisplay  ; mostra no display o indicado por R2
          CALL LimpaPerifericos ; limpa os perifericos
          CALL RotinaOk ; espera pelo sinal Ok


; menu apos login
MenuPizzaria:

          MOV R1, BotaoOpcao              ;Guarda em R1 o endereco correspondente ao BotaoOpcao
          MOV R2, MPizzaria               ; Guarda em R2, o ecra MPizzaria
          CALL MostraDisplay              ; Mostra o ecra guardado em R2
          CALL LimpaPerifericos           ; Limpa os perifericos
          CALL RotinaOk                   ; Aguarda pelo ok para confirmar a opcao

        CicloMenuPizzaria:
          MOVB R3, [R1]                   ; Guarda em R1 o valor correspondente ao BotaoOpcao
          CMP R3, 1                       ; Verifica se a opcao escolhida foi 1
          JEQ MenuEscolha                 ; Se for 1 salta para o MenuEscolha
          CMP R3, 2                       ; Verifica se a opcao escolhida foi 2
          JEQ Logout                      ; Se for 2 salta para Logout
          JMP CicloMenuPizzaria           ; Repete o ciclo ate escolher uma opcao valida

; salta para a rotina MenuBoasVindas
MenuBoasVindasS:
          JMP MenuBoasVindas

; rotina que escolhe a opcao no menu escolha
MenuEscolha:
          MOV R1, BotaoOpcao             ; Guarda em R1 o endereco correspondente ao BotaoOpcao
          MOV R2, MPedido                ; Guarda em R2 a endereco da Mensagem do menu pedido
          CALL MostraDisplay             ; Mostra no display a mensagem guardada em R2
          CALL LimpaPerifericos          ; Limpa os perifericos
          CALL RotinaOk
          MOV R4, UserSessaoIniciada
          MOV R5, AcessoValorCompras
          MOV R4, [R4]
          ADD R4, R5

        CicloMenuEscolha:
          MOVB R3, [R1]                  ; Guarda em R1 o valor correspondente ao BotaoOpcao
          CMP R3, 1
          JEQ MenuPizza                  ; Se BotaoOpcao for 1 salta para menu da escolha da pizza
          CMP R3, 2
          JEQ MenuBebidas                ; Se BotaoOpcao for 2 salta para menu da escolha da bebidas
          CMP R3, 3
          JEQ MenuSobremesa              ; Se BotaoOpcao for 3 salta para menu da escolha da sobremesa
          CMP R3, 4
          JEQ MenuPagamentoS             ; Se BotaoOpcao for 4 salta para menu do pagamento
          CMP R3, 5
          JEQ Logout                    ; Se BotaoOpcao for 5 salta Logout

          JMP CicloMenuEscolha             ; volta para o ciclo de menu escolha ate escolher uma opcao valida

; salta para o menu pagamento
MenuPagamentoS:
        JMP Pagamento
;faz logout da conta
Logout:
    MOV R6, 0
    MOV R4, UserSessaoIniciada
    MOV R5, AcessoValorCompras
    MOV R4, [R4]
    ADD R4, R5
    MOV [R4], R6
    MOV R1, EnderecoFlagDescontoPizza
    MOV [R1], R6
    JMP MenuBoasVindasS






; rotina que escolhe a opcao no menu pizza
MenuPizza:
          MOV R1, BotaoOpcao
          MOV R2, MEscolhaPizza          ; Guarda em R2 o endereco da Mensagem da escolha da pizza
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk

        CicloMenuPizza:

          MOVB R3, [R1]
          CMP R3, 1
          JEQ MenuEscolhaTamanhoPizza     ; Se BotaoOpcao for 1 salta para menu escolha tamanho
          CMP R3, 2
          JEQ MenuEscolhaTamanhoPizza     ; Se BotaoOpcao for 2 salta para menu escolha tamanho
          CMP R3, 3
          JEQ MenuEscolhaTamanhoPizza     ; Se BotaoOpcao for 3 salta para menu escolha tamanho
          CMP R3, 4
          JEQ MenuEscolhaTamanhoPizza     ; Se BotaoOpcao for 4 salta para menu escolha tamanho
          CMP R3, 5
          JEQ MenuEscolhaTamanhoPizza     ; Se BotaoOpcao for 5 salta para menu escolha tamanho
          CMP R3, 6
          JEQ MenuEscolha                 ; Se BotaoOpcao for 6 volta para o menu de escolha

          JMP CicloMenuPizza              ; volta para o menu escolha pizza ate escolher uma opcao correta

; rotina que escolhe a opcao no menu de escolha do tamanho da pizza
MenuEscolhaTamanhoPizza:
          MOV R1, BotaoOpcao
          MOV R2, MEscolhaTamanho
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk

        CicloMenuTamanho:


          MOVB R3, [R1]
          CMP R3, 1
          JEQ EscolheuPizzaPequena
          CMP R3, 2
          JEQ EscolheuPizzaGrande
          CMP R3, 3
          JEQ MenuPizza

          JMP CicloMenuTamanho

; rotina que escolhe a opcao no menu bebidas
  MenuBebidas:
          MOV R1, BotaoOpcao
          MOV R2, MEscolhaBebida
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk
        CicloMenuEscolhaBebida:
          MOVB R3, [R1]
          CMP R3, 1
          JEQ EscolheuBebida
          CMP R3, 2
          JEQ EscolheuBebida
          CMP R3, 3
          JEQ EscolheuBebida
          CMP R3, 4
          JEQ EscolheuBebida
          CMP R3, 5
          JEQ MenuEscolha

          JMP CicloMenuEscolhaBebida

; rotina que escolhe a opcao no menu sobremesa
  MenuSobremesa:
          MOV R1, BotaoOpcao
          MOV R2, MEscolhaSobremesa
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk

        CicloMenuEscolhaSobremesa:
          MOVB R3, [R1]
          CMP R3, 1
          JEQ EscolheuSobremesa
          CMP R3, 2
          JEQ EscolheuSobremesa
          CMP R3, 3
          JEQ EscolheuSobremesa
          CMP R3, 4
          JEQ EscolheuSobremesa
          CMP R3, 5
          JEQ MenuEscolha
          JMP CicloMenuEscolhaSobremesa

; rotina que indica que a pizza pequena foi escolhida e adiciona ao total de compras
 EscolheuPizzaPequena:
          MOV R3, 1
          MOV R0, EnderecoFlagDescontoPizza
          MOV [R0], R3
          MOV R1, UserSessaoIniciada
          MOV R4, AcessoValorCompras
          MOV R1, [R1]
          ADD R1, R4
          MOV R2, [R1]
          ADD R2, 5
          MOV [R1], R2
          MOV R2, MAddCompra
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk
          JMP MenuEscolha

; rotina que indica que a pizza grande foi escolhida e adiciona ao total de compras
  EscolheuPizzaGrande:

          MOV R0, EnderecoFlagDescontoPizza
          MOV [R0], R3
          CMP R3, 0
          JNE JaComprouPizzaPequena
          MOV R3, 2
          MOV [R0], R3
        JaComprouPizzaPequena:
          MOV R1, UserSessaoIniciada
          MOV R4, AcessoValorCompras
          MOV R1, [R1]
          ADD R1, R4
          MOV R2, [R1]
          ADD R2, 4
          ADD R2, 4
          MOV [R1], R2
          MOV R2, MAddCompra
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk
          JMP MenuEscolha

; rotina que indica que a bebida foi escolhida e adiciona ao total de compras
  EscolheuBebida:
          MOV R1, UserSessaoIniciada
          MOV R4, AcessoValorCompras
          MOV R1, [R1]
          ADD R1, R4
          MOV R2, [R1]
          ADD R2, 2
          MOV [R1], R2
          MOV R2, MAddCompra
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk
          JMP MenuEscolha

; rotina que indica que a sobremesa foi escolhida e adiciona ao total de compras
  EscolheuSobremesa:
          MOV R1, UserSessaoIniciada
          MOV R4, AcessoValorCompras
          MOV R1, [R1]
          ADD R1, R4
          MOV R2, [R1]
          ADD R2, 4
          MOV [R1], R2
          MOV R2, MAddCompra
          CALL MostraDisplay
          CALL LimpaPerifericos
          CALL RotinaOk
          JMP MenuEscolha

; rotina que verifica se vai ter desconto ou nao
Pagamento:
          MOV R0, UserSessaoIniciada
          MOV R0, [R0]
          MOV R1, AcessoValorCompras ;20H
          MOV R2, EnderecoFlagDescontoPizza
          MOV R7, 0     ; Valor do desconco
          MOV R3, 50
          ADD R0, R1	 ; R0 agora guarda endereco correspondente ao valor da compra atual
          MOV R4, [R0]     ; R4 guarda o valor da compra atual
          MOV R5, R0
          ADD R5, 2	 ; R5 guarda o endereco a guardar o total compras
          MOV R6, [R5]	 ; R6 guarda o valor total compras
          ADD R6, R4	 ; Adiciona compra atual ao total
          MOV [R5], R6	 ; Guarda o total no endereco correspondente ao total compras
          CMP R6, R3
          JGE PagamentoComDesconto
          JMP PagamentoSemDesconto


 ; rotina que implementa o desconto

; implementa o desconto
PagamentoComDesconto:
          MOV R2, MPagamento
          CALL MostraDisplay
          CALL LimpaPerifericos

          MOV R0, UserSessaoIniciada
          MOV R1, [R0]                        ; R1 guarda o endereco do user com sessao iniciada
          MOV R2, EnderecoFlagDescontoPizza
          MOV R3, [R2]                        ; R3 guarda a flag para verificar que tipo de desconto é feito
          MOV R4, R1
          MOV R5, AcessoValorCompras
          ADD R4, R5
          MOV R4, [R4]
          CMP R3, 1
          JEQ DescontoPizzaPequena
          CMP R3, 2
          JEQ DescontoPizzaGrande
          CMP R3, 0
          JEQ PagamentoSemDesconto

        DescontoPizzaPequena:
           MOV R6, R4
           SUB R6, 3
           MOV R1, R4
           MOV R2, CompraDisplay
           CALLF Converte_to_Char
           MOV R1, R6
           MOV R2, DescontadoDisplay
           CALLF Converte_to_Char
           MOV R9, VirgulaASCII
           ADD R2, 4
           MOVB [R2], R9
           ADD R2, 1
           MOV R9, CincoASCII
           MOVB [R2], R9
           MOV R9, DescontoDisplay
           ADD R9, 2
           MOV R10, DoisASCII
           MOVB [R9], R10
           ADD R9, 1
           MOV R10, VirgulaASCII
           MOVB [R9], R10
           ADD R9, 1
           MOV R10, CincoASCII
           MOVB [R9], R10
           CALL RotinaOk

           MOV R0, UserSessaoIniciada
           MOV R1, [R0]                        ; R1 guarda o endereco do user com sessao iniciada
           MOV R2, EnderecoFlagDescontoPizza
           MOV R3, [R2]                        ; R3 guarda a flag para verificar que tipo de desconto é feito
           MOV R4, R1
           MOV R5, AcessoValorCompras
           ADD R4, R5
           MOV R5, 0
           MOV [R4], R5
           ADD R4, 2
           MOV [R4], R5

           JMP MenuPizzaria

          DescontoPizzaGrande:
            MOV R6, R4
            SUB R6, 4
            MOV R1, R4
            MOV R2, CompraDisplay
            CALLF Converte_to_Char
            MOV R1, R6
            MOV R2, DescontadoDisplay
            CALLF Converte_to_Char
            MOV R3, 4
            MOV R5, ZeroASCII
            ADD R3, R5
            MOV R4, DescontoDisplay
            ADD R4, 2
            MOVB [R4], R3
            CALL RotinaOk


            MOV R0, UserSessaoIniciada
            MOV R1, [R0]                        ; R1 guarda o endereco do user com sessao iniciada
            MOV R2, EnderecoFlagDescontoPizza
            MOV R3, [R2]                        ; R3 guarda a flag para verificar que tipo de desconto é feito
            MOV R4, R1
            MOV R5, AcessoValorCompras
            ADD R4, R5
            MOV R5, 0
            MOV [R4], R5
            ADD R4, 2
            MOV [R4], R5
            JMP MenuPizzaria




  PagamentoSemDesconto:
      CALL EscreveMPagamento

      MOV R6, R4
      MOV R1, R4
      MOV R2, CompraDisplay
      CALLF Converte_to_Char
      MOV R1, R6
      MOV R2, DescontadoDisplay
      CALLF Converte_to_Char
      MOV R5, ZeroASCII
      MOV R4, DescontoDisplay
      ADD R4, 2
      MOVB [R4], R5
      CALL RotinaOk


      MOV R0, UserSessaoIniciada
      MOV R1, [R0]                        ; R1 guarda o endereco do user com sessao iniciada
      MOV R2, EnderecoFlagDescontoPizza
      MOV R3, [R2]                        ; R3 guarda a flag para verificar que tipo de desconto é feito
      MOV R4, R1
      MOV R5, AcessoValorCompras
      ADD R4, R5
      MOV R5, 0
      MOV [R4], R5
      JMP MenuPizzaria

; escre o menu pagamento no ecra
EscreveMPagamento:
PUSH R2
MOV R2, MPagamento
CALL MostraDisplay
CALL LimpaPerifericos
POP R2
RET

;converte os numeros em hexadecimal para ASCII
      Converte_to_Char:
        PUSH R0
        PUSH R3
        PUSH R4
        PUSH R5
        MOV R0, 10
        ADD R2, 2 ; POSICAO DO 1 CARACTER
        MOV R3, 0 ; TATAL CARACTERES = 0

      ProximoCaracter:
        MOV R4, R1
        MOD R4, R0 ; RESTO DA DIVISAO
        DIV R1, R0 ; DIVISAO INTEIRA POR 10
        MOV R5, 48
        ADD R5, R4
        MOV R4, R2
        MOVB [R4], R5
        SUB R2, 1
        ADD R3, 1
        CMP R1,0
        JNE ProximoCaracter
        JEQ Fim_Rotina

      Preenche_Vazios:
        MOV R5, CaracterVazio
        MOV R4, R2
        MOV [R4], R5
        SUB R2, 1
        ADD R3, 1
        CMP R3, Nr_TOT_CHAR
        JNE Preenche_Vazios

      Fim_Rotina:
        POP R5
        POP R4
        POP R3
        POP R0
        RETF
