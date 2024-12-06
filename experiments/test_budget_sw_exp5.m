t =100;
m = 10; 
n = 100; 
t_line=1:t;

budgetsmean=1000:1000:10000;
budgetsstd=100:100:1000;
nbm=size(budgetsmean,2);
nbs=size(budgetsstd,2);
profitstr=zeros(nbm,nbs);
profitsiot=zeros(nbm,2);
profitsuni=zeros(nbm,2);
profitsnom=zeros(nbm,2);



s=1;
for i=1:nbm
    for j=1:nbs
        b = rand(t, m, n) * 5; 
        a = 20+rand(t,m) * 10; 
        B = budgetsmean(i)+rand(n,1)*budgetsstd(j);
        % traffic 
        vj=20+rand(1,n)*20;
        v = readtable('traffic200.csv');
        v=v{:,1};
        v=v+vj;
        [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
        profitstr(i,j)=sum(profit2)/t;
        % iot
        vj=20+rand(1,n)*20;
        v = readtable('ddos200_2.csv');
        v=v{:,1}*0.001;
        v(isnan(v)) = 30;
        v(isinf(v)) = 30;
        v(v<0)=30;
        v=v+vj;
        [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
        profitsiot(i,j)=sum(profit2)/t;
        % uniform
        v= 20+rand(t,n)*50;
        v_b= 10+20*rand(t,m,n);
        b=zeros(size(v_b));
        for t=1:t
            for ii=1:m
                for jj=1:n
                    b(t,ii,jj)=-v_b(t,ii,jj)+v(t,jj);
                end
            end
        end
        [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
        profitsuni(i,j)=sum(profit2)/t;
        
        %norm
        v= normrnd(50, 10, [t, n]);
        [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
        profitsnom(i,j)=sum(profit2)/t;
    end
end

figure(1)
[xx,yy]=meshgrid(budgetsmean,budgetsstd);
surf(xx,yy,profitstr);
xlabel('Mean of Budgets','FontSize',12,'FontName','Times New Roman');
ylabel('Range of Budgets','FontSize',12,'FontName','Times New Roman');
zlabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% colorbar


figure(2)
[xx,yy]=meshgrid(budgetsmean,budgetsstd);
surf(xx,yy,profitsiot);
xlabel('Mean of Budgets','FontSize',12,'FontName','Times New Roman');
ylabel('Range of Budgets','FontSize',12,'FontName','Times New Roman');
zlabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% colorbar

figure(3)
[xx,yy]=meshgrid(budgetsmean,budgetsstd);
surf(xx,yy,profitsuni);
xlabel('Mean of Budgets','FontSize',12,'FontName','Times New Roman');
ylabel('Range of Budgets','FontSize',12,'FontName','Times New Roman');
zlabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% colorbar

figure(4)
[xx,yy]=meshgrid(budgetsmean,budgetsstd);
surf(xx,yy,profitsnom);
xlabel('Mean of Budgets','FontSize',12,'FontName','Times New Roman');
ylabel('Range of Budgets','FontSize',12,'FontName','Times New Roman');
zlabel('Social Welfare','FontSize',12,'FontName','Times New Roman');
% colorbar