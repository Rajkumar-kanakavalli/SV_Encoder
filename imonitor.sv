class imonitor;
bit [15:0] no_of_pkts_recvd;
packet pkt;
virtual enc_if.tb_mon_in vif;
mailbox #(packet) mbx; //will be connected to input of scoreboard

event e;

function new (input mailbox #(packet) mbx_in,
            input virtual enc_if.tb_mon_in vif_in,
			event e); 

this.mbx=mbx_in;
this.vif=vif_in;
this.e=e;
endfunction

task run();

  $display("imonitor run started at time=%0t",$time);
   //pkt=new;
  forever 
   begin 
	pkt=new;
	wait(e);
  pkt.i = vif.i; //write data
  //pkt.y = vif.y;
  
  /*pkt.y[1]=((~vif.i[3])&(vif.i[2])&(~vif.i[1])&(~vif.i[0]))|((vif.i[3])&(~vif.i[2])&(~vif.i[1])&(~vif.i[0]));
  pkt.y[0]=((~vif.i[3])&(~vif.i[2])&(vif.i[1])&(~vif.i[0]))|((vif.i[3])&(~vif.i[2])&(~vif.i[1])&(~vif.i[0]));*/
  if(vif.i==4'b0001 )
    begin 
	  pkt.y=2'b00;
	 end
  else if(vif.i==4'b0010)
    begin 
	  pkt.y=2'b01;
	 end
else if(vif.i==4'b0100)
    begin 
	  pkt.y=2'b10;
	 end
else 
    begin 
	  pkt.y=2'b11;
	 end	 
                         //reference logic,i.e dummy output
  mbx.put(pkt);
  no_of_pkts_recvd++;
  pkt.print();
  $display("[imonitor] at time=%0t,y=%d",$time,pkt.y);
  $display("[imonitor] Sent packet %0d to scoreboard at time=%0t ",no_of_pkts_recvd,$time);
  $display("[imonitor] no_of_pkts_recvd=%0d",no_of_pkts_recvd);
  end
  endtask

endclass
