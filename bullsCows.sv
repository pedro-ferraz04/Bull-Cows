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
      GUESS_J2
  } state_t;

state_t current_state;
initial current_state = GUESS_J1;

logic [3:0] bulls, cows; // TODO range?

logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed;

logic btn_prev, btn_tick;
always @(posedge clock) begin
        // detecta borda de subida
        btn_tick <= confirm & ~btn_prev;
        btn_prev <= confirm;
end

  always @(posedge clock or posedge reset) begin
    if (btn_tick) begin
        confirmed <= ~confirmed;
    end

    if (reset) begin
      current_state <= SECRET_J1; // reseta estados
      d1 <= 6'b100001; d2 <= 6'b100001; d3 <= 6'b100001; d4 <= 6'b100001; // zera displays
      d5 <= 6'b100001; d6 <= 6'b100001; d7 <= 6'b100001; d8 <= 6'b100001;
    end else begin
      case (current_state)
        SECRET_J1: begin
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101; // J1 Se7up
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
          if (confirmed) begin
            secret_j1 <= guess_i;
            confirmed <= 0;
            current_state <= SECRET_J2;
          end
        end

        SECRET_J2: begin
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101; // J2 Se7up
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100101; d8 <= 6'b110111;
          if (confirmed) begin
            secret_j2 <= guess_i;
            confirmed <= 0;
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
              d1 <= 6'b100011; d2 <= 6'b110111; d3 <= 6'b000000; d4 <= 6'b100011;
              d5 <= 6'b110111; d6 <= 6'b000000; d7 <= 6'b100011; d8 <= 6'b110111; // J1 J1 J1
              // TODO count
              current_state <= SECRET_J1;
            end else begin 
              d1 <= {2'b10, bulls[2:0], 1'b1}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
              d2 <= 6'b111001; // V Vaca
              d3 <= 6'b000000;
              d4 <= {2'b10, cows[2:0], 1'b1};  // "X" Cows "{anodeOff=0, cows, DP=0}
              d5 <= 6'b101001; // B Bull
              d6 <= 6'b000000;
              d7 <= 6'b000000;
              d8 <= 6'b000000;
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

            if (bulls == 3'b100) begin
              d1 <= 6'b100101; d2 <= 6'b110111; d3 <= 6'b000000; d4 <= 6'b100101;
              d5 <= 6'b110111; d6 <= 6'b000000; d7 <= 6'b100101; d8 <= 6'b110111;
              // TODO count
              current_state <= SECRET_J1;
            end else begin 
              d1 <= {2'b10, bulls[2:0], 1'b1}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
              d2 <= 6'b111001; // V Vaca
              d3 <= 6'b000000;
              d4 <= {2'b10, cows[2:0], 1'b1};  // "X" Cows "{anodeOff=0, cows, DP=0}
              d5 <= 6'b101001; // B Bull
              d6 <= 6'b000000;
              d7 <= 6'b000000;
              d8 <= 6'b000000;
              current_state <= GUESS_J1;
            end

            confirmed <= 0;
          end
        end

      endcase
    end
  end
endmodule
