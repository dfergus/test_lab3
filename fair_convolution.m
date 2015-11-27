function [Pb_u,Pb_c]=fair_convolution(G,k,N,epsElon)
t=2^0.5*(erfinv(2*epsElon-1));
b=round(rand(N,1));
b';
bb=b;
for i=1:length(b)
   noise=Gngauss(0,1);
   if noise<t bb(i)=mod(b(i)+1,2);
   end
   if noise==t i=i-1;
   end
end
Pb_u=epsElon;
c=Cnv_encd(G,k,b');
d=c;
[n,M]=size(G);
n
for i=1:length(c)
   noise=Gngauss(0,sqrt(n/k));
   if noise<t d(i)=mod(c(i)+1,2);
   end
   if noise==t i=i-1;
   end
end
[dec_out,survivor_state,cum_met]= viterbi(G,k,d);
dec_out;
Pb_c=sum(mod((b'+dec_out),2))/N;

