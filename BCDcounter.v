// One Counter to Rule Them ALL. Cuz, u know... I used to same counter for every digit... duh.
// Deniz Rumet FIRAT
// 6.4.21

module BCDcounter(
input i_nRst, i_Clk, i_CntEn,
output o_NextEn,
output [3:0] o_Cout
);

reg [3:0]r_Cout; // Register for counters.

always @(posedge i_Clk or negedge i_nRst)
begin
	if (i_nRst == 1'b0) // Active-Low Asynch Reset.
		r_Cout[3:0] <= 4'b0; // Reset the registers	
	else
		if (i_CntEn == 1'b1) // Check for enable input
			if (r_Cout < 4'b1001) // Check for if decimal 9 is reached.
				r_Cout[3:0] <= r_Cout[3:0] + 4'b1; // Increment counter
			else
				r_Cout[3:0] <= 4'b0; // Overwrite decimal 0.
		else
			r_Cout[3:0] <= r_Cout[3:0];	// Counter is idle
end

assign o_NextEn = ((o_Cout == 4'b1001) && (i_CntEn))?(1'b1):(1'b0); // Check the condition of reaching decimal 9 and enable input. This is critical.

assign o_Cout[3:0] = r_Cout[3:0]; // Assign register to output.

endmodule
