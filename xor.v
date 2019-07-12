module xor_add(out_xor,a,b);

output reg [3:0]out_xor;
input [3:0]a;
input [3:0]b;


always @(a or b)
begin
out_xor[0]=a[0] ^ b[0];
out_xor[1]=a[1] ^ b[1];
out_xor[2]=a[2] ^ b[2];
out_xor[3]=a[3] ^ b[3];
end
endmodule 


module tb_xor_add();
wire [3:0]out_xor;
reg [3:0]a;
reg [3:0]b;

xor_add uut(.out_xor(out_xor),.a(a),.b(b));

initial begin
a=4'b1001;b=4'b0101;
#10 a=4'b1101;b=4'b0101;
#10 a=4'b1011;b=4'b0101;
#10 a=4'b1001;b=4'b1111;
end
endmodule 