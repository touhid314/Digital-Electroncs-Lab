// Fibb function [FINAL]
function [7:0] fibb_res(input [3:0] M);
    case(M)
      0: fibb_res = 0;
      1: fibb_res = 1;
      2: fibb_res = 1;
      3: fibb_res = 2;
      4: fibb_res = 3;
      5: fibb_res = 5;
      6: fibb_res = 8;
      7: fibb_res = 13;
      8: fibb_res = 21;
      9: fibb_res = 34;
      10: fibb_res = 55;
      11: fibb_res = 89;
      12: fibb_res = 144;
      13: fibb_res = 233;
      14: fibb_res = 8'b0111_1001; //trimming off the MSB to keep it 8 bit
      15: fibb_res = 8'b0110_0010; // trimming off MSB
      default: fibb_res = 0;
    endcase
endfunction

module myMod(input [4:0] A, input Clk, I, S, output reg [7:0] B);
  reg [3:0] M;
  reg [31:0] X = 32'h01806177;
  reg [7:0] Y = 8'b0101_1001; 
  //reg [7:0] fibb_res;
  reg [3:0] M_next;
  
  always @(posedge Clk) begin
    if(S==1) begin
      if(I==1) begin
        B <= 8'h0;
      end else begin
        case(M)
          0: B <= X[7:0];
          1: B <= X[15:8];
          2: B <= X[23:16];
          3: B <= X[31:24];
          default: begin
            //fibb_res <= Fibb(M-2);
            B <= fibb_res(M-2) + Y + A;
          end
        endcase
        M_next = M + 1;
        if(M_next>=16) M_next = 0;
        M <= M_next;
      end
    end 
  end
  
  always@(S)
    begin
      if (S==0) begin
        B = 8'bz;
      end
    end
endmodule

