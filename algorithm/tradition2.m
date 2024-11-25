function [sigma,phi,profit,u,d] = tradition2( v, b, a, B,flag)
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
    

    for t = 1:T
        bt=v(t,:)-squeeze(b(t,:,:));
        at=squeeze(a(t,:));
        
        [sigma_o, phi_o, X, Y, U, profit_o]=adaptive_dual_descent_algorithm(bt, at);
        
        if flag>=1
            [sigma_o, phi_o, X, Y, U, profit_o]=reactivate(bt,at,sigma_o, phi_o, X, Y, U, profit_o);
        end
        
        if flag>=2
            [sigma_o, phi_o, X, Y, U, profit_o]=reassign(bt,at,sigma_o, phi_o, X, Y, U, profit_o);
        end
        
        for j=mn
            if sigma_o(j)>0 && B(j)>=v(t,j)
                profit(t)=profit(t)+(v(t,j)-b(t,sigma_o(j),j));
                B(j)=B(j)-v(t,j);
             end
        end

        for i=X
            profit(t)=profit(t)-a(t,i);
        end

        sigma(t,:)=sigma_o;
                    
    end
end
