module encrypt(c1x,c1y,c2x,c2y,mx,my,px,py,a,f,clock,k,d);
output [3:0]c1x,c1y;
output [3:0]c2x,c2y;
input [3:0]mx,my,px,py;
input [4:0]a,f;
input clock;
input [3:0]k,d;

scalar_mult uut1(c1x,c1y,k,px,py,clock,a,f); //gives c1

wire [3:0]qx,qy;
wire [3:0]term2_x_c2,term2_y_c2;

scalar_mult uut2(qx,qy,d,px,py,clock,a,f); //gives Qb, public key of receiver
scalar_mult uut3(term2_x_c2,term2_y_c2,k,qx,qy,clock,a,f);  //gives k*Qb : second term of c2

xor_add uut4(c2x,mx,term2_x_c2);
xor_add uut5(c2y,my,term2_y_c2);


endmodule

module tb_encrypt;
wire [3:0]c1x,c1y,c2x,c2y;
reg [3:0]mx,my,px,py,k,d;
reg [4:0]a,f;
reg clock;
encrypt uut(.c1x(c1x),.c1y(c1y),.c2x(c2x),.c2y(c2y),.mx(mx),.my(my),.px(px),.py(py),.a(a),.f(f),.clock(clock),.k(k),.d(d));

initial forever #5 clock=~clock;

initial begin
#10 px=4'b1111; py=4'b1111; mx=4'h1;my=4'hc; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd3;k=4'd1;
//#10 px=4'b1111; py=4'b1111; mx=4'b0001;my=4'b1100; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd1;k=4'd2;
//#10 px=4'b1111; py=4'b1111; mx=4'b0001;my=4'b1100; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd2;k=4'd3;
//#10 px=4'b1111; py=4'b1111; mx=4'b0001;my=4'b1100; a=5'b10000;f=5'b10011;clock=1'b1;d=4'd10;k=4'd8;
#100 $stop;
end


endmodule