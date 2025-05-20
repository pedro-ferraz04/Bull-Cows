// Fazer fsm corretamente (EA e PE)

module bullsCows (
  input logic [15:0] guess,
  input logic confirm,
  input logic clock,
  input logic reset,
  output logic [2:0] state,
  output logic [3:0] bulls,
  output logic [3:0] cows
  );

typedef enum {
  SECRET_J1,
  SECRET_J2,
  GUESS_J1,
  GUESS_J2,
  DISPLAY_RESULT_J1,
  DISPLAY_RESULT_J2,
  WIN
} state_t;

state_t current_state;

logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed;

always_ff @(posedge confirm or posedge reset) begin
  if (reset) begin
    confirmed <= 1'b0;
    guess_i <= 16'd0;
    end
  
  if (confirm) begin
    guess_i <= guess;
    confirmed <= 1'b1;
  end
end

always_ff @(posedge clock or posedge reset) begin
  if (reset) begin
    current_state <= SECRET_J1;
  end else begin
    case (current_state)
      SECRET_J1: begin
        if (confirmed) begin
          secret_j1 <= guess_i;
          confirmed <= 1'b0;
          current_state <= SECRET_J2;
        end
      end

      SECRET_J2: begin
        if (confirmed) begin
          secret_j2 <= guess_i;
          confirmed <= 1'b0;
          current_state <= GUESS_J1;
        end
      end

      GUESS_J1: begin
        if (confirmed) begin
          bulls <= 3'b000;

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

          cows <= 3'b000;

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
            current_state <= WIN;
          end else begin 
            current_state <= GUESS_J2;
          end

          confirmed <= 0;
        end
      end

      GUESS_J2: begin
        if (confirmed) begin
          bulls <= 3'b000;

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

          cows <= 3'b000;

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

          confirmed <= 0;

          if (bulls == 3'b100) begin
            current_state <= WIN;
          end else begin 
            current_state <= GUESS_J1;
          end

        end
      end

      WIN: begin

        if (confirmed) begin
          confirmed <= 0;
          current_state <= SECRET_J1;
        end
      end
    endcase
  end
end
endmodule
