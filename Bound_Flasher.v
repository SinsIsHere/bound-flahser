`timescale 1ns / 1ps
module Bound_Flasher (
    input         clk,
    input         rst_n,
    input         flick,
    output [0:15] lamp
);
    localparam INIT       = 3'd0;
    localparam STATE_0_5  = 3'd1;
    localparam STATE_5_0  = 3'd2;
    localparam STATE_0_10 = 3'd3;
    localparam STATE_10_5 = 3'd4;
    localparam STATE_5_15 = 3'd5;
    localparam STATE_15_0 = 3'd6;
    localparam STATE_10_0 = 3'd7;

    reg [2:0]   current_state;
    reg [2:0]   next_state;
    reg signed [-1:15] lamp_temp;
    
    assign lamp[0:15] = lamp_temp[0:15];

    always @(*) begin
        case (current_state)
            INIT: begin
                lamp_temp = 17'b1_0000_0000_0000_0000;
                if (!lamp[0]) next_state = STATE_0_5;
                else next_state = INIT;
            end

            STATE_0_5: begin
                if (lamp[5]) next_state = STATE_5_0;
                else next_state = STATE_0_5;
            end

            STATE_5_0: begin
                if (!lamp[0]) next_state = STATE_0_10;
                else next_state = STATE_5_0;
            end

            STATE_0_10: begin
                if (lamp[4] && flick) next_state = STATE_0_5;
                else if (lamp[9] && flick) next_state = STATE_10_0;
                else if (lamp[10] && !flick) next_state = STATE_10_5;
                else next_state = STATE_0_10;
            end

            STATE_10_5: begin
                if (!lamp[5]) next_state = STATE_5_15;
                else next_state = STATE_10_5;
            end

            STATE_5_15: begin
                if (lamp[10] && flick) next_state = STATE_10_5;
                else if (lamp[15]) next_state = STATE_15_0;
                else next_state = STATE_5_15;
            end

            STATE_15_0: begin
                if (!lamp[0]) next_state = INIT;
                else next_state = STATE_15_0;
            end

            STATE_10_0: begin
                if (!lamp[0]) next_state = STATE_0_10;
                else next_state = STATE_10_0;
            end

            default: next_state = INIT;
        endcase
    end

    always @(posedge clk) begin
        if (!rst_n) current_state <= INIT;
        else current_state <= next_state;
    end

    always @(posedge clk) begin
        case (next_state)
            STATE_0_5: begin
                lamp_temp <= lamp_temp >>> 1;
            end

            STATE_5_0: begin
                lamp_temp <= lamp_temp << 1;
            end

            STATE_0_10: begin
                lamp_temp <= lamp_temp >>> 1;
            end

            STATE_10_5: begin
                lamp_temp <= lamp_temp << 1;
            end

            STATE_5_15: begin
                lamp_temp <= lamp_temp >>> 1;
            end

            STATE_15_0: begin
                lamp_temp <= lamp_temp << 1;
            end

            STATE_10_0: begin
                lamp_temp <= lamp_temp << 1;
            end

            //default: 
        endcase
    end
endmodule