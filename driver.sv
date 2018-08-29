`ifndef DRIVER__SV
`define DRIVER__SV

`include "uni_cell.sv"

typedef class driver;

class driver_cbs;
  virtual task pre_tx(input Driver drv,
		       input uni_cell c,
		       inout bit drop);
   endtask : pre_tx

   virtual task post_tx(input Driver drv,
		       input uni_cell c);
   endtask : post_tx
  endclass: driver_cbs

class driver;
  mailbox gen2drv;
  event drv2gen;
  virtual segintf vtt;
  driver_cbs cbsq[$];  // Queue of callback objects
  
   
   extern function new(input mailbox gen2drv, input event drv2gen, 
		       input vTEST vtt);
   extern task run();
   extern task send (input UNI_cell c);

endclass : driver

function driver::new(input mailbox gen2drv,
		     input event drv2gen,
		     input vTEST vtt);
   this.gen2drv = gen2drv;
   this.drv2gen = drv2gen;
   this.vtt     = vtt;
endfunction : new 

task driver::run();
   uni_cell c;
   bit drop = 0;

   // Initialize ports
   vtt.segin  <= 0;
   vtt.en     <= 0;
   
   forever begin
      // Read the cell at the front of the mailbox
      gen2drv.peek(c);
      begin: Tx
	 // Pre-transmit callbacks
	 foreach (cbsq[i]) begin
	    cbsq[i].pre_tx(this, c, drop);
	    if (drop) disable Tx; 	// Don't transmit this cell
	 end
	 send(c);
	 
	 // Post-transmit callbacks
	 foreach (cbsq[i])
	   cbsq[i].post_tx(this, c);
      end

      gen2drv.get(c);     // Remove cell from the mailbox
      ->drv2gen;	  // Tell the generator we are done with this cell
   end
endtask : run

task driver::send(input uni_cell c);
   vtt.segin = c.segin;
   vtt.en = c.en;
 endtask : driver
  
  

`endif // DRIVER__SV


