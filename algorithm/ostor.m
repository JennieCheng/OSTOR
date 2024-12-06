function [sigma,phi,profit,u,d] = ostor( v, b, a, B, flag)
       
    T=size(b,1);
    M=size(b,2);
    N=size(b,3);
    mn=1:N;
    mm=1:M;
    
    B_t=zeros(T,N);
    B_t(1,:)=B;
    
    sigma = zeros(T,N);
    phi=zeros(T,N); 
    profit=zeros(T,1);
    
    
    u = zeros(T, N);    
    d = zeros(T, N);
    
    zeta=0.7;
    
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
        for j = 1:N
            if u(t-1, j) >= 1
                d(t,j) = 0;
            else
                d(t,j) = v(t,j) * (1 - u(t-1, j));  
            end
        end
        
        
%         bt=v(t,:)-squeeze(b(t,:,:));
        bt=zeros(M,N);
        for i=mm
            for j=mn
                bt(i,j)=d(t,j)-b(t,i,j);
            end
        end
        at=squeeze(a(t,:));
        bt=bt(:,mn);
        
         [sigma_o, phi_o, X, Y, U, profit_o]=adaptive_dual_descent_algorithm(bt, at);
 
                
        if flag==1
            [sigma_o, phi_o, X, Y, U, profit_o]=reactivate(bt,at,sigma_o, phi_o, X, Y, U, profit_o,squeeze(tb(t,:,:)));
        elseif flag==2
            [sigma_o, phi_o, X, Y, U, profit_o]=reassign(bt,at,sigma_o, phi_o, X, Y, U, profit_o,squeeze(tb(t,:,:)));
        elseif flag==3
            [sigma_o, phi_o, X, Y, U, profit_o]=reactivate(bt,at,sigma_o, phi_o, X, Y, U, profit_o,squeeze(tb(t,:,:)));
            [sigma_o, phi_o, X, Y, U, profit_o]=reassign(bt,at,sigma_o, phi_o, X, Y, U, profit_o,squeeze(tb(t,:,:)));
        elseif flag==4
            [sigma_o, phi_o, X, Y, U, profit_o]=reassign(bt,at,sigma_o, phi_o, X, Y, U, profit_o,squeeze(tb(t,:,:)));
            [sigma_o, phi_o, X, Y, U, profit_o]=reactivate(bt,at,sigma_o, phi_o, X, Y, U, profit_o,squeeze(tb(t,:,:)));
        end
        
        
        sigma(t,:)=sigma_o;
        phi(t,:)=phi_o;
        profit_o=0;
        now_n=size(bt,2);
        delete_j=[];
        
        for j=1:now_n
            if sigma_o(j)>0 && B(mn(j))>=v(t,mn(j))
                profit_o=profit_o+tb(t,sigma_o(j),mn(j));
                B(mn(j))=B(mn(j))-v(t,mn(j));
                if B(mn(j))<=0
                    delete_j=[delete_j,j];
                end
            elseif sigma_o(j)>0 && B(mn(j))< v(t,mn(j))
                sigma_o(j)=0;
                X=setdiff(X,[sigma_o(j)]);
            end
        end
        mn(:,delete_j)=[];
        
        profit(t)=profit_o;
        
        mi=zeros(M);
        for j=1:N
            if sigma(t,j)>0
                mi(sigma(t,j))=mi(sigma(t,j))+1;
            end
        end
       
        for j = 1:N
            if sigma(t,j) ~=0
                ti=sigma(t,j);
                B_t(t, j) = B_t(t-1, j) - b(t-1, ti, j) - a(t-1, ti) /mi(ti);
                u(t, j) = u(t-1, j) * (1 + (v(t,j) - b(t-1, ti, j) - a(t-1, ti) /mi(ti)) / B_t(t, j)) + ...
                    zeta* (v(t,j) - b(t-1, ti, j) - a(t-1, ti) /mi(ti)) / B_t(t, j);
            
            else
                u(t,j)=u(t-1,j);
            end
        end
    end
end
