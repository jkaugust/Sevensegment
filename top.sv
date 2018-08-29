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
  sevenseg svnsg(sntf.DUT);
  test tst (sntf.TEST,clk); 
endmodule:top
 
`endif // TOP__SV