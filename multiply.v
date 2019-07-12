module multiply(out,a,b);
output reg [7:0]out;
input [3:0]a;
input [3:0]b;

always@(a or b)
begin
out[7]=1'b0;
out[6]=b[3] & a[3]; //constant term
out[5]=(b[3] & a[2]) ^ (b[2] & a[3]);
out[4]=((b[3] & a[1]) ^ (b[2] & a[2])) ^ (b[1] & a[3]);
out[3]=((b[3] & a[0]) ^ (b[2] & a[1])) ^ ((b[1] & a[2]) ^ (b[0] & a[3]));
out[2]=(b[2] & a[0]) ^ ((b[1] & a[1]) ^ (b[0] & a[2]));
out[1]=(b[1] & a[0]) ^ (b[0] & a[1]);
out[0]=(b[0] & a[0]) ;
end

endmodule

module tb_multiply();
wire [6:0]out;
reg [3:0]a,b;

multiply uut(.out(out),.a(a),.b(b));

initial begin
a=4'b1001;b=4'b0101;
#10 a=4'b0001;b=4'b0101;
#10 a=4'b0010;b=4'b0101;
#10 a=4'b0100;b=4'b1111;
#10 $stop;
end


endmodule 