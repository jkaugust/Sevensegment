//Testbench module
`ifndef TEST__SV
`define TEST__SV

program automatic test(segintf.TEST tt,logic clk);
initial begin
  $display(" ******************* Start of testcase ****************");

  
  #1000;
end
final
$display(" ******************** End of testcase *****************"); 
endprogram : test
`endif // TEST_SV
