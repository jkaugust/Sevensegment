
`ifndef MONITOR__SV
`define MONITOR__SV

`include "uni_cell.sv"


typedef class monitor;

class monitor_cbs;
   virtual task post_rx(input Monitor mon,
		        input NNI_cell c);
   endtask : post_rx
endclass : monitor_cbs

class monitor;

   virtual segintf vdt;		// Virtual interface with output of DUT
   Monitor_cbs cbsq[$];		// Queue of callback objects

   extern function new(input vUtopiaTx Tx);
   extern task run();
   extern task receive (output NNI_cell c);
endclass : monitor

function monitor::new(input vUtopiaTx Tx);
   this.Tx     = Tx;
endfunction : new

task monitor::run();
   uni_cell c;
      
   forever begin
      receive(c);
      foreach (cbsq[i])
	cbsq[i].post_rx(this, c); 	 // Post-receive callback
   end
endtask : run

task monitor::receive(output uni_cell c);
   c = new();   
endtask : receive

`endif // MONITOR__SV

