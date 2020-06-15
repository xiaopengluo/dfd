function [XTrace,YTrace] = dfd(fun,x1,K,alpha,lambda,rho,n)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

d  = length(x1);
xk = x1;
XTrace = zeros(K,d); 
YTrace = zeros(K,1);
sigma  = lambda;

p  = haltonset(d,'Skip',1);
p  = scramble(p,'RR2');
for i=1:K
    % Generate n random vector from halton sequence
    p.Skip = mod((i-1)*n+1,2^52-n);
    x  = net(p,n);
    t  = norminv(x,xk,1/sigma);
    
    % Compute function value sequence
    f  = fun(t); fk = fun(xk);
    if std(f)==0
        break;
    end

    % Compute a stochastic vector gk and update the new iterate
    f  = f - fk;
    f  = f / sqrt(mean(f.^2));
    xk = xk - alpha*mean(f.*(t-xk),1);

    % Update and record
    sigma = sigma / rho;
    XTrace(i,:) = xk;
    YTrace(i) = fk;
    fprintf('Iter %d - Objective: %d;\n',i,fk);
end

end

