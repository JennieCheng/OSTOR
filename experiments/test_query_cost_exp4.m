t =20;
m = 10; 
n = 100; 

queries=100:50:600;
np=size(queries,2);
profitstr=zeros(np,4);
profitsiot=zeros(np,4);
profitsuni=zeros(np,4);
profitsnom=zeros(np,4);

s=1;
b=[];

for i=1:np
    newadd=[];
    if i==1
        newadd=rand(t,m,queries(1));
    else
        newadd=rand(t,m,queries(i)-queries(i-1));
    end
    n=queries(i);
    b=cat(3,b,newadd);
    n=queries(i);
    a = 20+rand(t,m) * 10; 
    B = 7000+rand(n,1)*1000;
    
    mn=1:n;
    mm=1:m;
    
    %% traffic dataset
    vj=20+rand(1,n)*20;
    v = readtable('traffic200.csv');
    v=v{:,1};
    v=v+vj;
    
    [sigma2,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma3,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma4,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    aplan0=[];
    aplan2=[];
    aplan3=[];
    aplan4=[];
    for t=1:t
        for j=mn
           if sigma2(t,j)>0
                profitstr(s,2)=profitstr(s,2)+b(t,sigma2(t,j),j);
                if ~ismember(sigma2(t,j),aplan2)
                    aplan2(end+1)=sigma2(t,j);
                    profitstr(s,2)=profitstr(s,2)+a(t,sigma2(t,j));
                end
           end
            if sigma3(t,j)>0
                profitstr(s,3)=profitstr(s,3)+b(t,sigma3(t,j),j);
                if ~ismember(sigma3(t,j),aplan3)
                    aplan3(end+1)=sigma3(t,j);
                    profitstr(s,3)=profitstr(s,3)+a(t,sigma3(t,j));
                end
            end
            if sigma4(t,j)>0
                profitstr(s,4)=profitstr(s,4)+b(t,sigma4(t,j),j);
                if ~ismember(sigma4(t,j),aplan4)
                    aplan4(end+1)=sigma4(t,j);
                    profitstr(s,4)=profitstr(s,4)+a(t,sigma4(t,j));
                end
            end
        end
    end
    
    %% iot dataset
    vj=20+rand(1,n)*20;
    v = readtable('ddos200_2.csv');
    v=v{:,1}*0.001;
    v(isnan(v)) = 30;
    v(isinf(v)) = 30;
    v(v<0)=30;
    v=v+vj;
    
    [sigma2,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma3,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma4,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    aplan0=[];
    aplan2=[];
    aplan3=[];
    aplan4=[];
    for t=1:t
        for j=mn
           if sigma2(t,j)>0
                profitsiot(s,2)=profitsiot(s,2)+b(t,sigma2(t,j),j);
                if ~ismember(sigma2(t,j),aplan2)
                    aplan2(end+1)=sigma2(t,j);
                    profitsiot(s,2)=profitsiot(s,2)+a(t,sigma2(t,j));
                end
           end
            if sigma3(t,j)>0
                profitsiot(s,3)=profitsiot(s,3)+b(t,sigma3(t,j),j);
                if ~ismember(sigma3(t,j),aplan3)
                    aplan3(end+1)=sigma3(t,j);
                    profitsiot(s,3)=profitsiot(s,3)+a(t,sigma3(t,j));
                end
            end
            if sigma4(t,j)>0
                profitsiot(s,4)=profitsiot(s,4)+b(t,sigma4(t,j),j);
                if ~ismember(sigma4(t,j),aplan4)
                    aplan4(end+1)=sigma4(t,j);
                    profitsiot(s,4)=profitsiot(s,4)+a(t,sigma4(t,j));
                end
            end
        end
    end
   
    %% uniform
    v= 20+rand(t,n)*50;
    v_b= 10+20*rand(t,m,n);
    b=zeros(size(v_b));
    for t=1:t
        for i=1:m
            for j=1:n
                b(t,i,j)=-v_b(t,i,j)+v(t,j);
            end
        end
    end
    
    [sigma2,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma3,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma4,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    aplan0=[];
    aplan2=[];
    aplan3=[];
    aplan4=[];
    for t=1:t
        for j=mn
           if sigma2(t,j)>0
                profitsuni(s,2)=profitsuni(s,2)+b(t,sigma2(t,j),j);
                if ~ismember(sigma2(t,j),aplan2)
                    aplan2(end+1)=sigma2(t,j);
                    profitsuni(s,2)=profitsuni(s,2)+a(t,sigma2(t,j));
                end
           end
            if sigma3(t,j)>0
                profitsuni(s,3)=profitsuni(s,3)+b(t,sigma3(t,j),j);
                if ~ismember(sigma3(t,j),aplan3)
                    aplan3(end+1)=sigma3(t,j);
                    profitsuni(s,3)=profitsuni(s,3)+a(t,sigma3(t,j));
                end
            end
            if sigma4(t,j)>0
                profitsuni(s,4)=profitsuni(s,4)+b(t,sigma4(t,j),j);
                if ~ismember(sigma4(t,j),aplan4)
                    aplan4(end+1)=sigma4(t,j);
                    profitsuni(s,4)=profitsuni(s,4)+a(t,sigma4(t,j));

                end
            end
        end
    end
    
    %% norm
    v= normrnd(50, 10, [t, n]);   
    [sigma2,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma3,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma4,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    aplan0=[];
    aplan2=[];
    aplan3=[];
    aplan4=[];
    for t=1:t
        for j=mn
           if sigma2(t,j)>0
                profitsnom(s,2)=profitsnom(s,2)+b(t,sigma2(t,j),j);
                if ~ismember(sigma2(t,j),aplan2)
                    aplan2(end+1)=sigma2(t,j);
                    profitsnom(s,2)=profitsnom(s,2)+a(t,sigma2(t,j));
                end
           end
            if sigma3(t,j)>0
                profitsnom(s,3)=profitsnom(s,3)+b(t,sigma3(t,j),j);
                if ~ismember(sigma3(t,j),aplan3)
                    aplan3(end+1)=sigma3(t,j);
                    profitsnom(s,3)=profitsnom(s,3)+a(t,sigma3(t,j));
                end
            end
            if sigma4(t,j)>0
                profitsnom(s,4)=profitsnom(s,4)+b(t,sigma4(t,j),j);
                if ~ismember(sigma4(t,j),aplan4)
                    aplan4(end+1)=sigma4(t,j);
                    profitsnom(s,4)=profitsnom(s,4)+a(t,sigma4(t,j));
                end
            end
        end
    end
    s=s+1;
end

s1=sum(profitstr(:,2))/t;
s2=sum(profitstr(:,3))/t;
s3=sum(profitstr(:,4))/t;

t1=(s2-s1)/s2
t2=(s3-s1)/s3

s1=sum(profitsiot(:,2))/t;
s2=sum(profitsiot(:,3))/t;
s3=sum(profitsiot(:,4))/t;

i1=(s2-s1)/s2
i2=(s3-s1)/s3

s1=sum(profitsuni(:,2))/t;
s2=sum(profitsuni(:,3))/t;
s3=sum(profitsuni(:,4))/t;

u1=(s2-s1)/s2
u2=(s3-s1)/s3


s1=sum(profitsnom(:,2))/t;
s2=sum(profitsnom(:,3))/t;
s3=sum(profitsnom(:,4))/t;

n1=(s2-s1)/s2
n2=(s3-s1)/s3


figure;
ax=subplot(2, 2, 1);
plot(ax,queries, profitstr(:,2),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
hold on;
plot(ax,queries, profitstr(:,4),'b--s','LineWidth',1.5,'Color',[31/255,146/255,139/255]);
hold on 
plot(ax,queries,profitstr(:,3),'b-d','LineWidth',1.5,'Color',[16/255,70/255,128/255])
hold on 
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Execution Cost','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off

ax=subplot(2, 2, 2);
plot(ax,queries, profitsiot(:,2),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
hold on;
plot(ax,queries, profitsiot(:,4),'b--s','LineWidth',1.5,'Color',[31/255,146/255,139/255]);
hold on 
plot(ax,queries,profitsiot(:,3),'b-d','LineWidth',1.5,'Color',[16/255,70/255,128/255])
hold on 
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Execution Cost','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off

ax=subplot(2, 2, 3);
plot(ax,queries, profitsuni(:,2),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
hold on;
plot(ax,queries, profitsuni(:,4),'b--s','LineWidth',1.5,'Color',[31/255,146/255,139/255]);
hold on 
plot(ax,queries,profitsuni(:,3),'b-d','LineWidth',1.5,'Color',[16/255,70/255,128/255])
hold on 
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Execution Cost','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off

ax=subplot(2, 2, 4);
plot(ax,queries, profitsnom(:,2),'g-o','LineWidth',1.5,'Color',[183/255,34/255,45/255]);
hold on;
plot(ax,queries, profitsnom(:,4),'b--s','LineWidth',1.5,'Color',[31/255,146/255,139/255]);
hold on 
plot(ax,queries,profitsnom(:,3),'b-d','LineWidth',1.5,'Color',[16/255,70/255,128/255])
hold on 
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Execution Cost','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off
