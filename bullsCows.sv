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
    output logic [5:0] d8,

    output logic [7:0] j1_count,
    output logic [7:0] j2_count
  );

  typedef enum {
      SECRET_J1,
      SECRET_J2,
      GUESS_J1,
      GUESS_J2,
      DISPLAY,
      FIM
  } state_t;

state_t current_state;

logic [2:0] bulls, cows;

logic [7:0] aux;

logic [15:0] secret_j1, secret_j2;
logic [15:0] guess_i;
logic confirmed, jogador;

logic btn_prev, btn_tick;
  always @(posedge clock) begin
    // detecta borda de subida
    btn_tick <= confirm & ~btn_prev;
    btn_prev <= confirm;
  end

  function automatic repetidos(input logic [15:0] arr);
    logic [3:0] num0, num1, num2, num3;

    num0 = arr[3:0];
    num1 = arr[7:4];
    num2 = arr[11:8];
    num3 = arr[15:12];

    if (num0 == num1 || num0 == num2 || num0 == num3 ||
        num1 == num2 || num1 == num3 || num2 == num3) begin
      return 1'b1;
    end else begin
      return 1'b0;
    end

  endfunction

  always @(posedge clock , posedge reset) begin
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
            //if (repetidos(secret_j1)) begin
              current_state <= SECRET_J2;
            //end
            confirmed <= 0;
          end
        end

        SECRET_J2: begin
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101; // J2 Se7up
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100101; d8 <= 6'b110111;
          if (confirmed) begin
            secret_j2 <= guess_i;
            if (repetidos(secret_j2)) begin
              current_state <= GUESS_J1;
            end
            confirmed <= 0;
          end
        end

        GUESS_J1: begin
          d1 <= 6'b000000; d2 <= 6'b000000; d3 <= 6'b000000; d4 <= 6'b000000; // J1
          d5 <= 6'b000000; d6 <= 6'b000000; d7 <= 6'b100011; d8 <= 6'b110111;
          if (confirmed) begin
            guess_i <= guess;

            if (guess_i[3:0] == secret_j2[3:0]) begin
              bulls++;
            end
            if (guess_i[7:4] == secret_j2[7:4]) begin
              bulls++;
            end
            if (guess_i[11:8] == secret_j2[11:8]) begin
              bulls++;
            end
            if (guess_i[15:12] == secret_j2[15:12]) begin
              bulls++;
            end

            if (guess_i[3:0] == secret_j2[7:4] || guess_i[3:0] == secret_j2[11:8] || guess_i[3:0] == secret_j2[15:12]) begin
              cows++;
            end
            if (guess_i[7:4] == secret_j2[3:0] || guess_i[7:4] == secret_j2[11:8] || guess_i[7:4] == secret_j2[15:12]) begin
              cows++;
            end
            if (guess_i[11:8] == secret_j2[3:0] || guess_i[11:8] == secret_j2[7:4] || guess_i[11:8] == secret_j2[15:12]) begin
              cows++;
            end
            if (guess_i[15:12] == secret_j2[3:0] || guess_i[15:12] == secret_j2[7:4] || guess_i[15:12] == secret_j2[11:8]) begin
              cows++;
            end

            if (bulls == 3'b100) begin
              aux <= j1_count << 1;
              j1_count <= aux;
              j1_count++;
              current_state <= FIM;
            end else begin 
              jogador <= 0;
              current_state <= DISPLAY;
            end

            confirmed <= 0;
          end
        end

        GUESS_J2: begin
          d1 <= 6'b000000; d2 <= 6'b000000; d3 <= 6'b000000; d4 <= 6'b000000; // J2
          d5 <= 6'b000000; d6 <= 6'b000000; d7 <= 6'b100101; d8 <= 6'b110111;
          if (confirmed) begin
            guess_i <= guess;

            if (guess_i[3:0] == secret_j1[3:0]) begin
              bulls++;
            end
            if (guess_i[7:4] == secret_j1[7:4]) begin
              bulls++;
            end
            if (guess_i[11:8] == secret_j1[11:8]) begin
              bulls++;
            end
            if (guess_i[15:12] == secret_j1[15:12]) begin
              bulls++;
            end

            if (guess_i[3:0] == secret_j1[7:4] || guess_i[3:0] == secret_j1[11:8] || guess_i[3:0] == secret_j1[15:12]) begin
              cows++;
            end
            if (guess_i[7:4] == secret_j1[3:0] || guess_i[7:4] == secret_j1[11:8] || guess_i[7:4] == secret_j1[15:12]) begin
              cows++;
            end
            if (guess_i[11:8] == secret_j1[3:0] || guess_i[11:8] == secret_j1[7:4] || guess_i[11:8] == secret_j1[15:12]) begin
              cows++;
            end
            if (guess_i[15:12] == secret_j1[3:0] || guess_i[15:12] == secret_j1[7:4] || guess_i[15:12] == secret_j1[11:8]) begin
              cows++;
            end

            if (bulls == 3'b100) begin
              aux <= j2_count << 1;
              j2_count <= aux;
              j2_count++;

              current_state <= FIM;
            end else begin 
              jogador <= 1;
              current_state <= DISPLAY;

            end

            confirmed <= 0;
          end
        end

        DISPLAY: begin
              d1 <= 6'b110101;
              d2 <= 6'b111001;
              d3 <= 6'b000000;
              d4 <= {2'b10, cows, 1'b1}; // "X" Cows "{anodeOn=1, bulls, DP=1}"
              d5 <= 6'b100001;
              d6 <= 6'b101111;
              d7 <= 6'b000000;
              d8 <= {2'b10, bulls, 1'b1}; // "X" Bulls "{anodeOn=1, bulls, DP=1}"
          if (confirmed) begin
            bulls <= 0;
            cows <= 0;
            if (~(jogador == 1)) begin
              current_state <= GUESS_J1;
              d1 <= 6'b000000; d2 <= 6'b000000; d3 <= 6'b000000; d4 <= 6'b000000; // J1
              d5 <= 6'b000000; d6 <= 6'b000000; d7 <= 6'b100011; d8 <= 6'b110111; 
            end else begin
              current_state <= GUESS_J2;
              d1 <= 6'b000000; d2 <= 6'b000000; d3 <= 6'b000000; d4 <= 6'b000000; // J2
              d5 <= 6'b000000; d6 <= 6'b000000; d7 <= 6'b100101; d8 <= 6'b110111;
            end
          end
        end

        FIM: begin
          d1 <= 6'b111101; d2 <= 6'b101001; d3 <= 6'b111101; d4 <= 6'b101011;
          d5 <= 6'b110011; d6 <= 6'b110011; d7 <= 6'b111001; d8 <= 6'b110001; // bullseye
          if (confirmed) begin
            current_state <= SECRET_J1;
            d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101; // J1 Se7up
            d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
          end
        end

      endcase
    end
  end
endmodule
