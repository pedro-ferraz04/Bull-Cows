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

//state_t current_state;
intial current_state = GUESS_J1;

logic [3:0] bulls, cows; // TODO range?

logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed;


always @(posedge clock or posedge reset) begin
  if (reset) begin
    current_state <= SECRET_J1; // reseta estados
    d1 <= 6'b100001; d2 <= 6'b100001; d3 <= 6'b100001; d4 <= 6'b100001; // zera displays
    d5 <= 6'b100001; d6 <= 6'b100001; d7 <= 6'b100001; d8 <= 6'b100001;
  end else begin
    case (current_state)
      SECRET_J1: begin
        if (confirmed) begin
          secret_j1 <= guess_i;
          confirmed <= 0;
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101; // J1 Se7up
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
          current_state <= SECRET_J2;
        end
      end

      SECRET_J2: begin
        if (confirmed) begin
          secret_j2 <= guess_i;
          confirmed <= 0;
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101; // J2 Se7up
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100101; d8 <= 6'b110111;
          current_state <= GUESS_J1;
        end
      end

      GUESS_J1: begin
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
            d1 <= 6'b100011; d2 <= 6'b110111; d3 <= 6'b111111; d4 <= 6'b100011;
            d5 <= 6'b110111; d6 <= 6'b111111; d7 <= 6'b100011; d8 <= 6'b110111;
            // TODO count
            current_state <= SECRET_J1;
          end else begin 
            d1 <= {1'b0, bulls[3:0], 1'b0}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
            d2 <= 6'b011001; // c (cows)
            d3 <= 6'b111111;
            d5 <= {1'b0, cows[3:0], 1'b0};  // "X" Cows "{anodeOff=0, cows, DP=0}
            d5 <= 6'b010111; // b
            d6 <= 6'b111111;
            d7 <= 6'b111111;
            d8 <= 6'b111111;
            current_state <= GUESS_J2;
          end

          d1 <= 6'b000001; d2 <= 6'b000001; d3 <= 6'b000001; d4 <= 6'b000001;
          d5 <= 6'b000001; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
          confirmed <= 0;
        end
      end

      GUESS_J2: begin
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
            d1 <= 6'b100101; d2 <= 6'b110111; d3 <= 6'b111111; d4 <= 6'b100101;
            d5 <= 6'b110111; d6 <= 6'b111111; d7 <= 6'b100101; d8 <= 6'b110111;
            // TODO count
            current_state <= SECRET_J1;
          end else begin 
            d1 <= {1'b0, bulls[3:0], 1'b0}; // "X" Bulls "{anodeOff=0, bulls, DP=0}"
            d2 <= 6'b011001; // c (cows)
            d3 <= 6'b111111;
            d5 <= {1'b0, cows[3:0], 1'b0};  // "X" Cows "{anodeOff=0, cows, DP=0}
            d5 <= 6'b010111; // b
            d6 <= 6'b111111;
            d7 <= 6'b111111;
            d8 <= 6'b111111;
            current_state <= GUESS_J1;
          end

          confirmed <= 0;
        end
      end

    endcase
  end
end


//always_ff @(posedge confirm) begin
  //if (~confirmed) begin
    //guess_i <= guess;
    //confirmed <= 1;
  //end
//end

  logic btn_prev, btn_tick;
  always @(posedge clock) begin
          // detecta borda de subida
          btn_tick <= confirm & ~btn_prev;
          btn_prev <= confirm;
  end
  
  always @(posedge clock) begin
      if (btn_tick) begin
          confirmed <= ~confirmed;
      end
  end


endmodule
