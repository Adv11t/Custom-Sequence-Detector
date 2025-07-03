`timescale 1ns / 1ps

module seq_det #(parameter n = 4, parameter [n-1:0] sequence = 4'b0110)( input wire data_stream, input wire clock, input wire reset, output reg out);
// sequence length and the sequence to be detected can be customized
// the idea is that we first input n bits, then starting comparing with "sequence"
reg [n-1:0] shift;
reg [n-1:0] count;
always @(posedge reset or posedge clock) begin
    if ( reset == 1)begin
        shift <= 0;
        out<=0;
        count<=0;
    end
    else begin
        shift <= {shift[n-2:0], data_stream};
        if(count<n) begin
        count <= count + 1;
        end
        else if(count==n) begin
            if({shift[n-2:0], data_stream} == sequence) begin
             //updates happen after posedge so if we compare shift here, there'll be an extra lag of 1 cycle
                out <= 1;
            end
            else begin
                out <=0;
            end
        end
    end
end
endmodule
