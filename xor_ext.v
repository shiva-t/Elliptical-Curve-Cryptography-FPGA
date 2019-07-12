module xor_ext(out_xor,a,b);

output reg [7:0]out_xor;
input [7:0]a;
input [7:0]b;


always @(a or b)
begin
out_xor[0]=a[0] ^ b[0];
out_xor[1]=a[1] ^ b[1];
out_xor[2]=a[2] ^ b[2];
out_xor[3]=a[3] ^ b[3];
if((b[4]==1'b1) | (b[4]==1'b0)) begin out_xor[4]=a[4] ^ b[4]; end
else begin out_xor[4]=a[4]; end
if((b[5]==1'b1) | (b[5]==1'b0)) begin out_xor[5]=a[5] ^ b[5]; end
else begin out_xor[5]=a[5]; end
if((b[6]==1'b1) | (b[6]==1'b0)) begin out_xor[6]=a[6] ^ b[6]; end
else begin out_xor[6]=a[6]; end
if((b[7]==1'b1) | (b[7]==1'b0)) begin out_xor[7]=a[7] ^ b[7]; end
else begin out_xor[7]=a[7]; end

end
endmodule 


module tb_xor_ext();
wire [7:0]out_xor;
reg [7:0]a;
reg [7:0]b;

xor_ext uut(.out_xor(out_xor),.a(a),.b(b));

initial begin
//a=8'b10000001;b=8'b01000001;
//#10 a=8'b10010001;b=8'b01000001;
//#10 a=8'b10100001;b=8'b00000101;
#10 a=8'b01010100;b=5'b10000;
#40 $stop;
end
endmodule 
