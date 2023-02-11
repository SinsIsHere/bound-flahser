`timescale 1ns / 1ps
module testbench;
    reg         clk;
    reg         rst_n;
    reg         flick;
    wire [0:15] lamp;

    Bound_Flasher DUT (
        .clk  (clk),
        .rst_n(rst_n),
        .flick(flick),
        .lamp (lamp)
    );

    always #1 clk = ~clk;

    initial begin
        clk = 0; rst_n = 0; flick = 0;
        
        #2 rst_n = 1;
        
        #34 flick = 1;
        #4 flick = 0;
        
        #30 flick = 1;
        #4 flick = 0;
        
        #64 flick = 1;
        #4 flick = 0;
        
        #500 $finish;
    end
endmodule