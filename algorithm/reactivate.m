
function [sigma, phi, X, Y, U, profit] = reactivate(b, a, sigma, phi, X, Y, U, profit,tb)
    m = size(b, 1);  
    n = size(b, 2);  
    mm = 1:m;  
    mn = 1:n;  
    
    
    while 1
        addprofit=zeros(m,1);
        for i=setdiff(mm,X)
            addprofit(i)=-a(i);
            for j=mn
                if sigma(j)>0 && tb(i,j)>tb(sigma(j),j)
                    addprofit(i)=tb(i,j)-tb(sigma(j),j);
                end
            end
        end
        
        [max_add,idx]=max(addprofit);
        
        if max_add>0
            X=[X,idx];
            for j=mn
                if sigma(j)>0 && tb(idx,j)>tb(sigma(j),j)
                    profit=profit+tb(idx,j)-tb(sigma(j),j);
                    sigma(j)=idx;
                end
            end
        else
            break;
        end
                
    end
        
end




