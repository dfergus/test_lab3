function [Pb_u,Pb_c_hard,Pb_c_soft]=hamhsc(N,epsElon)

t=2^0.5*(erfinv(2*epsElon-1));
b=round(rand(N,1));
b_u=b;
for i=1:length(b)
   noise=Gngauss(0,1);
   if noise<t b_u(i)=mod(b(i)+1,2);
   end
if noise==t i=i-1;
   end
end
Pb_u=epsElon

b_c_hard=encode(b,7,4,'hamming');
received_hard=b_c_hard;
for i=1:length(b_c_hard)
   noise=Gngauss(0,sqrt(n/k));
   if noise<t received_hard(i)=mod(b_c_hard(i)+1,2);
   end
   if noise==t i=i-1;
   end
end
e=decode(received_hard,n,k,'hamming');
Pb_c_hard=sum(mod((b+e),2))/N

b_c_soft=(-1).^b_c_hard;
beb=b_c_soft';
received_soft=b_c_soft;
sigma=sqrt(7/4)/(sqrt(2)*erfinv(1-2*epsElon));
for i=1:length(b_c_soft)
   noise(i)=Gngauss(0,sigma);
   received_soft(i)=received_soft(i)+noise(i); 
end
   
received_soft=received_soft';
   
codewords=[1 1 1 1 1 1 1;-1 1 -1 1 1 1 -1;-1 -1 -1 1 1 -1 1;1 -1 1 1 1 -1 -1;
1 -1 -1 1 -1 1 1;-1 -1 1 1 -1 1 -1;-1 1 1 1 -1 -1 1;1 1 -1 1 -1 -1 -1;
-1 -1 1 -1 1 1 1;1 -1 -1 -1 1 1 -1;1 1 -1 -1 1 -1 1;-1 1 1 -1 1 -1 -1;
-1 1 -1 -1 -1 1 1;1 1 1 -1 -1 1 -1;1 -1 1 -1 -1 -1 1;-1 -1 -1 -1 -1 -1 -1];

message_words=[0 0 0 0;0 0 0 1;0 0 1 0;0 0 1 1;
0 1 0 0;0 1 0 1;0 1 1 0;0 1 1 1;
1 0 0 0;1 0 0 1;1 0 1 0;1 0 1 1;
1 1 0 0;1 1 0 1;1 1 1 0;1 1 1 1];

for j=1:length(received_soft)/7
   re(j,:)=received_soft((j-1)*7+1:(j-1)*7+7);
   end

for m=1:length(received_soft)/7
   for i=1:16
      code_word=codewords(i,:);
      err(i)=sum((re(m,:)-code_word).^2);
   end
   [a,b1]=min(err);
   message(m,:)=message_words(b1,:);
end
[a1,b2]=size(message);
e_soft=message(1:a1,:);
b=b';
for j=1:length(b)/4
   e1(j,:)=b((j-1)*4+1:(j-1)*4+4);
end
Pb_c_soft=sum(sum(mod(e1+e_soft,2)))/N
   
                  
