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

  function automatic [2:0] count_bulls(input logic [15:0] guess, input logic [15:0] secret);
    logic [3:0] num0, num1, num2, num3;
    logic [2:0] bulls;

    num0 = guess[3:0];
    num1 = guess[7:4];
    num2 = guess[11:8];
    num3 = guess[15:12];

    bulls = 0;
    if (num0 == secret[3:0]) bulls = bulls + 1;
    if (num1 == secret[7:4]) bulls = bulls + 1;
    if (num2 == secret[11:8]) bulls = bulls + 1;
    if (num3 == secret[15:12]) bulls = bulls + 1;

    return bulls;
  endfunction

  function automatic [2:0] count_cows(input logic [15:0] guess, input logic [15:0] secret);
    logic [3:0] g0, g1, g2, g3;
    logic [3:0] s0, s1, s2, s3;
    logic [2:0] cows;
    logic bull0, bull1, bull2, bull3;

    g0 = guess[3:0];
    g1 = guess[7:4];
    g2 = guess[11:8];
    g3 = guess[15:12];

    s0 = secret[3:0];
    s1 = secret[7:4];
    s2 = secret[11:8];
    s3 = secret[15:12];

    bull0 = (g0 == s0);
    bull1 = (g1 == s1);
    bull2 = (g2 == s2);
    bull3 = (g3 == s3);

    cows = 0;

    if (!bull0 && (g0 == s1 || g0 == s2 || g0 == s3)) cows += 1;
    if (!bull1 && (g1 == s0 || g1 == s2 || g1 == s3)) cows += 1;
    if (!bull2 && (g2 == s0 || g2 == s1 || g2 == s3)) cows += 1;
    if (!bull3 && (g3 == s0 || g3 == s1 || g3 == s2)) cows += 1;

    return cows;
  endfunction

  always @(posedge clock , posedge reset) begin
    if (reset) begin
      current_state <= SECRET_J1;
      d1 <= 6'b100001; d2 <= 6'b100001; d3 <= 6'b100001; d4 <= 6'b100001;
      d5 <= 6'b100001; d6 <= 6'b100001; d7 <= 6'b100001; d8 <= 6'b100001;
      j1_count <= 0;
      j2_count <= 0;
      bulls <= 0;
      cows <= 0;
      secret_j1 <= 0;
      secret_j2 <= 0;
      confirmed <= 0;
      jogador <= 0;
    end else begin
      case (current_state)
        SECRET_J1: begin
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101;
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100011; d8 <= 6'b110111;
          if (btn_tick) begin
            if (repetidos(guess)) begin
              d1 <= 6'b100001; d2 <= 6'b100001; d3 <= 6'b100001; d4 <= 6'b100001;
              d5 <= 6'b100001; d6 <= 6'b100001; d7 <= 6'b100001; d8 <= 6'b100001;
            end else begin
              secret_j1 <= guess;
              current_state <= SECRET_J2;
            end
          end
        end

        SECRET_J2: begin
          d1 <= 6'b111011; d2 <= 6'b111001; d3 <= 6'b101111; d4 <= 6'b111101;
          d5 <= 6'b101011; d6 <= 6'b000001; d7 <= 6'b100101; d8 <= 6'b110111;
          if (btn_tick) begin
            if (repetidos(guess)) begin
              d1 <= 6'b100001; d2 <= 6'b100001; d3 <= 6'b100001; d4 <= 6'b100001;
              d5 <= 6'b100001; d6 <= 6'b100001; d7 <= 6'b100001; d8 <= 6'b100001;
            end else begin
              secret_j2 <= guess;
              current_state <= GUESS_J1;
            end
          end
        end

        GUESS_J1: begin
          d1 <= 6'b000000; d2 <= 6'b000000; d3 <= 6'b000000; d4 <= 6'b000000;
          d5 <= 6'b000000; d6 <= 6'b000000; d7 <= 6'b100011; d8 <= 6'b110111;
          if (btn_tick) begin
          // Usar variáveis temporárias para calcular Bulls e Cows
            logic [2:0] current_bulls, current_cows;
              current_bulls = count_bulls(guess, secret_j2);
                      current_cows = count_cows(guess, secret_j2);

            // Atribuir aos sinais (para exibição)
            bulls <= current_bulls;
            cows <= current_cows;

            // Comparar o valor IMEDIATO (current_bulls)
            if (current_bulls == 3'b100) begin // 4 em binário (3 bits)
              j1_count <= j1_count + 1;
              current_state <= FIM;
            end else begin 
              jogador <= 0;
              current_state <= DISPLAY;
            end
          end
        end

        GUESS_J2: begin
          d1 <= 6'b000000; d2 <= 6'b000000; d3 <= 6'b000000; d4 <= 6'b000000;
          d5 <= 6'b000000; d6 <= 6'b000000; d7 <= 6'b100101; d8 <= 6'b110111;
          if (btn_tick) begin
            // Usar variáveis temporárias
            logic [2:0] current_bulls, current_cows;
            current_bulls = count_bulls(guess, secret_j1);
            current_cows = count_cows(guess, secret_j1);
        
            bulls <= current_bulls;
            cows <= current_cows;
        
            if (current_bulls == 3'b100) begin // 4 em binário
              j2_count <= j2_count + 1;
              current_state <= FIM;
            end else begin
              jogador <= 1;
              current_state <= DISPLAY;
            end
          end
        end

        DISPLAY: begin
          d1 <= 6'b110101;
          d2 <= 6'b111001;
          d3 <= 6'b000000;
          d4 <= {2'b10, cows, 1'b1};
          d5 <= 6'b100001;
          d6 <= 6'b101111;
          d7 <= 6'b000000;
          d8 <= {2'b10, bulls, 1'b1};
          if (btn_tick) begin
            bulls <= 0;
            cows <= 0;
            current_state <= !jogador ? GUESS_J2 : GUESS_J1;
          end
        end

        FIM: begin
          d1 <= 6'b111101; d2 <= 6'b101001; d3 <= 6'b111101; d4 <= 6'b101011;
          d5 <= 6'b110011; d6 <= 6'b110011; d7 <= 6'b111001; d8 <= 6'b110001;
          if (btn_tick) begin
            current_state <= SECRET_J1;
          end
        end
      endcase
    end
  end
endmodule