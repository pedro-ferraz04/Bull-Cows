# Bull-Cows
Trabalho 2 de Sistemas Digitais
Regras para a implementação:
● Bull & Cows é um jogo de adivinhação onde dois jogadores tentam adivinhar um número
secreto escolhido pelo jogador adversário. Ganha quem adivinhar o número primeiro.
● O jogo possui duas fases, chamadas de preparo (setup) e adivinhação (guess). Na fase de
escolha, cada um dos dois jogadores escolhe um número mágico. Sua implementação deve
permitir aos jogadores selecionar o número através dos 16 toggle buttons da placa, utilizando
um dos push buttons para confirmação. Ao iniciar o jogo, o display deverá mostrar "J1
SETUP". Assim que o primeiro jogador confirmar o número mágico, o display deverá mostrar
"J2 SETUP".
● Na fase de adivinhação, os jogadores alternam suas jogadas, em turnos. Em cada turno, o
jogador deve utilizar os toggle buttons para adivinhar o número escolhido pelo jogador oposto.
O display deverá mostrar "J1 GUESS" quando o turno atual pertencer ao primeiro jogador e
"J2 GUESS" quando o turno pertencer ao segundo jogador.
● As jogadas realizadas deverão ser confirmadas através de um dos push buttons. Assim que a
jogada for confirmada, o display deverá mostrar o número de vacas e touros; cada touro
corresponde a um número adivinhado na posição correta e cada vaca corresponde a um número
adivinhado na posição errada. Números que não fazem parte do número mágico não são
contabilizados. Se o jogador acertar o número mágico, o display deverá mostrar "BULLSEYE",
e a partida é finalizada. Exemplos de jogadas:
○ Número mágico: "1234"; jogada do oponente: "3267"; display: "1 TO 1 VA"
○ Número mágico: "1234"; jogada do oponente: "1267"; display: "2 TO 0 VA"
○ Número mágico: "1234"; jogada do oponente: "3407"; display: "0 TO 2 VA"
○ Número mágico: "1234"; jogada do oponente: "1234"; display: "BULLSEYE"
● Os números escolhidos, tanto na escolha inicial quanto nas adivinhações, devem possuir todos
dígitos entre 0 e 7. Para isso, serão necessários 4 bits para representar cada dígito, logo
utilizando os 16 toggle buttons da placa.
● Os números mágicos não podem repetir dígitos entre si. Caso ocorra, o jogador precisará digitar
um novo número mágico ou realizar uma nova escolha.
● Ao terminar uma partida, o número de vitórias dos jogadores deverá ser armazenado. Para cada
vitória do jogador primeiro jogador, um LED mais à esquerda da fileira de leds deverá ser
aceso. Se o segundo jogador ganhar, um led mais a direita deverá ser acesso. Na medida com
que as vitórias acontecerem, os leds deverão ser acendidos em direção ao centro da placa.
○ Exemplo: o primeiro jogador possui 3 vitórias e o segundo jogador possui 2 vitórias
