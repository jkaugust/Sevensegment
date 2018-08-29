//Enviorment Class
`ifndef ENVIORMENT__SV
`define ENVIORMENT__SV


`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "config.sv"
`include "scoreboard.sv"
`include "coverage.sv"

class enviorment;
    generator gen;
    mailbox gen2drv;
    event drv2gen;
    driver drv;
    monitor mon;
    configure cgf;
    scoreboard scb;
    coverage cov;
    virtual segintf.TEST vTEST;
    
    extern function new(input vTEST);
    extern virtual function void gen_cfg();
    extern virtual function void build() ;
    extern virtual task run();
    extern virtual function void wrap_up();

 endclass : enviorment 
 
 function environment::new(input vTEST);
   this.vTEST = vTEST;

   cfg = new(numRx,numTx);

   if ($test$plusargs("ntb_random_seed")) begin
      int seed;
      $value$plusargs("ntb_random_seed=%d", seed);
      $display("Simulation run with random seed=%0d", seed);
   end
   else
     $display("Simulation run with default random seed");
   
endfunction : new

function void environment::gen_cfg();
   assert(cfg.randomize());
   cfg.display();
endfunction : gen_cfg

function void environment::build();

   gen2drv = new();
   drv2gen = new();
   scb = new();
   cov = new();
   gen = new(gen2drv, drv2gen);
   drv = new(gen2drv, drv2gen, vTEST);
   
  /* foreach(gen[i]) begin
      gen2drv[i] = new();
      gen[i] = new(gen2drv[i], drv2gen[i], cfg.cells_per_chan[i], i);
      drv[i] = new(gen2drv[i], drv2gen[i], Rx[i], i);
   end */

   mon = new(vTEST);
   
   // Connect the scoreboard with callbacks
   begin
      scb_driver_cbs sdc = new(scb);
      scb_monitor_cbs smc = new(scb);
      drv.cbsq.push_back(sdc);  // Add scb to every driver
      mon.cbsq.push_back(smc);  // Add scb to every monitor
   end

   // Connect coverage with callbacks
   begin
      cov_monitor_cbs smc = new(cov);
      mon.cbsq.push_back(smc);  // Add cov to every monitor
   end

endfunction : build

task environment::run(); 
	 gen.run();
	 drv.run();
   mon.run();
endtask : run

function void Environment::wrap_up();
   $display("@%0t: End of simulation, %0d error%s, %0d warning%s", 
	    $time, cfg.nErrors, cfg.nErrors==1 ? "" : "s", cfg.nWarnings, cfg.nWarnings==1 ? "" : "s");
   scb.wrap_up;
   
endfunction : wrap_up

`endif // ENVIORMENT_SV