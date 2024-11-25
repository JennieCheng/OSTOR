
t =200;
m = 10; 
n = 100; 
t_line=1:t;
linegap=10;
t_line_gap=1:linegap:t;


b = rand(t, m, n) * 5; 
a = 20+rand(t,m) * 10; 
B = 7000+rand(n,1)*1000;

% % traffic dataset
% vj=20+rand(1,n)*20;
% v = readtable('traffic200.csv');
% v=v{:,1};
% v=v+vj;
% 
% [sigma,phi,profit0,u,d]=ostor(v,b,a,B,0);
% [sigma,phi,profit1,u,d]=ostor(v,b,a,B,1);
% [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
% [sigma,phi,profit3,u,d]=ostor(v,b,a,B,3);
% [sigma,phi,profit4,u,d]=ostor(v,b,a,B,4);
% 
% sum(profit0)/t
% sum(profit1)/t
% sum(profit2)/t
% sum(profit3)/t
% sum(profit4)/t


% % 
% %% iot dataset
vj=20+rand(1,n)*20;
v = readtable('ddos200_2.csv');
v=v{:,1}*0.001;
v(isnan(v)) = 30;
v(isinf(v)) = 30;
v(v<0)=30;
v=v+vj;

[sigma,phi,profit0,u,d]=ostor(v,b,a,B,0);
[sigma,phi,profit1,u,d]=ostor(v,b,a,B,1);
[sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
[sigma,phi,profit3,u,d]=ostor(v,b,a,B,3);
[sigma,phi,profit4,u,d]=ostor(v,b,a,B,4);

sum(profit0)/t
sum(profit1)/t
sum(profit2)/t
sum(profit3)/t
sum(profit4)/t

