`timescale	1ns/1ps

module addaccu_beh_seq_test();

////////////////////// DUT Signals & Parameters //////////////////////


wire	[3:0]	sum_tb;
wire			carry_tb;
reg		[3:0] 	a_tb;
reg		[3:0] 	b_tb;
reg				sel_tb;
reg				ck_tb; 


parameter	CLK_Period = 25;

////////////////////// Initial Block //////////////////////

initial
begin
	
	//// Initialization
	initialize();
	
	//////// Start Testing ////////
	
	//// Testing Accumulation
	$display("############# Test Accumulation ############");
	#(CLK_Period);
	
	// Testing Initial state
	
	sel_tb = 'b1;
	$display("######## Testing Initial #######");
	@(negedge ck_tb)
		if((sum_tb == 'b0)&&(carry_tb == 'b0)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	// Testing Accumulation 1
	
	
	$display("######## Test (1st cycle)(b = 5) #######");
	@(negedge ck_tb)
	b_tb = 'd5;
	#0;	
		if((sum_tb == 'd5)&&(carry_tb == 'b0)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	
	// Testing Accumulation 2
	
	$display("######## Test (2nd cycle)(b = 5) #######");
	@(negedge ck_tb)
		if((sum_tb == 'd10)&&(carry_tb == 'b0)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	// Testing Accumulation 3
	
	$display("######## Test (3rd cycle)(b = 5) #######");
	@(negedge ck_tb)
		if((sum_tb == 'd15)&&(carry_tb == 'b0)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	// Testing Accumulation 4
	
	$display("######## Test (4th cycle)(b = 5) #######");
	@(negedge ck_tb)
		if((sum_tb == 'd4)&&(carry_tb == 'b1)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	#(CLK_Period)
	$stop;
end

////////////////////// Tasks //////////////////////

//// Initialize Task

task initialize;
begin
	a_tb	= 'b0;
	b_tb	= 'b0;
	sel_tb	= 'b0;
	ck_tb	= 'b1;
end
endtask


////////////////////// Clock Generation //////////////////////

always #(0.5*CLK_Period) ck_tb = !ck_tb;

////////////////////// DUT Instantiation //////////////////////

addaccu DUT (
.ck(ck_tb),
.a(a_tb),
.b(b_tb),
.sel(sel_tb),
.sum(sum_tb),
.carry(carry_tb)
);


endmodule