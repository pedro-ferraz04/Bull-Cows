module bullsCows_tb;
  
  parameter PERIOD = 10;


  logic [15:0] guess;
  logic confirm;
  logic clock;
  logic reset;

  always begin
    # (PERIOD / 2) clock = ~clock;
  end

  bullsCows u_bullsCows(
      .guess(guess),
      .confirm(confirm),
      .clock(clock),
      .reset(reset),

      .state(game_state),
      .bulls(bulls),
      .cows(cows)
  );

  initial begin
    //$display("Teste 1 ");
    @(posedge clock); #1 guess   = 16'b0000111100110101; // senha j1
    @(posedge clock); #1 confirm = 1'b1;
    @(posedge clock); #1 guess   = 16'b11111000011000011; // senha j2
    @(posedge clock); #1 confirm = 1'b1;
    @(posedge clock); #1 guess   = 16'b1010001010101010; // guess j1 errado
    @(posedge clock); #1 confirm = 1'b1;
    @(posedge clock); #1 guess   = 16'b1010001010101010; // guess j2 errado
    @(posedge clock); #1 confirm = 1'b1;
    @(posedge clock); #1 guess   = 16'b0000111100110101; // guess j1 correto
    @(posedge clock); #1 confirm = 1'b1;

  end

endmodule
