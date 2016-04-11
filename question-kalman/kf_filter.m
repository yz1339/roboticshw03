function newppp = kf_filter(ppp,i)
    
    newppp = ppp(i);
    k = 1;
    pk = newppp.Q;

    xhatk = newppp.XH(:,1);
    newppp.XH(:,1) = xhatk;
    while k < newppp.N
        
        k = k + 1;
        % predict
        
        xhatk = newppp.A * xhatk;
        pk = newppp.A * pk * newppp.A;
        % update
        gk = pk/(pk + newppp.R);
        xhatk = xhatk + gk * (newppp.ZZ(:,k) - xhatk);
        newppp.XH(:,k) = xhatk;
        pk = (1 - gk) * pk;
       
    end
    %TODO: covariance P
    
    
end

