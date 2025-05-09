module BullsCows (
    input [15:0] guess,
    input confirm,
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
    logic [15:0] secret_j1, secret_j2;
    logic [15:0] guess_i;
    logic confirmed;



    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= SECRET_J1;
        end else begin
            state <= next_state;
            case (state)
                SECRET_J1: begin
                    if (confirmed) begin
                        if (guess_i == not~(guess_i[15:12] ^ guess_i[11:8] ^ guess_i[7:4] ^ guess_i[3:0])) begin
                            secret_j1 <= guess_i;
                            next_state <= SECRET_J2;
                    end
                    confirmed <= 0;
                end
                SECRET_J2: begin
                    secret_j2 <= guess_i;
                end
                GUESS_J1: begin
                    guess_j1 <= guess_i;
                end
                GUESS_J2: begin
                    guess_j2 <= guess_i;
                end
            endcase
        end
    end

    always_ff @(posedge confirm) begin
        guess_i <= guess;
        confirmed <= 1;
    end

endmodule