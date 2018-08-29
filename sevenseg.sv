module sevenseg (segintf.DUT dt, input bit clk);
always @(posedge clk)
 begin
   dt.segout = 'z;
     if (dt.en == 1) begin
       if (dt.segin== 3'b000) begin
         dt.segout = 7'b1000000;
         end if (dt.segin== 3'b001) begin
         dt.segout = 7'b1111001;
         end if  (dt.segin== 3'b010) begin
         dt.segout = 7'b0100100;
         end if  (dt.segin== 3'b011) begin
         dt.segout = 7'b0110000;
         end if  (dt.segin== 3'b100) begin
         dt.segout = 7'b0011001; 
	 end if  (dt.segin== 3'b101) begin
         dt.segout = 7'b0010010; 
	 end if  (dt.segin== 3'b110) begin
         dt.segout = 7'b0000010;
	 end if  (dt.segin== 3'b111) begin
         dt.segout = 7'b1111000;  
         end        
       end
else dt.segout = 'x;  
 end
endmodule
