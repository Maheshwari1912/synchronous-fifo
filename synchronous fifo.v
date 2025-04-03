module sync_fifo(
input clk,rst,wr,rd,
input [7:0] in,
output reg [7:0] out,
output full,
output empty
);
parameter fifo_depth = 16;
reg [7:0] mem [15:0];
reg [4:0] count=0;
reg [3:0] rd_ptr=0;
reg [3:0] wr_ptr=0;
assign full = (fifo_depth==count);
assign empty = (count==0);
//write operation
always@(posedge clk or posedge rst) begin
if(rst)
wr_ptr<=0;
else if(wr&&!full) begin
mem[wr_ptr]<=in;
wr_ptr <= wr_ptr+1;
end
end
//read operation
always@(posedge clk or posedge rst) begin
if(rst)
rd_ptr<=0;
out<=0;
else if(rd&&!empty) begin
out<=mem[rd_ptr];
rd_ptr <= rd_ptr+1;
end
end
//count
always@(posedge clk or posedge rst) begin
if(rst)
count<=0;
else begin
case({wr,rd})
2'b01: count<=count+1;
2'b10: count<=count-1;
default: count<=count;
endcase
end
end
endmodule
