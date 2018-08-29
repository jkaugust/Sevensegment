
`ifndef GENERATOR_SV
`define GENERATOR_SV

`include "uni_cell.sv"
class  generator;
rand uni_cell blueprint;
mailbox gen2drv;
event drv2gen;

function new(mailbox gen2drv, event drv2gen);
this.gen2drv = gen2drv;
this.drv2gen=drv2gen;
blueprint=new();
endfunction:new

task run ();
  al: assert (blueprint.randomize())
  else $error("blueprint randomization failed");
  gen2drv.put(blueprint);
  @drv2gen; // Wait for driver to finish with it
 endtask : run

endclass : generator

`endif // GENERATOR_SV
