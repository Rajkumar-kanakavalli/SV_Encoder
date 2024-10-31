class generator;
   bit [3:0]no_of_tx;    //number of transactions send to driver class
   
   packet pkt;   //packet and reference packet handles
   
  mailbox #(packet)gen2drv; //mailbox with parameterized to get messages
   event e;//event
  function new(input mailbox #(packet) gen2drv, 
                    input bit [3:0]pkt_no_from_env,event e);
   this.gen2drv = gen2drv;
   no_of_tx = pkt_no_from_env;
   this.e=e;
   $display("[generator] no of packets sent from environment=%0d",no_of_tx);
  endfunction
  
 task run;
   packet ref_pkt;
   bit[3:0] pkt_count;
   $display("[generator] started at time=%0t",$time);    //for redability purpose
   ref_pkt=new;
   ref_pkt.print();
  
   
    repeat(no_of_tx)
	    begin
		 assert(ref_pkt.randomize());  //assert is like if condition
		  $display("ref_pkt=%0d time=%0t",ref_pkt.i,$time);
		 pkt=new;
		 pkt.copy(ref_pkt);			 //this.i=ref_pkt.i i.e copied reference packet into packet
		
		 gen2drv.put(pkt);      //putting messages in to mailbox using put()
		 pkt_count++;            //incrementing count i.e to know how many transactions are done
		 pkt.print();
		 #2;
		 -> e;//triggering event
		 $display("[generator] pkt_count=%0d",pkt_count);
		end
endtask	

endclass
