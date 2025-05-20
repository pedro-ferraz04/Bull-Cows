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

logic [5:0] display_data_d1;
logic [5:0] display_data_d2;
logic [5:0] display_data_d3;
logic [5:0] display_data_d4;
logic [5:0] display_data_d5;
logic [5:0] display_data_d6;
logic [5:0] display_data_d7;
logic [5:0] display_data_d8;

logic [7:0] an_out;
logic [6:0] seg_out;

assign internal_clock = clock;
assign internal_reset = ~CPU_RESETN;
assign guess_input = SW;
assign confirm_input = confirm;

bullsCows u_bullsCows(
    .guess(guess_input),
    .confirm(confirm_input),
    .clock(internal_clock),
    .reset(internal_reset),

    .d1(display_data_d1),
    .d2(display_data_d2),
    .d3(display_data_d3),
    .d4(display_data_d4),
    .d5(display_data_d5),
    .d6(display_data_d6),
    .d7(display_data_d7),
    .d8(display_data_d8)
);

dspl_drv_NexysA7 u_display_driver (
    .clock(internal_clock),
    .reset(internal_reset),
    
    .d1(display_data_d1),
    .d2(display_data_d2),
    .d3(display_data_d3),
    .d4(display_data_d4),
    .d5(display_data_d5),
    .d6(display_data_d6),
    .d7(display_data_d7),
    .d8(display_data_d8),

    .an(an_out),
    .dec_ddp(seg_out)
);

assign an = an_out;

assign seg[0] = seg_out[7];
assign seg[1] = seg_out[6];
assign seg[2] = seg_out[5];
assign seg[3] = seg_out[4];
assign seg[4] = seg_out[3];
assign seg[5] = seg_out[2];
assign seg[6] = seg_out[1];
assign seg[7] = seg_out[0];
assign seg[8] = seg_out[0];

endmodule