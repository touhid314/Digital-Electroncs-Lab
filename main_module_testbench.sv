// Code your testbench here
// or browse Examples
module main_tb();
  reg [4:0] A;
  reg Clk, I, S;
  wire [7:0] B;
  int count;

  myMod DUT(A, Clk, I, S, B);
  
  // initializing memory M of the DUT
  initial 
    begin
      Clk = 0;
      DUT.M = 4'b0000;
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
  always #1 Clk = ~Clk;
  
  // console monitoring
  initial
    begin
      $monitor("Clk = %b, A = %d, S = %b, I = %b, B = %h",Clk, A, S, I, B);
    end
  
  // Waveform generation
  initial begin
    $dumpfile("myTestbench.vcd");
    $dumpvars;
  end
  
endmodule
