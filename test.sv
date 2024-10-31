`include "environment.sv"
class base_test;

bit [15:0] no_of_pkts;
virtual enc_if.tb     vif;
virtual enc_if.tb_mon_in  vif_mon_in;
virtual enc_if.tb_mon_out  vif_mon_out;

environment env;

function new (input virtual enc_if.tb        vif_in,
              input virtual enc_if.tb_mon_in vif_mon_in,
              input virtual enc_if.tb_mon_out vif_mon_out
	     );
this.vif= vif_in;
this.vif_mon_in=vif_mon_in;
this.vif_mon_out=vif_mon_out;
endfunction

function void build();
no_of_pkts=5;
env = new(vif,vif_mon_in,vif_mon_out,no_of_pkts);
endfunction

task run ();
$display("[Testcase] run started at time=%0t",$time);
build();
env.run();
$display("[Testcase] run ended at time=%0t",$time);
endtask


endclass
