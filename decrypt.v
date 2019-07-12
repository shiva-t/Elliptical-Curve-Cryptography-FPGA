module decrypt(mx,my,c1x,c1y,c2x,c2y,a,f,clock,d);
output [3:0]mx,my;
input [3:0]c1x,c1y,c2x,c2y,d;
input [4:0]a,f;
input clock;

wire [3:0]dc1x,dc1y;

scalar_mult uut1(dc1x,dc1y,d,c1x,c1y,clock,a,f); //gives d*c1
xor_add uut2(mx,c2x,dc1x);
xor_add uut3(my,c2y,dc1y);

endmodule 

module tb_decrypt;
wire [3:0]mx,my;
reg [3:0]c1x,c1y,c2x,c2y,d;
reg [4:0]a,f;
reg clock;
decrypt uut(.mx(mx),.my(my),.c1x(c1x),.c1y(c1y),.c2x(c2x),.c2y(c2y),.a(a),.f(f),.clock(clock),.d(d));

initial forever #5 clock=~clock;

initial begin

#10  c1x=4'hf;c1y=4'hf;c2x=4'hd; c2y=4'h9; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd3;
//#10  c1x=4'hf;c1y=4'hf;c2x=4'he; c2y=4'h3; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd2;
//#10  c1x=4'hc;c1y=4'h5;c2x=4'hd; c2y=4'h9; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd2;
//#10  c1x=4'hf;c1y=4'hf;c2x=4'h8; c2y=4'hd; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd10;
//#10  c1x=4'he;c1y=4'h9;c2x=4'h9; c2y=4'hc; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd1;
#100 $stop;
end


endmodule