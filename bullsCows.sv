typedef enum logic {
  SECRET_J1,
  SECRET_J2,
  GUESS_J1,
  GUESS_J2,
  DISPLAY_RESULT_J1,
  DISPLAY_RESULT_J2,
  WIN,
  FIM
} state_t;

module BullsCows (
  input [15:0] guess,
  input confirm,
  input clock,
  input reset,
  output state_t state
  );

state_t next_state;
logic [3:0] bulls, cows;
logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed;
// logic [63:0] bullseye := 64'b11111111; <- Não sei pq isso ta aqui
logic win_flag; // <- Achei mais facil pensar desse jeito

//  8 1's para o b

assign win_flag = (state == WIN);

always @(posedge clock or posedge reset) begin
  if (reset) begin
    state <= SECRET_J1;
  end else begin
    state <= next_state;
    case (state)
      SECRET_J1: begin
        if (confirmed) begin
          secret_j1 <= guess_i;
          secret_j1_reg <= secret_j1;
          confirmed <= 0;
          state <= SECRET_J2;
        end
      end

      SECRET_J2: begin
        if (confirmed) begin
          secret_j2 <= guess_i;
          secret_j2_reg <= secret_j2;
          confirmed <= 0;
          state <= GUESS_J1;
        end
      end

      GUESS_J1: begin
        next_state <= GUESS_J1;
        if (confirmed) begin
          bulls <= 000;

          if (guess_i[3:0] == secret_j2[3:0]) begin
            bulls <= bulls + 1;
          end
          if (guess_i[7:4] == secret_j2[7:4]) begin
            bulls <= bulls + 1;
          end
          if (guess_i[11:8] == secret_j2[11:8]) begin
            bulls <= bulls + 1;
          end
          if (guess_i[15:12] == secret_j2[15:12]) begin
            bulls <= bulls + 1;
          end

          cows <= 000;

          if (guess_i[3:0] == secret_j2[7:4] || guess_i[3:0] == secret_j2[11:8] || guess_i[3:0] == secret_j2[15:12]) begin
            cows <= cows + 1;
          end
          if (guess_i[7:4] == secret_j2[3:0] || guess_i[7:4] == secret_j2[11:8] || guess_i[7:4] == secret_j2[15:12]) begin
            cows <= cows + 1;
          end
          if (guess_i[11:8] == secret_j2[3:0] || guess_i[11:8] == secret_j2[7:4] || guess_i[11:8] == secret_j2[15:12]) begin
            cows <= cows + 1;
          end
          if (guess_i[15:12] == secret_j2[3:0] || guess_i[15:12] == secret_j2[7:4] || guess_i[15:12] == secret_j2[11:8]) begin
            cows <= cows + 1;
          end

          if (bulls == 3'b100) begin
            next_state <= WIN;
          end else begin 
            next_state <= DISPLAY_RESULT_J1;
          end

          confirmed <= 0;
        end
      end

      GUESS_J2: begin
        next_state <= GUESS_J2;
        if (confirmed) begin
          bulls <= 000;

          if (guess_i[3:0] == secret_j1[3:0]) begin
            bulls <= bulls + 1;
          end
          if (guess_i[7:4] == secret_j1[7:4]) begin
            bulls <= bulls + 1;
          end
          if (guess_i[11:8] == secret_j1[11:8]) begin
            bulls <= bulls + 1;
          end
          if (guess_i[15:12] == secret_j1[15:12]) begin
            bulls <= bulls + 1;
          end

          cows <= 000;

          if (guess_i[3:0] == secret_j1[7:4] || guess_i[3:0] == secret_j1[11:8] || guess_i[3:0] == secret_j1[15:12]) begin
            cows <= cows + 1;
          end
          if (guess_i[7:4] == secret_j1[3:0] || guess_i[7:4] == secret_j1[11:8] || guess_i[7:4] == secret_j1[15:12]) begin
            cows <= cows + 1;
          end
          if (guess_i[11:8] == secret_j1[3:0] || guess_i[11:8] == secret_j1[7:4] || guess_i[11:8] == secret_j1[15:12]) begin
            cows <= cows + 1;
          end
          if (guess_i[15:12] == secret_j1[3:0] || guess_i[15:12] == secret_j1[7:4] || guess_i[15:12] == secret_j1[11:8]) begin
            cows <= cows + 1;
          end

          if (bulls == 3'b100) begin
            next_state <= WIN;
          end else begin 
            next_state <= DISPLAY_RESULT_J2;
          end

          confirmed <= 0;
        end
      end
    end
  end

      DISPLAY_RESULT_J1: begin
        next_state <= DISPLAY_RESULT_J1;

        if (confirmed) begin
          next_state <= GUESS_J2;
          confirmed <= 0;
        end
      end

      DISPLAY_RESULT_J2: begin
        next_state <= DISPLAY_RESULT_J2;

        if (confirmed) begin
          next_state <= GUESS_J1;
          confirmed <= 0;
        end
      end

      WIN: begin
        next_state <= WIN;

        if (confirmed) begin
          next_state <= SECRET_J1;
          confirmed <= 0;
        end
      end

      FIM: begin
        // Logica para quando alguem fizer 4 pontos
        // Ou seja, quando alguem ganhar
      end

always_comb begin
  logic [15:0] currentSecret;
  case (state)
    GUESS_J1: currentSecret = secret_j2;
    GUESS_J2: currentSecret = secret_j1;
    default: currentSecret = 16'h0000;
  endcase

  logic [3:0] bullsTemp, cowsTemp;
  logic [3:0] guessMaks, secretMask;

  
end

    always_ff @(posedge confirm) begin
      if (~confirmed) begin
        guess_i <= guess;
        confirmed <= 1;
      end
    end

endmodule