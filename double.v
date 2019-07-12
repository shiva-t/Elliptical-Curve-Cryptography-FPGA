module p_double(rx_mod,ry_mod,px,py,a,f,clock);
output [3:0]rx_mod;
output [3:0]ry_mod;

input [3:0]px,py;
input [4:0]a;    //elliptical curve characteristics
input [4:0]f;    //reduction function
input clock;     // for inverse module instantiation

wire [3:0]s,inv_px,sp1; 
wire [4:0]term2_s;
wire [7:0]mul_py_inv_px,s_sq,rx_1,rx,px_sq,ry_2,ry;

    
inverse uut1(inv_px,px,f,clock);
multiply uut2(mul_py_inv_px,inv_px,py);
modulo uut3(term2_s,mul_py_inv_px,f);
xor_add uut4(s,px,term2_s);              //gives s

multiply uut5(s_sq,s,s);
xor_ext uut6(rx_1,s_sq,s);
xor_ext uut7(rx,rx_1,a);
modulo uut9(rx_mod,rx,f);

multiply uut11(px_sq,px,px);
xor_add uut12(sp1,s,4'd1);
multiply uut13(ry_2,sp1,rx_mod);
xor_ext uut14(ry,ry_2,px_sq);
modulo uut15(ry_mod,ry,f);

endmodule

module tb_p_double();
wire [3:0]rx_mod;
wire [3:0]ry_mod;

reg [3:0]px,py;
reg [4:0]a,f;    //reduction function
reg clock; 

p_double uut10(.rx_mod(rx_mod),.ry_mod(ry_mod),.px(px),.py(py),.a(a),.f(f),.clock(clock));
initial forever #5 clock=~clock;

initial begin

#10 px=4'b1111; py=4'b1111; a=5'b10000;f=5'b10011;clock=1'b1;
#100 $stop;
end
endmodule 