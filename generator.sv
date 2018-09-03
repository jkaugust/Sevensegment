
`ifndef GENERATOR_SV
`define GENERATOR_SV
`include "transactor.sv"

class  generator;
 rand transactor tr;
 mailbox gen2drv;
 event drv2gen;

function new(input mailbox gen2drv,input event drv2gen);
this.gen2drv = gen2drv;
this.drv2gen=drv2gen;
tr = new();
endfunction:new

task start();
  al: assert (tr.randomize())
  else $error("transactor randomization failed");
  gen2drv.put(tr);
 endtask : start
 
 virtual function void display(); 
 $display("-------- TRANSACTOR ---------- "); 
 $display(" en = %h ",tr.en); 
 $display(" segin = %h ",tr.segin); 
 endfunction : display 
 
 task run();
   start();
   display();
   //@drv2gen; // Wait for driver to finish with it
 endtask :run  
    
 endclass : generator

`endif // GENERATOR_SV
