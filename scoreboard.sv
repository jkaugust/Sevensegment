
`ifndef GUARD_SCOREBOARD 
`define GUARD_SCOREBOARD 
`include "transactor.sv"

class scoreboard; 

mailbox drv2scb; 
mailbox mon2scb; 
transactor tr;
logic [6:0] outrcv;
int suc = 0;
int su =0;
static int error = 0;

function new(mailbox drv2scb,mailbox mon2scb); 
this.drv2scb = drv2scb; 
this.mon2scb = mon2scb; 
endfunction:new 

function void compare();
  if (tr.en ==1)
    begin
      case (outrcv)
        7'b1000000 : if (tr.segin == 3'b000)  
                          suc <= 1;
                      else
                          suc <= 0;
         7'b1111001 : if (tr.segin == 3'b001)
                          suc <= 1;
                      else
                          suc <= 0;   
         7'b0100100 : if (tr.segin == 3'b010)
                          suc <= 1;
                      else
                          suc <= 0;
         7'b0110000 : if (tr.segin == 3'b011)
                          suc <= 1;
                      else
                          suc <= 0;                      
         7'b0011001 : if (tr.segin == 3'b100)
                          suc <= 1;
                      else
                          suc <= 0;
         7'b0010010 : if (tr.segin == 3'b101)
                          suc <= 1;
                      else
                          suc <= 0;  
         7'b0000010 : if (tr.segin == 3'b110)
                          suc <= 1;
                      else
                          suc <= 0;  
         7'b1111000 : if (tr.segin == 3'b111)
                          suc <= 1;
                      else
                          suc <= 0;
             default : $display("Error in Comparison");  
      endcase                                                                          
    end
  else
    if (outrcv == 'x)
      begin
       suc <=1;
      end
    else
       begin
       suc <=0;
      end  
  su <= suc;

endfunction : compare


task run(); 
forever 
begin 
mon2scb.get(outrcv); 
$display(" %0d : Scorebooard : Scoreboard received a packet from monitor ",$time); 
drv2scb.get(tr); 
compare();
if(su == 1) 
$display(" %0d : Scoreboardd :Packet Matched ",$time); 
else 
error++; 
end 
endtask : run 



endclass 

`endif 
