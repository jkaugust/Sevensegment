//Enviorment Class
`ifndef ENVIRONMENT__SV
`define ENVIRONMENT__SV


`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
/*`include "config.sv"
`include "scoreboard.sv"
`include "coverage.sv"*/

class environment;
    generator gen;
    mailbox gen2drv;
    mailbox drv2scb;
    mailbox mon2scb;
    event drv2gen;
    driver drv;
    monitor mon;
    scoreboard scb;
    static int error = 0;
    /*configure cgf;
    scoreboard scb;
    coverage cov;*/
    virtual segintf.TEST vTEST;
    
    extern function new(input virtual segintf.TEST vTEST_new);
    extern virtual function void build() ;
    extern virtual task reset();
    extern virtual task cfg_dut();
    extern virtual task run();
    extern virtual task wait_for_end(); 
    extern virtual function void report();

 endclass : environment 
 
 function environment::new(input virtual segintf.TEST vTEST_new);
   this.vTEST = vTEST_new;
  endfunction : new

function void environment::build();
$display(" %0d : Environment : start of build() method",$time); 
   gen2drv = new();
   drv2scb = new();
   mon2scb = new();
   gen = new(gen2drv, drv2gen);
   drv = new(gen2drv, drv2scb, drv2gen, vTEST);
   mon = new(mon2scb,vTEST);
   scb = new(drv2scb,mon2scb);
  /* 
   cov = new();
    */
$display(" %0d : Environment : end of build() method",$time); 
endfunction : build

task environment::reset(); 
$display(" %0d : Environment : start of reset() method",$time); 
vTEST.cr.en <=0;
vTEST.cr.segin <= 3'b000;
$display(" %0d : Environment : end of reset() method",$time); 
endtask : reset 

task environment::cfg_dut(); 
$display(" %0d : Environment : start of cfg_dut() method",$time); 
$display(" %0d : Environment : end of cfg_dut() method",$time); 
endtask : cfg_dut 


task environment::run(); 
  $display(" %0d : Environment : start of run() method",$time); 
	 gen.run();
	 drv.run();
   mon.run();
   scb.run();
   $display(" %0d : Environment : end of run() method",$time); 
endtask : run

task environment::wait_for_end(); 
$display(" %0d : Environment : start of wait_for_end() method",$time); 
repeat(10000) @(vTEST.clk); 
$display(" %0d : Environment : end of wait_for_end() method",$time); 
endtask : wait_for_end 

function void environment::report();  
endfunction : report

`endif // ENVIRONMENT_SV

