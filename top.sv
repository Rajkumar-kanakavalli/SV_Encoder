`include "interface.sv"
`include "dut.sv"
`include "program.sv"
module top;


enc_if   en_if ();

enc8to3 dut_inst (en_if);
 
program_test ptest (en_if);

endmodule
