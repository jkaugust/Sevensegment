
`ifndef GUARD_COVERAGE 
`define GUARD_COVERAGE 

class coverage; 
transactor tr; 

covergroup switch_coverage; 

length : coverpoint tr.length; 
da : coverpoint tr.en 
length_kind : coverpoint tr.length_kind; 
fcs_kind : coverpoint tr.fcs_kind; 

all_cross: cross length,da,length_kind,fcs_kind; 
endgroup 

function new(); 
switch_coverage = new(); 
endfunction : new 

task sample(packet pkt); 
this.pkt = pkt; 
switch_coverage.sample(); 
endtask:sample 

endclass 

`endif 

