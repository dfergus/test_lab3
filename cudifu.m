function []=cudifu(X,m)
XMax=max(X);
XMin=min(X);
deltA=XMax-XMin;
Y=hist(X,m);
Z(1)=Y(1);
for i=2:length(Y)
   Z(i)=Z(i-1)+Y(i);
end
plot(XMin:deltA/m:XMax-deltA/m,Z/(sum(Y))); grid;
ylabel('cdf');