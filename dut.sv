module enc8to3(enc_if dut_if);    //module 8to3 enc(i,y);
    
	 
always_comb
begin
    $display("[dut]input is  %0d",dut_if.i);
    case(dut_if.i)
	4'b0001     :  dut_if.y=2'b00;
	4'b0010     :  dut_if.y=2'b01;
    4'b0100     :  dut_if.y=2'b10;
	4'b1000     :  dut_if.y=2'b11;
	endcase
	$display("[dut]output is  %0d",dut_if.y);
end
endmodule
/*
always_comb
begin 
	if(dut_if.i==8'b00000001)
     begin 
	 dut_if.y=3'b000;
	 end
  else if(dut_if.i==8'b00000010)
     begin 
	 dut_if.y=3'b001;
	 end
  else if(dut_if.i==8'b00000100)
     begin 
	 dut_if.y=3'b010;
	 end
  else if(dut_if.i==8'b00001000)
     begin 
	 dut_if.y=3'b011;
	 end
  else if(dut_if.i==8'b00010000)
     begin 
	 dut_if.y=3'b100;
	 end
  else if(dut_if.i==8'b00100000)
     begin 
	 dut_if.y=3'b101;
	 end
 else if(dut_if.i==8'b01000000)
     begin 
	 dut_if.y=3'b110;
	 end
else if(dut_if.i==8'b10000000)
     begin 
	 dut_if.y=3'b111;
	 end
end	 
 endmodule*/
