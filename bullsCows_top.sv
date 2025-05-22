module bullsCows_top(
    input logic clock, // XDC: clock
    input logic CPU_RESETN, // XDC: reset
    input logic [15:0] SW, // XDC: as 16 chaves (switches)
    input logic confirm, // XDC: btnc botao do meio, nosso confirm

    output logic [7:0] an, // XDC: anodos
    output logic [7:0] seg // XDC: 8 segmentos
);

logic internal_clock;
logic internal_reset;

logic [15:0] guess_input;
logic confirm_input;

logic [5:0] d1;
logic [5:0] d2;
logic [5:0] d3;
logic [5:0] d4;
logic [5:0] d5;
logic [5:0] d6;
logic [5:0] d7;
logic [5:0] d8;

logic [7:0] an_out;
logic [7:0] seg_out;

assign internal_clock = clock;
assign internal_reset = ~CPU_RESETN;
assign guess_input = SW;
assign confirm_input = confirm;

bullsCows bullsCows(
  .guess(guess_input),
  .confirm(confirm_input),
  .clock(internal_clock),
  .reset(internal_reset),

  .d1(d1), .d2(d2), .d3(d3), .d4(d4),
  .d5(d5), .d6(d6), .d7(d7), .d8(d8)
  );

dspl_drv_NexysA7 u_display_driver (
    .clock(internal_clock),
    .reset(internal_reset),

    .d1(d1), .d2(d2), .d3(d3), .d4(d4),
    .d5(d5), .d6(d6), .d7(d7), .d8(d8),

    .an(an_out),
    .dec_ddp(seg_out)
);

assign an = an_out;

assign seg = seg_out;

endmodule
