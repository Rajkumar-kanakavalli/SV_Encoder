
//-----------------------4x2 Encoder--------------------------------
class packet;

rand bit [3:0]i; //1.input variables 
bit [1:0]y;

bit [7:0]prev_i;
constraint e1{ i inside{1,2,4,8}; //2.constraints declaration
               i !=prev_i;}
			   

extern function void print();
extern function void copy (packet p1);
extern function  compare(packet p1);  //3.print,copy and comparision classes 

function void post_randomize();  //post randomization is used instead of using randc in environment to control repetition of values
     prev_i=i;
endfunction	 

endclass
//-----------------------------------------------------------------------------------

function void packet::print(); // display function
 $display("at time=%0t,[packet] i=%0d",$time,i);
 endfunction
 
 function void packet::copy(packet p1); // copy function i.e deep function
   if(p1==null)
    begin
   $display("[Packet] Error Null object passed to copy method ");
  
   end
   this.i=p1.i;
  endfunction  
  
 function  packet::compare(packet p1); //compare  
 
  bit result;
 
   if(p1==null)
      begin 
	      $display("[packet] error null object passed to compare method");
		  return 0;
	end
result = (this.i==p1.i) & (this.y==p1.y);
	
return result;

endfunction
