typedef enum {
    SECRET_J1,
    SECRET_J2,
    GUESS_J1,
    GUESS_J2,
    DISPLAY_RESULT_J1,
    DISPLAY_RESULT_J2,
    WIN,
    FIM
} state_t;

module display_manager(
    input logic clock,
    input logic reset,
    input state_t current_state,
    input logic win_flag,
    input logic [3:0] bulls,
    input logic [3:0] cows,

    output logic [5:0] d1,
    output logic [5:0] d2,
    output logic [5:0] d3,
    output logic [5:0] d4,
    output logic [5:0] d5,
    output logic [5:0] d6,
    output logic [5:0] d7,
    output logic [5:0] d8
);

    always @(posedge clock) begin // TODO reset
        
        d1 <= 6'b100000;
        d2 <= 6'b100000;
        d3 <= 6'b100000;
        d4 <= 6'b100000;
        d5 <= 6'b100000;
        d6 <= 6'b100000;
        d7 <= 6'b100000;
        d8 <= 6'b100000;

        case (current_state)
            SECRET_J1: begin
                d1 <= 6'b001011; // "J"
                d2 <= 6'b000001; // "1"
                d3 <= 6'b100000; // " "
                d4 <= 6'b000101; // "S"
                d5 <= 6'b001110; // "E"
                d6 <= 6'b000111; // "T"
                d7 <= 6'b001100; // "U"
                d8 <= 6'b001101; // "P"
            end

            SECRET_J2: begin
                d1 <= 6'b001011; // "J"
                d2 <= 6'b000010; // "2"
                d3 <= 6'b100000; // " "
                d4 <= 6'b000101; // "S"
                d5 <= 6'b001110; // "E"
                d6 <= 6'b000111; // "T"
                d7 <= 6'b001100; // "U"
                d8 <= 6'b001101; // "P"
            end

            GUESS_J1: begin
                d1 <= 6'b001011; // "J"
                d2 <= 6'b000001; // "1"
                d3 <= 6'b100000; // " "
                d4 <= 6'b000110; // "G"
                d5 <= 6'b001100; // "U"
                d6 <= 6'b001110; // "E"
                d7 <= 6'b000101; // "S"
                d8 <= 6'b000101; // "S"
            end

            GUESS_J2: begin
                d1 <= 6'b001011; // "J"
                d2 <= 6'b000010; // "2"
                d3 <= 6'b100000; // " "
                d4 <= 6'b000110; // "G"
                d5 <= 6'b001100; // "U"
                d6 <= 6'b001110; // "E"
                d7 <= 6'b000101; // "S"
                d8 <= 6'b000101; // "S"
            end

            DISPLAY_RESULT_J1: begin
                d1 <= {1'b0, bulls[3:0], 1'b0}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
                d2 <= 6'b100000;                // " " 
                d3 <= 6'b000111;                // "T"
                d4 <= 6'b000000;                // "O"
                d5 <= {1'b0, cows[3:0], 1'b0};  // "X" Cows "{anodeOff=0, cows, DP=0}
                d6 <= 6'b100000;                // " "
                d7 <= 6'b001100;                // "V"
                d8 <= 6'b001010;                // "A"
            end

            DISPLAY_RESULT_J2: begin
                d1 <= {1'b0, bulls[3:0], 1'b0}; // "X" Bulls "{anodeOff=0, bulls, DP=0}
                d2 <= 6'b100000;                // " " 
                d3 <= 6'b000111;                // "T"
                d4 <= 6'b000000;                // "O"
                d5 <= {1'b0, cows[3:0], 1'b0};  // "X" Cows "{anodeOff=0, cows, DP=0}
                d6 <= 6'b100000;                // " "
                d7 <= 6'b001100;                // "V"
                d8 <= 6'b001010;                // "A"
            end

            WIN: begin
                d1 <= 6'b001000; // "B"
                d2 <= 6'b001100; // "U"
                d3 <= 6'b001001; // "L"
                d4 <= 6'b001001; // "L"
                d5 <= 6'b000101; // "S"
                d6 <= 6'b001110; // "E"
                d7 <= 6'b000100; // "Y"
                d8 <= 6'b001110; // "E"
            end
            
            // FIM: begin
            // Se a gente quiser da para fazer uma mensagem de FIM
            // para quando um jogador chegar a 4 vitórias
        endcase
    end
endmodule