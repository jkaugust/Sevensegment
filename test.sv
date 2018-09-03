//Testbench module
`ifndef TEST__SV
`define TEST__SV
`include "environment.sv"

program automatic test(segintf.TEST tt);
  environment env;
initial begin
  $display(" ******************* Start of testcase ****************");
  env = new(tt);
  env.build();
  env.reset();
  env.cfg_dut();
  env.run();
  env.wait_for_end();
  env.report(); 
  
  #1000;
end
final
$display(" ******************** End of testcase *****************"); 
endprogram : test
`endif // TEST_SV
