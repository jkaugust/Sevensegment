// Interface module
`ifndef SEGINTF__SV
`define SEGINTF__SV

interface segintf (input bit clk);
logic en;
logic [2:0] segin;
logic [6:0] segout; 


 clocking cr @(posedge clk);
 default input #1 output #1;
 output segin;
 output en;
 input segout;
 endclocking:cr
modport TEST ( clocking cr, input clk);

endinterface

`endif // SEGINTF_SV
