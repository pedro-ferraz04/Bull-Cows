module detector_borda (
  input clock, reset, confirm,
  output reg borda_subida
);

  logic [16:0] tempo_espera;
  logic [1:0] estado;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      estado <= 2'b00;
      borda_subida <= 1'b0;
      tempo_espera <= 17'd0;
    end
    else begin
      case (estado)
        2'b00: begin  // Esperando sinal alto
          if (confirm) begin
            tempo_espera <= 17'd0;
            estado <= 2'b01;
            borda_subida <= 1'b1;
          end
        end
        
        2'b01: begin  // Pulso de saída
          estado <= 2'b10;
          borda_subida <= 1'b0;
        end
        
        2'b10: begin  // Filtro de ruído
          if (!confirm && tempo_espera > 150000) begin
            estado <= 2'b00;
          end
          else begin
            tempo_espera <= tempo_espera + 1;
          end
        end
        
        default: estado <= 2'b00;
      endcase
    end
  end

endmodule