//to implement: a(z) % f(z),find q and remainder

module modulo(r,a,b);
//output reg [3:0]q;
output reg [4:0]r;
input [7:0]a;
input [4:0]b;
reg [7:0]reg_a;
reg [4:0]reg_b;
reg [3:0]q;

always@(a or b)
begin
//same size of a and b,a is smaller

if( (a[7]==0) & (a[6]==0) & (a[5]==0) & (a[4]==b[4]) )  
begin
		q=1'b1;
		r[4]=a[4] ^ b[4];
		r[3]=a[3] ^ b[3];
		r[2]=a[2] ^ b[2];
		r[1]=a[1] ^ b[1];
		r[0]=a[0] ^ b[0];
end

else if ((a[7]==0) & (a[6]==0) & (a[5]==0) & (a[4]==0))  // a is less than b
begin
	
		r[4:0]=a[4:0];
		q=4'b0000;  
end

else //a>b

begin
reg_a=a;
reg_b=b;
	if (a[7]==1'b1)
	begin
		q[3]=1'b1;
		reg_a[7]=reg_a[7] ^ b[4];
		reg_a[6]=reg_a[6] ^ b[3];
		reg_a[5]=reg_a[5] ^ b[2];
		reg_a[4]=reg_a[4] ^ b[1];
		reg_a[3]=reg_a[3] ^ b[0];
	
	
		if(reg_a[6:2]<b[4:0])
		begin q[2]=1'b0; end
		else begin 
		reg_a[6]=reg_a[6] ^ b[4];
		reg_a[5]=reg_a[5] ^ b[3];
		reg_a[4]=reg_a[4] ^ b[2];
		reg_a[3]=reg_a[3] ^ b[1];
		reg_a[2]=reg_a[2] ^ b[0];
		q[2]=1'b1;
		     end

		
		if(reg_a[5:1]<b[4:0])
		begin q[1]=1'b0; end
		else begin 
		reg_a[5]=reg_a[5] ^ b[4];
		reg_a[4]=reg_a[4] ^ b[3];
		reg_a[3]=reg_a[3] ^ b[2];
		reg_a[2]=reg_a[2] ^ b[1];
		reg_a[1]=reg_a[1] ^ b[0];
		q[1]=1'b1;
		     end

		
		if(reg_a[4:0]<b[4:0] & (reg_a[4]!=1'b1))
		 begin 
		r[4]=reg_a[4];
		r[3]=reg_a[3];
		r[2]=reg_a[2];
		r[1]=reg_a[1];
		r[0]=reg_a[0];
		q[0]=1'b0; 
		end
		
		else begin 
		r[4]=reg_a[4] ^ b[4];
		r[3]=reg_a[3] ^ b[3];
		r[2]=reg_a[2] ^ b[2];
		r[1]=reg_a[1] ^ b[1];
		r[0]=reg_a[0] ^ b[0];
		q[0]=1'b1;
		q[0]=1'b1;
		     end

	end

	
	else if(a[6]==1)
	begin

		q[3]=1'b0;q[2]=1'b1;
		reg_a[6]=reg_a[6] ^ b[4];
		reg_a[5]=reg_a[5] ^ b[3];
		reg_a[4]=reg_a[4] ^ b[2];
		reg_a[3]=reg_a[3] ^ b[1];
		reg_a[2]=reg_a[2] ^ b[0];
	
		if(reg_a[5:1]<b[4:0])
		begin q[1]=1'b0; end
		else begin 
		reg_a[5]=reg_a[5] ^ b[4];
		reg_a[4]=reg_a[4] ^ b[3];
		reg_a[3]=reg_a[3] ^ b[2];
		reg_a[2]=reg_a[2] ^ b[1];
		reg_a[1]=reg_a[1] ^ b[0];
		q[1]=1'b1;
		     end

		if(reg_a[4:0]<b[4:0] & (reg_a[4]!=1'b1))

		begin q[0]=1'b0;
		r[4]=reg_a[4];
		r[3]=reg_a[3];
		r[2]=reg_a[2];
		r[1]=reg_a[1];
		r[0]=reg_a[0];
		 end
		else begin 
		r[4]=reg_a[4] ^ b[4];
		r[3]=reg_a[3] ^ b[3];
		r[2]=reg_a[2] ^ b[2];
		r[1]=reg_a[1] ^ b[1];
		r[0]=reg_a[0] ^ b[0];
		q[0]=1'b1;
		
		     end

	end

	else if(a[5]==1)
	begin

		q[3]=1'b0;q[2]=1'b0;q[1]=1'b1;
		reg_a[5]=reg_a[5] ^ b[4];
		reg_a[4]=reg_a[4] ^ b[3];
		reg_a[3]=reg_a[3] ^ b[2];
		reg_a[2]=reg_a[2] ^ b[1];
		reg_a[1]=reg_a[1] ^ b[0];

		if(reg_a[4:0]<b[4:0] & (reg_a[4]!=1'b1))
		begin 
		r[4]=reg_a[4];
		r[3]=reg_a[3];
		r[2]=reg_a[2];
		r[1]=reg_a[1];
		r[0]=reg_a[0];
		q[0]=1'b0; end
		else begin 
		r[4]=reg_a[4] ^ b[4];
		r[3]=reg_a[3] ^ b[3];
		r[2]=reg_a[2] ^ b[2];
		r[1]=reg_a[1] ^ b[1];
		r[0]=reg_a[0] ^ b[0];
		q[0]=1'b1;
		     end
		
	end

	else if(a[4]==1)
	begin
		q[3]=1'b0;q[2]=1'b0;q[1]=1'b0;q[0]=1'b1;
		r[4]=reg_a[4] ^ b[4];
		r[3]=reg_a[3] ^ b[3];
		r[2]=reg_a[2] ^ b[2];
		r[1]=reg_a[1] ^ b[1];
		r[0]=reg_a[0] ^ b[0];
		q[0]=1'b1;

	end

end
end
endmodule


//module modulo(q,r,a,b);
module tb_modulo();
wire [4:0]r; 
reg [7:0]a;
reg [4:0]b;
modulo uut(.r(r),.a(a),.b(b));
initial begin
a=8'b01001010;b=5'b10011;
#10 a=8'b00010011;b=5'b10011;
#10 a=8'b10100000; b=5'b10011;
#10 a=8'b00010010; b=5'b10011;
#10 a=8'b00000010; b=5'b10011;
#10 a=8'b00010011;b=5'b10011;
#10 a=8'b00011110; b=5'b10011;
#40 $stop;
end
endmodule
