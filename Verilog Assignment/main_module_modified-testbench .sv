// Code your testbench here
// or browse Examples
module main_tb();
  reg [4:0] A;
  reg Clk, I, S;
  
  reg [31:0] X_main = 32'h01806177;
  reg [31:0] X_temp = 32'h01806177;
  reg [31:0] X_in = 0;
  
  reg [1:0] i = 0;
  reg [10:0] a, b;
  wire [7:0] B;
  int  count;
  
  myMod DUT(A, Clk, I, S, B);
  
  // initializing memory M of the DUT
  initial 
    begin
      Clk = 0;
      DUT.M = 4'b0000;
      DUT.X = 32'b0;
    end
  
  //checking test cases
  initial
    begin
      
      $display("checking all possible combinations");
      for(count = 0; count<32; count = count+1) begin
	  // using time step = 8 as T = 8
        A = count; S = 0; I = 0; #8;
        S = 0; I = 1; #8;
        S = 1; I = 0; #8;
        S = 1; I = 1; #8;
      end
     
      $finish;
    end
  
  // Clock generator
  always begin
    #1 Clk = ~Clk;
    
    // sequentially giving digits of X to the design module at every clock pulse
    X_in[3:0] = X_temp[3:0];
    DUT.X = X_in;
    
    $display("X input going to module = %h", X_in);
    
    X_in = X_in << 4;
    X_temp = X_temp >> 4;
    if (X_temp == 0) X_temp = X_main;
    
  end
  
  
  // console monitoring
  initial
    begin
      $monitor("Clk = %b,  A = %d, S = %b, I = %b, B = %h",Clk,A, S, I, B);
    end
  
  // Waveform generation
  initial begin
    $dumpfile("myTestbench.vcd");
    $dumpvars;
  end
  
endmodule
