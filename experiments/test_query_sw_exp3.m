t =100;
m = 10; 
n = 100; 
t_line=1:t;

queries=100:100:600;
np=size(queries,2);
profitstr=zeros(np,3);
profitsiot=zeros(np,3);
profitsuni=zeros(np,3);
profitsnom=zeros(np,3);


s=1;
b=[];
for i=1:np
    newadd=[];
    if i==1
        newadd=rand(t,m,queries(1))*5;
    else
        newadd=rand(t,m,queries(i)-queries(i-1))*5;
    end
    n=queries(i);
    b=cat(3,b,newadd);
    a = 20+rand(t,m) * 10; 
    B = 7000+rand(n,1)*1000;
    
   
%% traffic dataset
    vj=20+rand(1,n)*20;
    v = readtable('traffic200.csv');
    v=v{:,1};
    v=v+vj;
    
   
    [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    if sum(profit2)/t>0
        profitstr(s,1)=sum(profit2)/t;
    end
    if sum(profit3)/t>0
        profitstr(s,3)=sum(profit3)/t;
    end
    if sum(profit4)/t>0
        profitstr(s,2)=sum(profit4)/t;
    end
   
    
    
    %% iot
    vj=20+rand(1,n)*20;
    v = readtable('ddos200_2.csv');
    v=v{:,1}*0.001;
    v(isnan(v)) = 30;
    v(isinf(v)) = 30;
    v(v<0)=30;
    v=v+vj;

    [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
 
    if sum(profit2)/t>0
        profitsiot(s,1)=sum(profit2)/t;
    end
    if sum(profit3)/t>0
        profitsiot(s,3)=sum(profit3)/t;
    end
    if sum(profit4)/t>0
        profitsiot(s,2)=sum(profit4)/t;
    end
   
    
    
    %%uniform dataset
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
 
    [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    
    if sum(profit2)/t>0
        profitsuni(s,1)=sum(profit2)/t;
    end
    if sum(profit3)/t>0
        profitsuni(s,3)=sum(profit3)/t;
    end
    if sum(profit4)/t>0
        profitsuni(s,2)=sum(profit4)/t;
    end
    
    %%norm dataset
    v= normrnd(50, 10, [t, n]);
    
    [sigma,phi,profit2,u,d]=ostor(v,b,a,B,2);
    [sigma,phi,profit3,u,d]=tradition1(v,b,a,B);
    [sigma,phi,profit4,u,d]=tradition2(v,b,a,B,0);
    
    if sum(profit2)/t>0
        profitsnom(s,1)=sum(profit2)/t;
    end
    if sum(profit3)/t>0
        profitsnom(s,3)=sum(profit3)/t;
    end
    if sum(profit4)/t
        profitsnom(s,2)=sum(profit4)/t;
    end
    s=s+1;
end


display('1');
s1=profitstr(:,1);
s2=profitstr(:,2);
s3=profitstr(:,3);
t1=sum(s1);
t2=sum(s2);
t3=sum(s3);

(t1-t2)/t1
(t1-t2)/t2

(t1-t3)/t1
(t1-t3)/t3


figure;
ax=subplot(2, 2, 1);
% profitstr(:,2)=sort(profitstr(:,2),'descend');
b = bar(queries, profitstr, 'grouped');
colors = {
    [183/255,34/255,45/255],
    [114/255, 170/255, 207/255],
    [57/255, 81/255, 162/255]
    
};
for i = 1:3
    b(i).FaceColor = colors{i};
end
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Social Welfare','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off


ax=subplot(2, 2, 2);

display('2');
s1=profitsiot(:,1);
s2=profitsiot(:,2);
s3=profitsiot(:,3);
t1=sum(s1);
t2=sum(s2);
t3=sum(s3);

(t1-t2)/t1
(t1-t2)/t2

(t1-t3)/t1
(t1-t3)/t3

b = bar(queries, profitsiot, 'grouped');
for i = 1:3
    b(i).FaceColor = colors{i};
end
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Social Welfare','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off

ax=subplot(2, 2, 3);
display('3')
s1=profitsuni(:,1);
s2=profitsuni(:,2);
s3=profitsuni(:,3);
t1=sum(s1);
t2=sum(s2);
t3=sum(s3);

(t1-t2)/t1
(t1-t2)/t2

(t1-t3)/t1
(t1-t3)/t3

b = bar(queries, profitsuni, 'grouped');
for i = 1:3
    b(i).FaceColor = colors{i};
end
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Social Welfare','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off


ax=subplot(2, 2, 4);
display('4');
s1=profitsnom(:,1);
s2=profitsnom(:,2);
s3=profitsnom(:,3);
t1=sum(s1);
t2=sum(s2);
t3=sum(s3);

(t1-t2)/t1
(t1-t2)/t2

(t1-t3)/t1
(t1-t3)/t3

b = bar(queries, profitsnom, 'grouped');
for i = 1:3
    b(i).FaceColor = colors{i};
end
set(ax, 'FontName','Times New Roman','FontSize',10);
xlabel(ax,'Number of Queries','FontSize',12,'FontName','Times New Roman');
ylabel(ax,'Social Welfare','FontSize',12,'FontName','Times New Roman');
legend(ax,'OSTOR','TNA','TOFF', 'FontSize',11,'FontName','Times New Roman')
hold off