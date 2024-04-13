//`define data_size 8
module ALU_reconfig  #(data_size = 8)(
  input wire clk,
  input wire reset,
  input wire en,
  input wire [data_size-1 : 0] A,
  input wire[data_size-1  :0] B,
  input wire[4-1 : 0] opcode,
  output wire [data_size*2 -1 : 0] out,
  output wire Cout_1,
  output reg ouflag
);
  reg [15:0] result;
  reg Cout = 0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      result <= 'b0;
      Cout <= 1'b0;
    end else if (en) begin
      case (opcode)
        'b1111: begin 
          result <= A + B;
          Cout <= (result[8] == 1'b1);
        end
        'b1110: begin 
          result <= A - B;
          Cout <= (result[8] == 1'b1);
        end
        'b1101: begin 
          result <= A * B;
          Cout <= (result[8] == 1'b1);
        end
        'b1100: begin 
          result <= A / B;
          Cout <= (result[8] == 1'b1);
        end
        'b1011: begin 
          result <= A + 1;
          Cout <= (result[8] == 1'b1);
        end
        'b1010: begin 
          result <= A - 1;
          Cout <= (result[8] == 1'b1);
        end
        'b0111: begin 
          result <= A & B;
          Cout <= (result[8] == 1'b1);
        end
        'b0110: begin 
          result <= A | B;
          Cout <= (result[8] == 1'b1);
        end
        'b0101: begin 
          result <= (A^B);
          Cout <= (result[8] == 1'b1);
        end
        'b0100: begin 
          result <= ~ B;
          Cout <= (result[8] == 1'b1);
        end
        'b0011: begin 
           result <= ~ (A & B);
          Cout <= (result[8] == 1'b1);
        end
        default: begin
          result <= 'b0;
          Cout <= 1'b0;
        end
      endcase
    end
  end
  assign out = result;
  assign Cout_1 = Cout;
  always @(posedge clk) begin
    if (result > clog2(data_size)-1) ouflag = 1'b1;
  	else  ouflag = 1'b0;
  end
  function integer clog2(input integer j);
begin:clog
    clog2 = 0;
    clog2 = 1<<j;
end
endfunction
endmodule
