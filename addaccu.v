module addaccu (sum,carry,a,b,sel,ck);
    output 	[3:0]	sum;
    output 		carry;
    input 	[3:0] 	a;
    input 	[3:0] 	b;
    input 		sel;
    input 		ck; 
    
	
    reg 	[4:0] 	temp;
    reg 	[3:0] 	muxout;
    reg 	[3:0] 	regout;

    always @(a,b,regout,sel)
     begin
        muxout = (sel==0)?a:regout;
        temp = b + muxout;
     end
    
    always @(posedge ck)
     begin
        regout <= temp[3:0];
     end
    
    assign sum = temp[3:0];
    assign carry = temp[4];

endmodule
