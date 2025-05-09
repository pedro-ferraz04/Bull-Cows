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
logic [3:0] bulls, cows;
logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed;
logic [63:0] bullseye := 64'b11111111

-- 8 1's para o b


always_ff @(posedge clock , posedge reset) begin
  if (reset) begin
    state <= SECRET_J1;
  end else begin
    state <= next_state;
    case (state)
      SECRET_J1: begin
        if (confirmed) begin
          secret_j1 <= guess_i
          confirmed <= 0;
          state <= SECRET_J2;
        end
      end

      SECRET_J2: begin
        if (confirmed) begin
          secret_j1 <= guess_i
          confirmed <= 0;
          state <= GUESS_J1;
        end
      end

      GUESS_J1: begin
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

          if (bulls == 3`b100) begin
            -- YAAAAAAAAAAA
          end else begin 
            -- imprimi
          end

          state <= GUESS_J2;
        end
      end

      GUESS_J2: begin
        guess_j2 <= guess_i;
      end

      FIM: begin
      end
    endcase
  end
end

    always_ff @(posedge confirm) begin
      if (~confirmed) begin
        guess_i <= guess;
        confirmed <= 1;
      end
    end

endmodule
