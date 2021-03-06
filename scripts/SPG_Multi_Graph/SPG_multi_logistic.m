function [beta, obj, density, iter,  time]=SPG_multi_logistic(Y, X, gamma, lambda, C, CNorm, option)
%Y multi-task outputs
%X input design matrix
%gamma:  regularization for group norm
%lambda: regularization for L1 penalty 
%C:  \sum_|g| by |E|
%CNorm: ||C||^2
%option: maxiter; tol, b0 ; 

    [N, J] = size(X);
    [K] = size(Y,2);
    
    if isfield(option,'maxiter')
        maxiter=option.maxiter;
    else
        maxiter=10000;
    end
    
    if isfield(option, 'verbose')
        verbose=option.verbose;
    else
        verbose=true;
    end  

    if isfield(option, 'display_iter')
        display_iter=option.display_iter;
    else
        display_iter=true;
    end  
    
    if isfield(option, 'tol')
        tol=option.tol;
    else
        tol=1e-7;
    end
    
    if isfield(option, 'b_init')
        beta=option.b_init;
    else
        beta=zeros(J,K);
    end  
    
    if isfield(option, 'mu')
        mu=option.mu;
    else
        mu=1e-4;
    end 
    
    obj=zeros(maxiter, 1);
    density=zeros(maxiter, 1);
    W=beta;
    theta=1;
     
    C=gamma*C;
            
    tic;    
    
    XX=X'*X;  %J by J matrix
    
    L=sum(XX(:).^2)
    clear XX XY
    
    for iter=1:maxiter
        
        A=hard_threshold(full(C*W'/mu), 1);
        

%here is the logisitic change
logisticWX= exp(X*W)./repmat(sum(exp(X*W),2),1,size(W,2));

        grad=X'*(logisticWX-Y)+A'*C;
                       
        V=W-(1/L)*grad;
        
        [beta_new, density(iter)]=soft_threshold(V(:), lambda/L);
        beta_new=reshape(beta_new, J, K);
        density(iter)=density(iter)/(J*K);
                
        theta_new=(sqrt(theta^4+4*theta^2)-theta^2)/2;
        
        W=beta_new+(1-theta)/theta*theta_new*(beta_new-beta);
        
        %obj(iter)= sum(sum((Y-X*beta_new).^2))/2+ sum(sum(abs(C*beta_new')))+lambda*sum(abs(beta_new(:)));
        %different objective too

obj(iter)= sum(sum((Y-(exp(X*beta_new)./repmat(sum(exp(X*W),2),1,size(W,2)))).^2))/2+ sum(sum(abs(C*beta_new')))+lambda*sum(abs(beta_new(:)));
        
        if (iter>10 && (abs(obj(iter)-obj(iter-1))/abs(obj(iter-1))<tol))
              break;
        end
 
        
        if (verbose && (iter==1 || mod(iter, display_iter)==0))
            fprintf('Iter %d, Obj: %g, density: %f\n', iter, obj(iter), density(iter));
        end
       
        
        beta=beta_new;
        theta=theta_new;
        
    end    
    time=toc;
    
        
    if (verbose)
        fprintf('Iter %d, Obj: %g, density: %f\n', iter, obj(iter), density(iter));
    end
    
    obj=obj(iter);
    density=density(iter);    

end 
