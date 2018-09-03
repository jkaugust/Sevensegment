// Interface module
`ifndef SEGINTF__SV
`define SEGINTF__SV

interface segintf (input bit clk);
bit en;
bit [2:0] segin;
logic [6:0] segout; 

clocking ct @(posedge clk);
 output segin,en;
 endclocking:ct
modport DUT ( clocking ct, input clk,segout);

 clocking cr @(posedge clk);
  output segout;
   input segin,en;
  endclocking: cr
modport TEST (clocking cr, input clk);
endinterface

typedef virtual segintf vsintf;
typedef virtual segintf.DUT vDUT;
typedef virtual segintf.TEST vTEST;

`endif // SEGINTF_SV
