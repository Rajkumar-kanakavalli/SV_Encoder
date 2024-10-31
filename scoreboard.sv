class scoreboard;

bit [15:0] total_pkts_recvd;
packet   ref_pkt;
packet   got_pkt;
mailbox #(packet)ipm_sb; //will be connected to input monitor
mailbox #(packet)opm_sb;//will be connected to output monitor
bit [15:0] m_matches;
bit [15:0] m_mismatches;

function new (input mailbox #(packet)ipm_sb,
              input mailbox #(packet)opm_sb);

this.ipm_sb  = ipm_sb;
this.opm_sb = opm_sb;
endfunction

task run;

$display("[Scoreboard] run started at time=%0t",$time);
while(1)
begin
ipm_sb.get(ref_pkt);
opm_sb.get(got_pkt);
total_pkts_recvd++;

$display("ref_pkt.y=%0d,got_pkt.y=%0d",ref_pkt.y,got_pkt.y);

if(ref_pkt.y == got_pkt.y)
  begin
    m_matches++;
	$display("[Scoreboard] Packet=%0d Matched ",total_pkts_recvd);
  end
else
  begin 
   m_mismatches++;
$display("[Scoreboard] ERROR :: Packet=%0d Not_Matched at time=%0t",total_pkts_recvd,$time); 
$display("[Scoreboard] *** Expected i=%0b,y=%0b but Received i=%0b,y=%b",ref_pkt.i,ref_pkt.y,got_pkt.i,got_pkt.y); 
end
/*if (ref_pkt.compare(got_pkt) )
begin
    m_matches++;
$display("[Scoreboard] Packet %0d Matched ",total_pkts_recvd); 
end
    else
    begin
    m_mismatches++;
    
$display("[Scoreboard] ERROR :: Packet %0d Not_Matched at time=%0t",total_pkts_recvd,$time); 
$display("[Scoreboard] *** Expected i1=%0d i0=%0h sel=%b y=%b but Received i1=%0d i0=%0h ****",ref_pkt.i1,ref_pkt.i0,ref_pkt.sel,ref_pkt.y , 
 got_pkt.i1,got_pkt.i0,got_pkt.sel,got_pkt.y); 
end
    
end

$display("[Scoreboard] run ended at time=%0t",$time);

$display("[Scoreboard] run ended at time=%0t",$time);*/
end
endtask
endclass

