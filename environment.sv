`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "imonitor.sv"
`include "omonitor.sv"
`include "scoreboard.sv"
class environment;
bit [15:0] no_of_pkts; 
mailbox #(packet)gen_drv_mbox; //generator to driver mailbox
mailbox #(packet)mon_in_scb_mbox; //input monitor to scoreboard mailbox
mailbox #(packet)mon_out_scb_mbox; //output monitor to scoreboard mailbox

virtual enc_if.tb vif;
virtual enc_if.tb_mon_in  vif_mon_in;
virtual enc_if.tb_mon_out vif_mon_out;

generator gen; // gen is handle of generator class 
driver drvr;
imonitor mon_in;  // handles creation for all classes 
omonitor mon_out;
scoreboard scb;

event e;

function new (input virtual enc_if.tb vif_in,
              input virtual enc_if.tb_mon_in  vif_mon_in,
              input virtual enc_if.tb_mon_out vif_mon_out,
	      input bit [15:0] no_of_pkts
		  );
this.vif= vif_in;
this.vif_mon_in=vif_mon_in;
this.vif_mon_out=vif_mon_out;
this.no_of_pkts=no_of_pkts;
$display("no of packets sent from environment=%0d",no_of_pkts);
endfunction


function void build();

$display("[Environment] build started at time=%0t",$time);
 gen_drv_mbox      = new;
 mon_in_scb_mbox   = new;
 mon_out_scb_mbox  = new;
 gen               = new(gen_drv_mbox,no_of_pkts,e);
 drvr              = new(gen_drv_mbox,vif,e);
 mon_in            = new(mon_in_scb_mbox,vif_mon_in,e);
 mon_out           = new(mon_out_scb_mbox,vif_mon_out);
 scb               = new(mon_in_scb_mbox,mon_out_scb_mbox);
 $display("[Environment] build ended at time=%0t",$time); 
endfunction

task run;
 $display("[Environment] run started at time=%0t",$time);
 build();
 
 fork 
  gen.run();
  drvr.run();
  mon_in.run();
  mon_out.run();
  scb.run();
join_any
#10;
report();
$display("[Environment] run ended at time=%0t",$time); 
endtask

function void report();

$display("scb.m_mismatches=%0d,no_of_pkts=%0d,scb.total_pkts_recvd=%0d",scb.m_mismatches,no_of_pkts,scb.total_pkts_recvd);
if((scb.m_mismatches ==0) && (no_of_pkts == scb.total_pkts_recvd)) 
begin
$display("***********TEST PASSED ************ ");
$display("*******Matches=%0d Mis_matches=%0d ********* \n",scb.m_matches,scb.m_mismatches); 
end
else begin
$display("*********TEST FAILED ************ "); 
$display("*******Matches=%0d Mis_matches=%0d ********* \n",scb.m_matches,scb.m_mismatches); 
end


endfunction

endclass
