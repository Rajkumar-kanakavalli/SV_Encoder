class omonitor;
    bit [15:0] no_of_pkts_recvd;
	packet pkt;
	virtual enc_if.tb_mon_out vif;
	mailbox #(packet)mbx;  //will be connected to input of scoreboard
	
	//event e;
function new( input mailbox #(packet) mbx_in,
	               input virtual enc_if.tb_mon_out vif_in);
                    //event e				   );
		this.mbx=mbx_in;
		this.vif=vif_in;
		//this.e=e;
		
endfunction

extern task run;
endclass
 
 task omonitor::run; //pin level to packet level conversion
    
    $display("omonitor run started at time=%0t",$time);
	
	forever 
   begin 
	pkt=new;
	//wait(e);
	@(vif.y);
	pkt.y= vif.y;
	$display("[omonitor] at time=%0t,vif.y=%0d",$time,vif.y);
    mbx.put(pkt);
  no_of_pkts_recvd++;

$display("[omonitor] Sent packet %0d to scoreboard at time=%0t ",no_of_pkts_recvd,$time);
$display("[omonitor] no_of_pkts_recvd=%0d",no_of_pkts_recvd);
  
$display("at time=%0t,y=%d",$time,pkt.y);
end
endtask



	
        		
