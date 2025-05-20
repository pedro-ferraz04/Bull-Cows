module bullsCows (
  input logic [15:0] guess,
  input logic confirm,
  input logic clock,
  input logic reset,

  output logic [5:0] d1,
  output logic [5:0] d2,
  output logic [5:0] d3,
  output logic [5:0] d4,
  output logic [5:0] d5,
  output logic [5:0] d6,
  output logic [5:0] d7,
  output logic [5:0] d8
  );

  typedef enum {
    SECRET_J1,
    SECRET_J2,
    GUESS_J1,
    GUESS_J2,
    WIN
  } state_t;

  state_t current_state;

  logic [15:0] secret_j1, secret_j2;
  logic [3:0] bulls, cows;
  logic confirmed = confirm;
  

  always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
      current_state <= SECRET_J1;
        d1 <= 6'b100000;
        d2 <= 6'b100000;
        d3 <= 6'b100000;
        d4 <= 6'b100000;
        d5 <= 6'b100000;
        d6 <= 6'b100000;
        d7 <= 6'b100000;
        d8 <= 6'b100000;
    end else begin
      if (confirmed) begin
        case (current_state)
          SECRET_J1: begin
              secret_j1 <= guess;
              d1 <= 6'b001011; // "J"
              d2 <= 6'b000001; // "1"
              d3 <= 6'b100000; // " "
              d4 <= 6'b000101; // "S"
              d5 <= 6'b001110; // "E"
              d6 <= 6'b000111; // "T"
              d7 <= 6'b001100; // "U"
              d8 <= 6'b001101; // "P"
              confirmed <= 1'b0;
              current_state <= SECRET_J2;
          end

          SECRET_J2: begin
              secret_j2 <= guess;
              d1 <= 6'b001011; // "J"
              d2 <= 6'b000010; // "2"
              d3 <= 6'b100000; // " "
              d4 <= 6'b000101; // "S"
              d5 <= 6'b001110; // "E"
              d6 <= 6'b000111; // "T"
              d7 <= 6'b001100; // "U"
              d8 <= 6'b001101; // "P"
              confirmed <= 1'b0;
              current_state <= GUESS_J1;
          end

          GUESS_J1: begin
              bulls <= 3'b000;

              if (guess[3:0] == secret_j2[3:0]) begin
                bulls <= bulls + 1;
              end
              if (guess[7:4] == secret_j2[7:4]) begin
                bulls <= bulls + 1;
              end
              if (guess[11:8] == secret_j2[11:8]) begin
                bulls <= bulls + 1;
              end
              if (guess[15:12] == secret_j2[15:12]) begin
                bulls <= bulls + 1;
              end

              cows <= 3'b000;

              if (guess[3:0] == secret_j2[7:4] || guess[3:0] == secret_j2[11:8] || guess[3:0] == secret_j2[15:12]) begin
                cows <= cows + 1;
              end
              if (guess[7:4] == secret_j2[3:0] || guess[7:4] == secret_j2[11:8] || guess[7:4] == secret_j2[15:12]) begin
                cows <= cows + 1;
              end
              if (guess[11:8] == secret_j2[3:0] || guess[11:8] == secret_j2[7:4] || guess[11:8] == secret_j2[15:12]) begin
                cows <= cows + 1;
              end
              if (guess[15:12] == secret_j2[3:0] || guess[15:12] == secret_j2[7:4] || guess[15:12] == secret_j2[11:8]) begin
                cows <= cows + 1;
              end

              d1 <= {1'b0, bulls[3:0], 1'b0}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
              d2 <= 6'b100000;                // " " 
              d3 <= 6'b000111;                // "T"
              d4 <= 6'b000000;                // "O"
              d5 <= {1'b0, cows[3:0], 1'b0};  // "X" Cows "{anodeOff=0, cows, DP=0}
              d6 <= 6'b100000;                // " "
              d7 <= 6'b001100;                // "V"
              d8 <= 6'b001010;                // "A"

              if (bulls == 3'b100) begin
                confirmed <= 1'b0;
                current_state <= WIN;
              end else begin 
                confirmed <= 1'b0;
                current_state <= GUESS_J2;
              end
          end

          GUESS_J2: begin
              bulls <= 3'b000;

              if (guess[3:0] == secret_j1[3:0]) begin
                bulls <= bulls + 1;
              end
              if (guess[7:4] == secret_j1[7:4]) begin
                bulls <= bulls + 1;
              end
              if (guess[11:8] == secret_j1[11:8]) begin
                bulls <= bulls + 1;
              end
              if (guess[15:12] == secret_j1[15:12]) begin
                bulls <= bulls + 1;
              end

              cows <= 3'b000;

              if (guess[3:0] == secret_j1[7:4] || guess[3:0] == secret_j1[11:8] || guess[3:0] == secret_j1[15:12]) begin
                cows <= cows + 1;
              end
              if (guess[7:4] == secret_j1[3:0] || guess[7:4] == secret_j1[11:8] || guess[7:4] == secret_j1[15:12]) begin
                cows <= cows + 1;
              end
              if (guess[11:8] == secret_j1[3:0] || guess[11:8] == secret_j1[7:4] || guess[11:8] == secret_j1[15:12]) begin
                cows <= cows + 1;
              end
              if (guess[15:12] == secret_j1[3:0] || guess[15:12] == secret_j1[7:4] || guess[15:12] == secret_j1[11:8]) begin
                cows <= cows + 1;
              end

              d1 <= {1'b0, bulls[3:0], 1'b0}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
              d2 <= 6'b100000;                // " " 
              d3 <= 6'b000111;                // "T"
              d4 <= 6'b000000;                // "O"
              d5 <= {1'b0, cows[3:0], 1'b0};  // "X" Cows "{anodeOff=0, cows, DP=0}
              d6 <= 6'b100000;                // " "
              d7 <= 6'b001100;                // "V"
              d8 <= 6'b001010;                // "A"

              if (bulls == 3'b100) begin
                confirmed <= 1'b0;
                current_state <= WIN;
              end else begin 
                confirmed <= 1'b0;
                current_state <= GUESS_J1;
              end
          end

          WIN: begin
              confirmed <= 1'b0;
              current_state <= SECRET_J1;
          end
        endcase
      end
    end 
endmodule
