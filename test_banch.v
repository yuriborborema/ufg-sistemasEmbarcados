`include "ULA_tb.v"
`include "dance_tb.v"
`include "control_unit_tb.v"



module test_banch();

	reg clock;	
	reg [7:0] a,b;
	reg [17:0] SW;
	reg [1:0] op;
	wire [7:0] result1,result2;
	wire [4:0] position;
	//wire [17:0] LEDR;	
	
	reg [7:0] iDATA;
	reg iRS;
	reg iStart;
	wire oDone;
	wire [7:0] LCD_DATA;
	wire LCD_RW;
    wire LCD_EN;
	wire LCD_RS;
	
	wire [7:0]HEX0;
	wire [7:0]HEX1;
	wire [7:0]HEX2;
	wire [7:0]HEX4;
	wire [7:0]HEX5;
	reg [3:0]KEY;
	wire [17:0]LEDR; 
	wire LCD_ON;	
	wire LCD_BLON; 
		
	
	ULA ULA(
		.a(a),
		.b(b),
		.op(op),
		.result1(result1),
		.result2(result2)
	);

	/*dance dance(
		//.led(LEDR),
		.SW(SW),
		.Clock(clock),
		.position(position)
	);	
	
	lcd_tb lcd(
		.iDATA(iDATA),
		.iRS(iRS),
		.iStart(iStart),
		.iCLK(clock),
		.oDone(oDone),
		.LCD_DATA(LCD_DATA),
		.LCD_RW(LCD_RW),
		.LCD_EN(LCD_EN),
		.LCD_RS(LCD_RS)
	);*/
	
	control_unit_tb cutb1(
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.KEY(KEY),
		.SW(SW),
		.CLOCK_50(clock),
		.LEDR(LEDR), 
		.LCD_ON(LCD_ON),	
		.LCD_BLON(LCD_BLON), 
		.LCD_RW(LCD_RW), 
		.LCD_EN(LCD_EN), 
		.LCD_RS(LCD_RS), 
		.LCD_DATA(LCD_DATA)
	
	);
	
	
	initial begin

		$dumpfile("wave.vcd");
		$dumpvars; 

		clock = 0;	
		a <= 0;
		b <= 2;		
		
		//SW = 0; // Crescente		

		op = 0; // Soma
		#500 op = 1; // sub
		#500 op = 2; // mult
		#500 op = 3; // div		
	
		//#100 SW = 1; // Decrescente		
		//#100 SW = 2; // Vai e volta
		
		/*iDATA = 8'h0E;
		iRS = 0;
		#100 iStart = 1;
		if(oDone==1)iStart=0;
		
		#500 iDATA = 8'h41;
		iRS = 1;
		#100 iStart = 1;
		if(oDone==1)iStart=0;*/
		
		#200;
		SW[17] = 0;
		SW[16] = 0;
		SW[15] = 0;
		#300;
		SW[17] = 0;
		SW[16] = 0;
		SW[15] = 1;
		#800;
		SW[17] = 1;
		SW[16] = 0;
		SW[15] = 1;
		
		
		
		
		
		#2000  $finish;		
	end
	
	// Clock
	always begin
		#2 clock <= ~clock;
	end

	// LEDs
	always @ (posedge clock) begin
		$display(position);
	end

	// ULA
	always begin		
		if(a < 15) a <= a + 1;
		else a <= 0;
		#10;		
	end
	
	
	
endmodule
