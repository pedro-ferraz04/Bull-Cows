module display_manager(
    input logic clock,
    input logic reset,
    input logic confirm,
    input logic current_state,

    output logic [5:0] d1,
    output logic [5:0] d2,
    output logic [5:0] d3,
    output logic [5:0] d4,
    output logic [5:0] d5,
    output logic [5:0] d6,
    output logic [5:0] d7,
    output logic [5:0] d8
);

    logic btn_prev, btn_tick;
    always @(posedge clock) begin
            // detecta borda de subida
            btn_tick <= confirm & ~btn_prev;
            btn_prev <= confirm;
    end
    
    logic confirmed;
    always @(posedge clock) begin
        if (btn_tick) begin
            confirmed <= ~confirmed;
        end
    end

  typedef enum {
      IDLE,
      SECRET_J1,
      SECRET_J2,
      GUESS_J1,
      GUESS_J2,
      WIN_J1,
      WIN_J2,
      DISPLAY_RESULT
  } state_t;

    always @(posedge clock) begin
      case(current_state)
          IDLE: begin
            d1 <= 6'b100011; d2 <= 6'b100011; d3 <= 6'b100011; d4 <= 6'b100011;
            d5 <= 6'b100011; d6 <= 6'b100011; d7 <= 6'b100011; d8 <= 6'b100011;
          end

          SECRET_J1: begin
            d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101;
            d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
          end

          SECRET_J2: begin
            d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101;
            d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100101; d8 <= 6'b110111;
          end

          GUESS_J1: begin
            d1 <= 6'b100011; d2 <= 6'b100011; d3 <= 6'b100011; d4 <= 6'b100011;
            d5 <= 6'b100011; d6 <= 6'b100011; d7 <= 6'b100011; d8 <= 6'b110111;
          end

          GUESS_J2: begin
            d1 <= 6'b100011; d2 <= 6'b100011; d3 <= 6'b100011; d4 <= 6'b100011;
            d5 <= 6'b100011; d6 <= 6'b100011; d7 <= 6'b100101; d8 <= 6'b110111;
          end
      //WIN_J1,
      //WIN_J2,
      //DISPLAY_RESULT
      endcase
    end
endmodule
