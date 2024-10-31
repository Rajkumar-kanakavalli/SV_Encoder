interface enc_if;
logic [3:0]i;
logic [1:0]y;



modport dut_if(input i,output y);//port declarations for dut using modport
modport tb(output i,input y);
modport tb_mon_in(input i,output y);
modport tb_mon_out(input y);

endinterface 
