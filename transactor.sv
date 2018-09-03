`ifndef TRANSACTOR_SV 
`define TRANSACTOR_SV 

class transactor;
  
 rand bit [2:0]segin;
 rand bit en;
 constraint legal{segin>=3'b000;segin<=3'b111;};
 constraint legal2{en>=0;en<=1;};
 
 
endclass : transactor
`endif //TRANSACTOR_SV 


