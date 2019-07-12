//module p_addition(rx,ry,px,py,qx,qy,a,f,clock);
module p_addition(rx,ry,px,py,qx,qy,a,f,clock);
output [3:0]rx;
output [3:0]ry;
input [3:0]px;
input [3:0]py;
input [3:0]qx;
input [3:0]qy;
input [4:0]a;
input [4:0]f;
input clock;

wire [3:0]s_num;
wire [3:0]s_den;
wire [3:0]inv_s_den;
wire [7:0]s_pro;
wire [7:0]s_sq;
wire [7:0]rx_1;
wire [3:0]rx_2;
wire [7:0]rx_3;
wire [7:0]rx_4;

wire [3:0]s;
wire [3:0]ry_1;
wire [3:0]ry_2;
wire [7:0]ry_3;
wire [7:0]ry_4;

xor_add uut1(s_num,py,qy);
xor_add uut2(s_den,px,qx);
inverse uut3(inv_s_den,s_den,f,clock);
//assign inv_s_den=4'b0010;
multiply uut4(s_pro,inv_s_den,s_num);
modulo uut5(s,s_pro,f);
multiply uut6(s_sq,s,s);
xor_ext uut7(rx_1,s_sq,s);
xor_add uut8(rx_2,px,qx);
xor_ext uut9(rx_3,rx_1,a);
xor_ext uut10(rx_4,rx_3,rx_2);
modulo uut11(rx,rx_4,f);

//ry
xor_add uut12(ry_1,px,rx);
xor_add uut13(ry_2,py,rx);
multiply uut14(ry_3,ry_1,s);
xor_ext uut15(ry_4,ry_3,ry_2);
modulo uut16(ry,ry_4,f);
endmodule

module tb_p_addition();
wire [3:0]rx,ry;
reg [3:0]px,py,qx,qy;
reg [4:0]a,f;
reg clock;

p_addition uut0(.rx(rx),.ry(ry),.px(px),.py(py),.qx(qx),.qy(qy),.a(a),.f(f),.clock(clock));

initial forever #5 clock=~clock;

initial begin

#10 px=4'b1111; py=4'b1111; qx=4'b0110; qy=4'b1110; a=5'b10000;f=5'b10011;clock=1'b1;
//#60 px=4'b1111; py=4'b1111; qx=4'b0010; qy=4'b0010; a=5'b10000;f=5'b10011;
#100 $stop;
end
endmodule 
