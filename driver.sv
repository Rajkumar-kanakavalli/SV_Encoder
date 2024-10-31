class driver;

packet got_pkt;
mailbox #(packet) gen2drv;

virtual enc_if enc1; //interface
bit [3:0]no_of_pkts_rd; //to know no.of packets received from generator
 event e;
function new(input mailbox #(packet) gen2drv, 
                     input virtual enc_if enc1,event e);
   this.gen2drv = gen2drv;
   this.enc1     = enc1;
   this.e=e;
  endfunction
  
extern task run();
endclass
//------------------------------------------------------------------------------------------
 task driver::run;

forever
begin
 wait(e);
 gen2drv.get(got_pkt);     //to get randomized data from generator which was in mailbox
 
 no_of_pkts_rd++;   //received packets increment
 
 // data send to interface
 enc1.i =got_pkt.i;
 $display("[driver] got_pkt.i=%0d, enc1.i=%0d",got_pkt.i,enc1.i);
 $display("[driver] no_of_pkts_rd=%0d",no_of_pkts_rd);
 
 end

endtask
