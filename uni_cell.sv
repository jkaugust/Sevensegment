`ifndef UNI_CELL_SV
`define UNI_CELL_SV

class uni_cell;
 rand logic [2:0]segin;
 rand logic en;
 constraint legal{segin>=3'b000;segin<=3'b111;};
 constraint legal2{en>=0;en<=1;};
endclass:uni_cell;

`endif //UNI_CELL_SV