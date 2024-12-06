function [sigma, phi, X, Y, U, profit] = reassign(b, a, sigma, phi, X, Y, U, profit,tb)
    m = size(b, 1); 
    n = size(b, 2); 
    mm = 1:m; 
    mn = 1:n; 
    
    for i=X
        for j=mn
            if sigma(j)>0 && tb(i,j)>tb(sigma(j),j)
                profit=profit+tb(i,j)-tb(sigma(j),j);
                sigma(j)=i;
            end
        end
    end
    
end
