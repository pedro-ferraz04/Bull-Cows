module bullsCows (
  input logic [15:0] guess,
  input logic confirm,
  input logic clock,
  input logic reset,
  output logic state,
  output logic [3:0] bulls,
  output logic [3:0] cows
  );

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

state_t current_state;

logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed;
logic win_flag; // <- Achei mais facil pensar desse jeito


// TODO assign win_flag = (state == WIN);

always @(posedge clock or posedge reset) begin
  if (reset) begin
    current_state <= SECRET_J1;
  end else begin
    case (state)
      SECRET_J1: begin
        if (confirmed) begin
          secret_j1 <= guess_i;
          confirmed <= 0;
          current_state <= SECRET_J2;
        end
      end

      SECRET_J2: begin
        if (confirmed) begin
          secret_j2 <= guess_i;
          confirmed <= 0;
          current_state <= GUESS_J1;
        end
      end

      GUESS_J1: begin
        current_state <= GUESS_J1;
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
            current_state <= WIN_J1;
          end else begin 
            current_state <= DISPLAY_RESULT;
          end

          confirmed <= 0;
        end
      end

      GUESS_J2: begin
        current_state <= GUESS_J2;
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
            current_state <= WIN_J2;
          end else begin 
            current_state <= DISPLAY_RESULT;
          end

          confirmed <= 0;
        end
      end

      DISPLAY_RESULT: begin

        if (confirmed) begin
          current_state <= SECRET_J1;
          confirmed <= 0;
        end
      end

      WIN_J1: begin

        if (confirmed) begin
          current_state <= SECRET_J1;
          confirmed <= 0;
        end
      end

      WIN_J2: begin

        if (confirmed) begin
          current_state <= SECRET_J1;
          confirmed <= 0;
        end
      end

    endcase
  end
end

//always_comb begin
  //logic [15:0] currentSecret;
  //case (state)
    //GUESS_J1: currentSecret = secret_j2;
    //GUESS_J2: currentSecret = secret_j1;
    //default: currentSecret = 16'h0000;
  //endcase
//
  //logic [3:0] bullsTemp, cowsTemp;
  //logic [3:0] guessMaks, secretMask;
//end

always_ff @(posedge confirm) begin
  if (~confirmed) begin
    guess_i <= guess;
    confirmed <= 1;
  end
end

endmodule
