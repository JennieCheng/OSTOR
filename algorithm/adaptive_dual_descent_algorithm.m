function [sigma, phi, X, Y, U, profit] = adaptive_dual_descent_algorithm(b, a)
    m = size(b, 1);  
    n = size(b, 2); 
    mm = 1:m;  
    mn = 1:n; 
    X = [];   
    Y = mm;   
    U = mn;   
    phi = ones(1, n)*100000; 
    sigma = zeros(1, n); 
    redict = zeros(1,m);

    while ~isempty(U)
        t_1 = max(b(setdiff(mm,Y), U), [], 'all'); 
        t_2_values = -inf * ones(1, m); 
        for i=Y
            t_2_i = 0;
            for j = setdiff(mn, U) 
                if phi(j) < b(i, j)
                    t_2_i = t_2_i + (b(i, j) - phi(j));
                end
            end
            for j = U
                t_2_i = t_2_i + b(i, j); 
            end
            t_2_i = t_2_i - a(i);
            t_2_values(i) = t_2_i / length(U);
        end
        [t_2,t_2_idx] = max(t_2_values);
        t=max(t_1,t_2);
        
        if t<=0
            break;
        end
        
        if t==t_1
            for i = setdiff(mm, Y) 
                for j = U
                    if b(i, j) == t
                        sigma(j) = redict(i); 
                        phi(j) = t; 
                        U = setdiff(U, j); 
                        break;
                    end
                end
            end
        else
            Y = setdiff(Y, t_2_idx); 
            if any(phi(j) < b(X, j) & phi(j) < b(t_2_idx, j))
              
                [~, idx] = min(phi(j) < b(X, j) & phi(j) < b(t_2_idx, j));
                redict(t_2_idx) = X(idx); 
            else
                redict(t_2_idx)=t_2_idx;
                X=[X,t_2_idx];
            end

            for j = U
                if b(t_2_idx, j) >= t
                    sigma(j) = redict(t_2_idx);  
                    phi(j) = t_2; 
                    U = setdiff(U, j); 
                end
            end
        end

    end

    profit=0;

    for j=1:n
        if sigma(j)>0
            profit=profit + b(sigma(j),j);
        end
    end

    for i=X
        profit=profit-a(i);
    end
    
    
end
