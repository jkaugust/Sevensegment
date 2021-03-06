// Top module

`ifndef TOP__SV
`define TOP__SV


module top;
logic clk;
 initial begin
  clk=0;
  #5ns clk=0;
  #5ns clk=0;
  forever
   #5ns clk=~clk;
  end
  segintf sntf(clk);
  sevenseg svnsg(.clk(clk),.segin(sntf.segin),.en(sntf.en),.segout(sntf.segout));
  test tst (sntf.TEST); 
endmodule:top
 
`endif // TOP__SV