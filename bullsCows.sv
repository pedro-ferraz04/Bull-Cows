module BullsCows (
    input [16:0] guess,
    input clock,
    input reset
);
    
    typedef enum logic { 
        SECRET_J1,
        SECRET_J2,
        GUESS_J1,
        GUESS_J2,
        FIM
     } state_t;

    state_t state, next_state;
    logic [2:0] bulls, cows;
    logic [16:0] secret_j1, secret_j2;
    logic [16:0] guess_j1, guess_j2;


    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= SECRET_J1;
        end else begin
            state <= next_state;
            case (state)
                SECRET_J1: begin
                    secret_j1 <= guess;
                end
                SECRET_J2: begin
                    secret_j2 <= guess;
                end
                GUESS_J1: begin
                    guess_j1 <= guess;
                end
                GUESS_J2: begin
                    guess_j2 <= guess;
                end
        end
    end


endmodule