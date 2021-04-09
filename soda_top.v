// This code is created by Jurre Wolters on 9-4-2021
// This code is based on an excercise for the course Computation II (5EIB0) of the TU/e


`timescale 1ns/1ps
module soda_top(
input clk,
input reset,
input next,
input [1:0] coin_in,
output reg soda,
output reg [1:0] coin_out,
output reg [2:0] state_display,
output reg check_coin_in
);

localparam
put_coin = 0,
input1 = 1,
input5 = 2,
input6 = 3,
input3 = 4,
return1 = 5,
soda_out = 6;

reg [2:0] next_state;
reg prev_next;



always @(posedge clk) begin
    state_display <= next_state;
    prev_next <= next;
end

always @(*) begin
    if (reset == 1) begin
        next_state = put_coin;
    end
    if (next == 1 && prev_next == 0) begin
        if (state_display == put_coin) begin
            case(coin_in)
                2'b00: next_state = put_coin;
                2'b10: next_state = soda_out;
                2'b01: next_state = input1;
                2'b11: next_state = input5;
            endcase
        end
        else if (state_display == input1) begin
            case(coin_in)
                2'b00: next_state = input1;
                2'b01: next_state = soda_out;
                2'b10: next_state = input3;
                2'b11: next_state = input6;
            endcase
        end
        else if (state_display == input5) begin
            next_state = return1;
        end
        else if(state_display == input6) begin
            next_state = input5;
        end
        else if(state_display == input3) begin
            next_state = soda_out;
        end
        else if(state_display == return1) begin
            next_state = soda_out;
        end
        else if(state_display == soda_out) begin
            next_state = put_coin;
        end
        else begin
            next_state = state_display;
        end
    end
    
    
    case(state_display)
        put_coin: begin
            coin_out = 2'b00;
            soda = 1'b0;
            check_coin_in = 1'b1;
        end
        input1: begin
            coin_out = 2'b00;
            soda = 0;
            check_coin_in = 1'b1;
        end
        input5: begin
            coin_out = 2'b10;
            soda = 0;
            check_coin_in = 1'b0;
        end
        input6: begin
            coin_out = 2'b01;
            soda = 0;
            check_coin_in = 1'b0;
        end
        input3: begin
            coin_out = 2'b01;
            soda = 0;
            check_coin_in = 1'b0;
        end
        return1: begin
            coin_out = 2'b01;
            soda = 0;
            check_coin_in = 1'b0;
        end
        soda_out: begin
            coin_out = 2'b00;
            soda = 1;
            check_coin_in = 1'b0;
        end
    endcase
    
end

endmodule

