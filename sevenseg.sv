`ifndef SEVENSEG__SV
`define SEVENSEG__SV
module sevenseg (segintf.DUT dt);
  bit [2:0]segin;
  bit en;
  logic [6:0] segout;
 always @(posedge dt.clk)
 begin
   segin <= dt.ct.segin;
   en <= dt.ct.en;
   segout <= 'z;
     if (en == 1) begin
       if (segin== 3'b000) begin
         segout <= 7'b1000000;
         end if (segin== 3'b001) begin
         segout <= 7'b1111001;
         end if  (segin== 3'b010) begin
         segout <= 7'b0100100;
         end if  (segin== 3'b011) begin
         segout <= 7'b0110000;
         end if  (segin== 3'b100) begin
         segout <= 7'b0011001; 
       	 end if  (segin== 3'b101) begin
         segout <= 7'b0010010; 
	       end if  (segin== 3'b110) begin
         segout <= 7'b0000010;
	       end if  (segin== 3'b111) begin
         segout <= 7'b1111000;  
         end        
       end
else segout <= 'x;
dt.segout <= segout;  
 end
endmodule

`endif // ENVIORMENT_SV
