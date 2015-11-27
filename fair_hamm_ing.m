function [Pb_u,Pb_c]=fair_hamm_ing(n,k,N,epsElon)
t=2^0.5*(erfinv(2*epsElon-1));
b=round(rand(N,1));
bb=b;
for i=1:length(b)
   noise=Gngauss(0,1);
   if noise<t bb(i)=mod(b(i)+1,2);
   end
   if noise==t i=i-1;
   end
end
Pb_u=sum(mod((b+bb),2))/N;
c=encode(b,n,k,'hamming');
d=c;
for i=1:length(c)
   noise=Gngauss(0,sqrt(n/k));
   if noise<t d(i)=mod(c(i)+1,2);
   end
   if noise==t i=i-1;
   end
end
e=decode(d,n,k,'hamming');
Pb_c=sum(mod((b+e),2))/N;