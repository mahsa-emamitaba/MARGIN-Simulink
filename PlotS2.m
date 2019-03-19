 function [ ] = PlotS2(user2_successRate, user3_successRate, user2_rejectedRate, ... 
    user3_rejectedRate,user2_timeOutRate, user3_timeOutRate, RQNo, tech)

    group1 = [repmat({'1: Insider'}, length(user2_successRate), 1); ... 
    repmat({'2: Regular'}, length(user3_successRate), 1); ....
    repmat({'3: Insider'}, length(user2_rejectedRate), 1); ....
    repmat({'4: Regular'}, length(user3_rejectedRate), 1); ....
    repmat({'5: Insider'}, length(user2_timeOutRate), 1); ....
    repmat({'6: Regular'}, length(user3_timeOutRate), 1)]; 

    group2 = [repmat({'Attacker'}, length(user2_successRate), 1); ... 
    repmat({'User'}, length(user3_successRate), 1); ....
    repmat({'Attacker'}, length(user2_rejectedRate), 1); ....
    repmat({'User'}, length(user3_rejectedRate), 1); ....
    repmat({'Attacker'}, length(user2_timeOutRate), 1); ....
    repmat({'User'}, length(user3_timeOutRate), 1)]; 
    % 
    group3 = [repmat({'Success'}, length(user2_successRate), 1); ... 
    repmat({'Success'}, length(user3_successRate), 1); ....
    repmat({'Reject'}, length(user2_rejectedRate), 1); ....
    repmat({'Reject'}, length(user3_rejectedRate), 1); ....
    repmat({'Timeout'}, length(user2_timeOutRate), 1); ....
    repmat({'Timeout'}, length(user3_timeOutRate), 1)]; 
    
    h = figure('visible', 'on'); 
    % font size of the x axes text 
    set(h, 'defaulttextfontsize', 9);
    set(h, 'defaulttextfontweight', 'bold');
    set(h, 'position', [10, 10, 600, 250]);
    h2 = boxplot([user2_successRate,user3_successRate, user2_rejectedRate,user3_rejectedRate, user2_timeOutRate,user3_timeOutRate],...
           {group1 group2 group3} );
    ylim([0 110])
    % thickness of boxes
    for ih=1:6
    set(h2(ih,:),'linewidth',2);
    end
    % font size of the y axes
    set(gca,'fontsize',9);
    set(gca,'fontweight','bold'); 
    set(gca, 'position', get(gca, 'outerposition') - ...
         get(gca, 'tightinset') * [-1 0 1 0; 0 -11 0 12; 0 0 2 0; 0 0 0 1])

    % need to save these points for pgfplot in latex  
    csvinput = zeros(6,6);
    for ih = 1:6
        csvinput(ih,:) = [get(h2(2,ih),'YData'), get(h2(6,ih),'YData'), get(h2(1,ih),'YData') ];
    end 

    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-boxplotData.csv', RQNo, tech),csvinput);
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-%d.csv', RQNo, tech, 1),user2_successRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-%d.csv', RQNo, tech, 2),user3_successRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-%d.csv', RQNo, tech, 3),user2_rejectedRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-%d.csv', RQNo, tech, 4),user3_rejectedRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-%d.csv', RQNo, tech, 5),user2_timeOutRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-%d.csv', RQNo, tech, 6),user3_timeOutRate);

    csvinput = zeros(6,2);
    csvinput(1,:) = [mean(user2_successRate,1), std(user2_successRate,1,1) ];
    csvinput(2,:) = [mean(user3_successRate,1), std(user3_successRate,1,1) ];
    csvinput(3,:) = [mean(user2_rejectedRate,1), std(user2_rejectedRate,1,1) ];
    csvinput(4,:) = [mean(user3_rejectedRate,1), std(user3_rejectedRate,1,1) ];
    csvinput(5,:) = [mean(user2_timeOutRate,1), std(user2_timeOutRate,1,1) ];
    csvinput(6,:) = [mean(user3_timeOutRate,1), std(user3_timeOutRate,1,1) ];
    csvwrite(sprintf('RQ-Output\\RQ%d-S2-%s-errorBarData.csv',RQNo, tech),csvinput);

end

