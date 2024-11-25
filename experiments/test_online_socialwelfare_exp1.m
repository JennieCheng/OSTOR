
t =200;
m = 20; 
n = 100; 
t_line=1:t;
linegap=10;
t_line_gap=1:linegap:t;


b = rand(t, m, n) * 5; 
a = 20+rand(t,m) * 10; 
B = 7000+rand(n,1)*1000;

% traffic dataset
% vj=20+rand(1,n)*20;
% v = readtable('traffic200.csv');
% v=v{:,1};
% v=v+vj;
% 
% [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
% [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
% [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
% 
% 
% figure('Position', [100, 100, 260, 180]);
% % ax=subplot(2, 2, 1);
% plot(t_line_gap, profit2(t_line_gap),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
% hold on;
% plot(t_line_gap, profit4(t_line_gap),'b--d','LineWidth',1.5,'Color',[31/255,146/255,139/255])
% hold on;
% plot(t_line_gap, profit3(t_line_gap),'b-s','LineWidth',1.5,'Color',[16/255,70/255,128/255]);
% hold on;
% % ylim([1000 5000]);
% 
% t1=sum(profit2(t_line_gap))
% t2=sum(profit3(t_line_gap))
% t3=sum(profit4(t_line_gap))
% 
% (t1-t2)/t1
% (t1-t2)/t2
% 
% (t1-t3)/t1
% (t1-t3)/t1
% 
% set(gca,'FontName','Times New Roman','FontSize',10);
% xlabel('Time Slots','FontSize',12,'FontName','Times New Roman');
% ylabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% legend('OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman');
% ylim([0, 6000]);

% box on;
% zp = BaseZoom();
% zp.run;


% % 
% % %% iot dataset
% vj=20+rand(1,n)*20;
% v = readtable('ddos200_2.csv');
% v=v{:,1}*0.001;
% v(isnan(v)) = 30;
% v(isinf(v)) = 30;
% v(v<0)=30;
% v=v+vj;
% 
% [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
% [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
% [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
% profit2(profit2<0)=0;
% profit3(profit3<0)=0;
% profit4(profit4<0)=0;
% 
% figure('Position', [100, 100, 260, 180]);
% % ax=subplot(2, 2, 1);
% plot(t_line_gap, profit2(t_line_gap),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
% hold on;
% plot(t_line_gap, profit4(t_line_gap),'b--d','LineWidth',1.5,'Color',[31/255,146/255,139/255])
% hold on;
% plot(t_line_gap, profit3(t_line_gap),'b-s','LineWidth',1.5,'Color',[16/255,70/255,128/255]);
% hold on;
% 
% t1=sum(profit2(t_line_gap))
% t2=sum(profit3(t_line_gap))
% t3=sum(profit4(t_line_gap))
% 
% (t1-t2)/t1
% (t1-t2)/t2
% 
% (t1-t3)/t1
% (t1-t3)/t1
% 
% set(gca,'FontName','Times New Roman','FontSize',10);
% xlabel('Time Slots','FontSize',12,'FontName','Times New Roman');
% ylabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% legend('OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman');
% ylim([0, 7]);

% box on;
% zp = BaseZoom();
% zp.run;

% 
% %% uniform dataset
% v= 20+rand(t,n)*50;
% v_b= 10+20*rand(t,m,n);
% b=zeros(size(v_b));
% for t=1:t
%     for i=1:m
%         for j=1:n
%             b(t,i,j)=-v_b(t,i,j)+v(t,j);
%         end
%     end
% end
% 
% [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
% [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
% [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
% profit2(profit2<0)=0;
% profit3(profit3<0)=0;
% profit4(profit4<0)=0;
% 
% figure('Position', [100, 100, 260, 180]);
% % ax=subplot(2, 2, 1);
% plot(t_line_gap, profit2(t_line_gap),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
% hold on;
% plot(t_line_gap, profit4(t_line_gap),'b--d','LineWidth',1.5,'Color',[31/255,146/255,139/255])
% hold on;
% plot(t_line_gap, profit3(t_line_gap),'b-s','LineWidth',1.5,'Color',[16/255,70/255,128/255]);
% hold on;
% 
% t1=sum(profit2(t_line_gap))
% t2=sum(profit3(t_line_gap))
% t3=sum(profit4(t_line_gap))
% 
% (t1-t2)/t1
% (t1-t2)/t2
% 
% (t1-t3)/t1
% (t1-t3)/t1
% 
% set(gca,'FontName','Times New Roman','FontSize',10);
% xlabel('Time Slots','FontSize',12,'FontName','Times New Roman');
% ylabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% legend('OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman');
% % ylim([0, 7]);
% 
% box on;
% zp = BaseZoom();
% zp.run;

% 
% %% normval dataset
v= normrnd(50, 10, [t, n]);


[sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
[sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
[sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
profit2(profit2<0)=0;
profit3(profit3<0)=0;
profit4(profit4<0)=0;

figure('Position', [100, 100, 260, 180]);
% ax=subplot(2, 2, 1);
plot(t_line_gap, profit2(t_line_gap),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
hold on;
plot(t_line_gap, profit4(t_line_gap),'b--d','LineWidth',1.5,'Color',[31/255,146/255,139/255])
hold on;
plot(t_line_gap, profit3(t_line_gap),'b-s','LineWidth',1.5,'Color',[16/255,70/255,128/255]);
hold on;

t1=sum(profit2(t_line_gap))
t2=sum(profit3(t_line_gap))
t3=sum(profit4(t_line_gap))

(t1-t2)/t1
(t1-t2)/t2

(t1-t3)/t1
(t1-t3)/t1

set(gca,'FontName','Times New Roman','FontSize',10);
xlabel('Time Slots','FontSize',12,'FontName','Times New Roman');
ylabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
legend('OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman');
% ylim([0, 7]);

box on;
zp = BaseZoom();
zp.run;
