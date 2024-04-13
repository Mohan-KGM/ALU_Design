// or browse Example
`define data_size 8
`define opcode_size 4
module ALU_8bit_tb;

  reg clk;
  reg reset;
  reg en;
  reg [8-1:0] A;
  reg [8-1:0] B;
  reg [3:0] opcode;
  wire [16-1:0] out;
  wire Cout_1;
  wire ouflag;

  
   ALU_reconfig uut (
    .clk(clk),
    .reset(reset),
    .en(en),
    .A(A),
    .B(B),
    .opcode(opcode),
    .out(out),
     .Cout_1(Cout_1), 
     .ouflag(ouflag)
  );
  
  always begin
    #10 clk = ~clk;
  end
  
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, ALU_8bit_tb);

    clk = 0;
    reset = 1;
    en = 0;
    A = 8'b0;
    B = 8'b0;
    opcode = 4'b0000;

  end
  
  initial begin
    
   
    @(posedge clk);
    reset = 0;
    
    // Basic Addition
    do_Addition;
    chk_Addition;
    // Basic Subtraction
    do_sub;
    chk_sub;
    // Basic MULTIPLICATION
    do_mul;
    chk_mul;
    // Basic Division
    do_div;
    chk_div;
    // Basic Increment
    do_incr;
    chk_incr;
    // Basic decrement
    do_decr;
    chk_decr;
    // Basic AND
    do_and;
    chk_and;
    // Basic or
    do_or;
    chk_or;
    // Basic xor
    do_xor;
    chk_xor;
    // Basic not
    do_not;
    chk_not;
    // Basic NAND
    do_nand;
    chk_nand;
    
    
    #2000 $finish;
  end
  
  task do_Addition();
  begin
    @(posedge clk);
    en = 1;
    A = 'b10101010;
    B = 'b01010101;
    opcode = 'b1111; // ADD
  end
  endtask
  
  task chk_Addition();
  begin
    @(posedge clk);
    en = 1;
    A = 'b10101010;
    B = 'b01010101;
    opcode = 'b1111; // ADD
    @(posedge clk);
    if (out != A+B) $display ("ERROR: Addition failed. Expected = %h Actual %h", (A+B), out);
    else $display ("INFO: Addition succeeded. Expected = %0h Actual %0h", (A+B), out);
  end
  endtask
  
  task do_sub();
  begin
    @(posedge clk);
    en = 1;
    A = 'b10101010;
    B = 'b01010101;
    opcode = 'b1110;
  end
  endtask
  
  task chk_sub();
  begin
    @(posedge clk);
    en = 1;
    A = 'b10101010;
    B = 'b01010101;
    opcode = 'b1110;
    @(posedge clk);
    if (out != A-B) $display ("ERROR: Subtraction failed. Expected = %h Actual %h", (A-B), out);
    else $display ("INFO: Subtraction succeeded. Expected = %0h Actual %0h", (A-B), out);
  end
  endtask
endmodule
