module display_manager(
    input logic clock,
    input logic reset,
    input logic confirm,

    output logic [5:0] d1,
    output logic [5:0] d2,
    output logic [5:0] d3,
    output logic [5:0] d4,
    output logic [5:0] d5,
    output logic [5:0] d6,
    output logic [5:0] d7,
    output logic [5:0] d8
);
    
    logic confirmed;
    detector_borda db (
        .clock(clock),
        .reset(reset),
        .confirm(confirm),
        .borda_subida(confirmed)
    );
    
    typedef enum {
        IDLE,
        SECRET_J1,
        SECRET_J2,
        GUESS_J1,
        GUESS_J2,
        WIN
    } state_t;

    state_t current_state;
    
    logic [15:0] secret_j1, secret_j2;
    logic [2:0] bulls, cows;
    
    always @(posedge clock or posedge reset) begin
    
        if (reset) begin
            current_state <= IDLE;
            secret_j1 <= 0;
            secret_j2 <= 0;
            bulls <= 0;
            cows <= 0;
        
        end else begin
            case(current_state)
                IDLE: begin
                    d1 <= 6'b100001; d2 <= 6'b100001; d3 <= 6'b100001; d4 <= 6'b100001;
                    d5 <= 6'b100001; d6 <= 6'b100001; d7 <= 6'b100001; d8 <= 6'b100001;
                    current_state <= SECRET_J1;
                end
                SECRET_J1: begin
                    d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101;
                    d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
                    current_state <= SECRET_J2;
                end
                
                SECRET_J2: begin
                    d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101;
                    d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100101; d8 <= 6'b110111;
                    current_state <= SECRET_J1;
                end
            endcase
        end
    end
endmodule