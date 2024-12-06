function [sigma,phi,profit,u,d] = tradition1( v, b, a, B)
       
    T=size(b,1);
    M=size(b,2);
    N=size(b,3);
    
    mm=1:M;
    mn=1:N;
    
    sigma = zeros(T,N);
    phi=zeros(T,N); 
    profit=zeros(T,1);
    
    
    u = zeros(T, N);    
    d = zeros(T, N);
    
    
    tb=zeros(T,M,N);
    for t=1:T
        for i=1:M
            for j=1:N
                tb(t,i,j)=v(t,j)-b(t,i,j);
            end
        end
    end
    
    
    bt=squeeze(tb(1,:,:));
    at=squeeze(a(1,:));
    [sigma_o, phi_o, X, Y, U, profit_o]=adaptive_dual_descent_algorithm(bt, at);
    sigma=repmat(sigma_o,t,1); 
    profit(1)=profit_o;
    for t = 2:T
        for j=mn
            if sigma_o(j)>0 && B(j)>=v(t,j)
                profit(t)=profit(t)+(v(t,j)-b(t,sigma_o(j),j));
                B(j)=B(j)-v(t,j);
             end
        end
        
        for i=X
            profit(t)=profit(t)-a(t,i);
        end
                    
    end
end
