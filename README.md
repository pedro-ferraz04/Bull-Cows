AUTHORS: ARTHUR ISOPPO, CLEYSSO SCHWANCK, LUCAS BIANCHESSI, PEDRO FERRAZ

GITHUB: https://github.com/pedro-ferraz04/Bull-Cows

# 🔗 [Vídeo Demonstração do Bulls & Cows](https://youtu.be/isaDQs7UBkk?feature=shared). 

# **Introdução**  
O presente relatório descreve o desenvolvimento e a implementação do jogo *Bulls & Cows* (Touros e Vacas) na plataforma *Vivado*, utilizando a placa *Nexys A7*. O projeto tem como objetivo reproduzir as regras do jogo clássico, no qual dois jogadores competem para adivinhar um número secreto definido pelo adversário, utilizando os recursos de hardware disponíveis na placa, como *toggle buttons*, *push buttons* e o *display de 8 segmentos*.  


O jogo é dividido em duas fases principais: **preparo (setup)**, onde cada jogador define seu número mágico, e **adivinhação (guess)**, na qual os jogadores alternam turnos tentando descobrir o número do oponente. A cada tentativa, o sistema fornece feedback indicando quantos dígitos estão corretos e na posição certa (*touros*) e quantos estão corretos, mas em posições erradas (*vacas*). O vencedor é aquele que primeiro acertar o número secreto, sendo premiado com um LED aceso na fileira correspondente, registrando assim suas vitórias ao longo das partidas.  


Este trabalho exige o cumprimento de diversas regras específicas, como a validação de números sem repetição de dígitos, a representação de cada dígito em 4 bits (valores de 0 a 7) e a exibição adequada das mensagens no display, seguindo os exemplos fornecidos. A implementação foi realizada com adaptações que se mostraram necessárias durante desenvolvimento do mesmo.


No decorrer deste relatório, serão detalhados os aspectos técnicos da implementação, os desafios enfrentados, as soluções adotadas e os resultados obtidos nos testes realizados na placa *Nexys A7*.

# **Estrutura do Código**  
O sistema foi implementado em **SystemVerilog** e estruturado em dois módulos principais: `bullsCows` (lógica do jogo) e `bullsCows_top` (interface com hardware).  
### **1. Módulo `bullsCows`**  
- **Máquina de estados finitos (FSM)**: Controla as fases do jogo (`SECRET_J1`, `SECRET_J2`, `GUESS_J1`, `GUESS_J2`, `DISPLAY`, `FIM`).
```
  typedef enum {  
    SECRET_J1, SECRET_J2, GUESS_J1, GUESS_J2, DISPLAY, FIM  
  } state_t;
```
  
- **Funções críticas**:  

  - `repetidos`: Verifica dígitos repetidos no número mágico (ex: "1123" é inválido).
  - `count_bulls` e `count_cows`: Calculam touros (dígitos corretos na posição certa) e vacas (dígitos corretos na posição errada).

```
  function automatic [2:0] count_bulls(input logic [15:0] guess, input logic [15:0] secret);  
    // Lógica para contagem de touros  
  endfunction
```
  
- **Lógica de exibição**: Define os padrões do display para cada estado (ex: "J1 SETUP", "1 TO 1 VA").  
- **Contagem de vitórias**: Atualiza os LEDs (`j1_count`, `j2_count`) conforme as vitórias ocorrem.  
### **2. Módulo `bullsCows_top`**  
- **Integração com hardware**:  
  - Mapeia os sinais de entrada (`SW`, `confirm`, `clock`) e saída (`an`, `seg`).  
  - Instancia o driver do display (`dspl_drv_NexysA7`) para converter os valores lógicos em padrões visuais.
```
  dspl_drv_NexysA7 u_display_driver (  
      .clock(internal_clock),  
      .reset(internal_reset),  
      .d1(d1), .d2(d2), ..., .d8(d8),  
      .an(an_out),  
      .dec_ddp(seg_out)  
  );  
```

## **Fluxo de Operação**  
1. **Setup Phase**:

   - Jogador 1 define seu número mágico via `SW[15:0]` e confirma.  

   - Repetido para Jogador 2.  
3. **Guess Phase**:  

   - Turnos alternados: Jogadores inserem tentativas via `SW[15:0]`.  

   - Ao confirmar, o display mostra touros/vacas ou "BULLSEYE" se correto.  
5. **Finalização**:  
   - Vitórias são exibidas nos LEDs (`j1_count`, `j2_count`).   

## **Controle de Versão**  
O código foi versionado utilizando **GitHub**, com repositório estruturado para facilitar colaboração e revisão de pares, assim como, para manter histórico de implementação (commits e branches).  

# **Resultados**  
## **Funcionalidades Implementadas**  
O projeto alcançou os objetivos principais do jogo *Bulls & Cows*, com as seguintes funcionalidades operacionais:  
1. **Fases de Preparo e Adivinhação**:  

   - Os jogadores definem seus números mágicos na fase *setup*, com validação de dígitos únicos (0 a 7).  
   
   - Alternância de turnos na fase *guess*, com exibição de "J1 GUESS" e "J2 GUESS" no display.  
3. **Cálculo de Touros e Vacas**:  

   - Feedback imediato após cada tentativa, exibindo o número de touros (TO) e vacas (VA) no display (ex: "1 TO 2 VA").  
   
   - Mensagem "BULLSEYE" ao acertar o número mágico, seguida de reinício do jogo.  
5. **Interface com Hardware**:  

   - Uso dos *toggle buttons* (SW[15:0]) para entrada de dados e *button* para confirmação.  
   
   - Exibição clara de mensagens no display de 8 segmentos, conforme as regras definidas.  

Um **vídeo de demonstração** está disponível no YouTube, ilustrando o funcionamento do jogo:  


## **Limitações e Desafios**  

- **Contagem de Vitórias via LEDs**: A funcionalidade de acender LEDs para indicar o número de vitórias de cada jogador não foi implementada devido a restrições de tempo e complexidade na sincronização entre estados do jogo e atualização dos LEDs.  

- **Atraso na Entrega**: O trabalho está sendo entregue com **um dia de atraso**, decorrente de desafios técnicos na depuração da máquina de estados e na integração do display.  

## **Análise de Desempenho**  
- **Estabilidade**: O sistema opera sem travamentos, garantindo transições suaves entre os estados (setup, guess, display).  

- **Resposta a Entradas**: Os sinais dos botões são debounced adequadamente, evitando leituras falsas.  

- **Display**: Mensagens são exibidas graças ao driver `dspl_drv_NexysA7` integrado.
  
# **Conclusão**  
Apesar da ausência da contagem de vitórias via LEDs, o núcleo do jogo foi implementado com sucesso, atendendo às regras especificadas. O atraso na entrega reflete as dificuldades enconttradas pelo grupo. O vídeo de demonstração comprova a operacionalidade do projeto, destacando a interação intuitiva entre jogadores e hardware.
