module scalar_mult(qx,qy,k,px,py,clock,a,f);
output [3:0]qx;
output [3:0]qy;
input [3:0]k;
input [3:0]px;
input [3:0]py;
input clock;
input [4:0]a;    //elliptical curve characteristics
input [4:0]f;    //reduction function

wire [3:0]qx0,qy0;  //represent O, infinite point
wire [3:0]qx1,qy1;
wire [3:0]qx2,qy2;
wire [3:0]qx3,qy3;
wire [3:0]px1,py1;
wire [3:0]px2,py2;
wire [3:0]px3,py3;
wire [3:0]px4,py4;
wire [3:0]qx2_pa,qy2_pa;
wire [3:0]qx3_pa,qy3_pa;
wire [3:0]qx4_pa,qy4_pa;

assign qx1= (k[0]) ? (px) : (qx0);
assign qy1= (k[0]) ? (py) : (qy0);
p_double uut1(px1,py1,px,py,a,f,clock); 

p_addition uut2(qx2_pa,qy2_pa,qx1,qy1,px1,py1,a,f,clock);

assign qx2= (k[1]) ? ( (k[0]) ? (qx2_pa): (px) ) : (qx1);
assign qy2= (k[1]) ? ( (k[0]) ? (qy2_pa): (py) ) : (qy1);
p_double uut3(px2,py2,px1,py1,a,f,clock);

p_addition uut4(qx3_pa,qy3_pa,qx2,qy2,px2,py2,a,f,clock);

assign qx3= (k[2]) ? ( (k[1]) ? (qx3_pa) : ( (k[0]) ? (qx3_pa) : (px) )) : (qx2);
assign qy3= (k[2]) ? ( (k[1]) ? (qy3_pa) : ( (k[0]) ? (qy3_pa) : (py) )) : (qy2);
p_double uut5(px3,py3,px2,py2,a,f,clock);

p_addition uut6(qx4_pa,qy4_pa,qx3,qy3,px3,py3,a,f,clock);

assign qx =(k[3]) ?  ( (k[2])? (qx4_pa): ((k[1])? (qx4_pa) :((k[0]) ? (qx4_pa) :(px)) )) :  (qx3) ;
assign qy =(k[3]) ?  ( (k[2])? (qy4_pa): ((k[1])? (qy4_pa) :((k[0]) ? (qy4_pa) :(py)) )) :  (qy3) ;
p_double uut7(px4,py4,px3,py3,a,f,clock);

endmodule

module tb_scalar_mult();
wire [3:0]qx;
wire [3:0]qy;

reg [3:0]k,px,py;
reg clock;
reg [4:0]a,f;
scalar_mult uut(.qx(qx),.qy(qy),.k(k),.px(px),.py(py),.clock(clock),.a(a),.f(f));

initial forever #5 clock=~clock;

initial begin
clock=1'b1; a=5'b10000;f=5'b10011;px=4'b1111;py=4'b1111;k=4'b0011;
#100 $stop;
end
endmodule 