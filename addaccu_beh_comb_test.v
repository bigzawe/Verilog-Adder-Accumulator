`timescale	1ns/1ps

module addaccu_beh_comb_test();

////////////////////// DUT Signals & Parameters //////////////////////


wire	[3:0]	sum_tb;
wire			carry_tb;
reg		[3:0] 	a_tb;
reg		[3:0] 	b_tb;
reg				sel_tb;
reg				ck_tb; 


parameter	CLK_Period = 50;

////////////////////// Initial Block //////////////////////

initial
begin
	
	//// Initialization
	initialize();
	
	//////// Start Testing ////////
	
	//// Testing Addition
	$display("############# Test Addition ############");
	
	
	// Testing Initial state
	#(2*CLK_Period)
	$display("######## Testing Initial #######");
	@(negedge ck_tb)
		if((sum_tb == 'b0)&&(carry_tb == 'b0)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	// Testing Addition 1
	a_tb = 'd5;
	b_tb = 'd10;
	
	$display("######## Test (a = 5)(b = 10) #######");
	@(negedge ck_tb)
		if((sum_tb == 'd15)&&(carry_tb == 'b0)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);
	
	
	// Testing Addition 2
	a_tb = 'd2;
	b_tb = 'd14;
	
	$display("######## Test (a = 2)(b = 14) #######");
	@(negedge ck_tb)
		if((sum_tb == 'd0)&&(carry_tb == 'b1)) $display("Functional");
		else	  $display("Error");
	#(0.5*CLK_Period);


	// Testing Addition 3
	a_tb = 'd2;
	b_tb = 'd15;
	
	$display("######## Test (a = 2)(b = 15) #######");
	@(negedge ck_tb)
		if((sum_tb == 'd1)&&(carry_tb == 'b1)) $display("Functional");
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