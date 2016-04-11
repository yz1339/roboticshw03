% this is a function to perform kalman filter on input ppp, which should
% have observation states and actual states calculated.
function kf_ppp = kf_filter(newppp)
    
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
        % covariance P
        newppp.PH(:,k) = {cov(newppp.XH(:,k), newppp.ZZ(:,k))};
    end

    kf_ppp = newppp;
    
end

