function kf_ppp = kf_test(ppp,i)
    newppp = ppp(i);
    k = 1;
    xk = [newppp.s0; newppp.v0];
    xxk = xk + newppp.PN(:,k);
    newppp.XI(:,k) = xk;
    newppp.XX(:,k) = xxk;
    zzk = xxk + newppp.ON(:,k);
    newppp.ZZ(:,k) = zzk;
    while k < newppp.N
        k = k + 1;
        % this part calculate each ideal state 
        xk = newppp.A * xk;
        newppp.XI(:,k) = xk;
        % this part calculate each actual (unknown) state 
        xxk = xk + newppp.PN(:,k);
        newppp.XX(:,k) = xxk;
        % this part calculate each observed state
        zzk = xxk + newppp.ON(:,k);
        newppp.ZZ(:,k) = zzk;
    end
    
    kf_ppp = kf_filter(newppp,i);
    
    % this is figure A plot (XI)
    figure
    x = 1:1:15;
    ax1 = subplot(2,1,1); % top subplot
    ax2 = subplot(2,1,2); % bottom subplot
    
    p1 = plot(ax1, x, kf_ppp.XI(1,:), x, kf_ppp.XI(2,:));
    set(p1, 'LineStyle', '--');
    title(ax1, '(A.1) Ideal Distance (resp., Speed) vs Time')
    
    p2 = plot(ax2, kf_ppp.XI(1,:),kf_ppp.XI(2,:),'Color',[0,0,0.9]);
    title(ax2, '(A.2) Ideal Distance - Speed Plots')
    xlabel(ax2, 'Distance')
    ylabel(ax2, 'speed')
    set(p2, 'LineStyle', '--');
    
   
    
    % this is figure B plot (XX)
    figure
    x = 1:1:15;
    ax1 = subplot(2,1,1); % top subplot
    ax2 = subplot(2,1,2); % bottom subplot
    
    p1 = plot(ax1, x, kf_ppp.XX(1,:), x, kf_ppp.XX(2,:), x, kf_ppp.ZZ(1,:), x, kf_ppp.ZZ(2,:));
    set(p1, 'LineStyle', '--');
    set(p1(1), 'color', 'blue');
    set(p1(2), 'color', 'blue');
    set(p1(3), 'color', 'cyan');
    set(p1(4), 'color', 'cyan');
    title(ax1, '(B.1) Observed distance (resp., Speed) vs Time (cyan) vs Actual (blue)')
    
    p2 = plot(ax2, kf_ppp.XX(1,:),kf_ppp.XX(2,:),kf_ppp.ZZ(1,:),kf_ppp.ZZ(2,:));
    title(ax2, '(B.2) Observed distance - Speed (cyan) vs Actual (blue)')
    xlabel(ax2, 'noisy distance')
    ylabel(ax2, 'noisy speed')
    set(p2, 'LineStyle', '--');
    set(p2(1), 'color', 'blue');
    set(p2(2), 'color', 'cyan');
    
    % this is figure C plot (XX and XH)
    figure
    x = 1:1:15;
    ax1 = subplot(2,1,1); % top subplot
    ax2 = subplot(2,1,2); % bottom subplot
    
    p1 = plot(ax1, x, kf_ppp.XH(1,:), x, kf_ppp.XH(2,:), x, kf_ppp.XX(1,:), x, kf_ppp.XX(2,:));
    set(p1, 'LineStyle', '--');
    set(p1(1), 'color', 'green');
    set(p1(2), 'color', 'green');
    set(p1(3), 'color', 'blue');
    set(p1(4), 'color', 'blue');
    title(ax1, '(C.1) KF distance (resp., Speed) vs Time (green) vs Actual (blue)')
    
    p2 = plot(ax2, kf_ppp.XH(1,:),kf_ppp.XH(2,:),kf_ppp.XX(1,:),kf_ppp.XX(2,:));
    title(ax2, '(C.2) KF distance - Speed (green) vs Actual (blue)')
    xlabel(ax2, 'KF distance')
    ylabel(ax2, 'KF speed')
    set(p2, 'LineStyle', '--');
    set(p2(1), 'color', 'green');
    set(p2(2), 'color', 'blue');
end


%plotting goes here