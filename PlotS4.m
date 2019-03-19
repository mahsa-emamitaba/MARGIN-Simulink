function [ ] = PlotS4(user1_successRate, user3_successRate, user1_rejectedRate, ... 
    user3_rejectedRate,user1_timeOutRate, user3_timeOutRate, RQNo, tech)
    
    group1 = [repmat({'1: Mix'}, length(user1_successRate), 1); ... 
    repmat({'2: Regular'}, length(user3_successRate), 1); ....
    repmat({'3: Mix'}, length(user1_rejectedRate), 1); ....
    repmat({'4: Regular'}, length(user3_rejectedRate), 1); ....
    repmat({'5: Mix'}, length(user1_timeOutRate), 1); ....
    repmat({'6: Regular'}, length(user3_timeOutRate), 1)]; 

    group2 = [repmat({'Attacker'}, length(user1_successRate), 1); ... 
    repmat({'User'}, length(user3_successRate), 1); ....
    repmat({'Attacker'}, length(user1_rejectedRate), 1); ....
    repmat({'User'}, length(user3_rejectedRate), 1); ....
    repmat({'Attacker'}, length(user1_timeOutRate), 1); ....
    repmat({'User'}, length(user3_timeOutRate), 1)]; 
    % 
    group3 = [repmat({'Success'}, length(user1_successRate), 1); ... 
    repmat({'Success'}, length(user3_successRate), 1); ....
    repmat({'Reject'}, length(user1_rejectedRate), 1); ....
    repmat({'Reject'}, length(user3_rejectedRate), 1); ....
    repmat({'Timeout'}, length(user1_timeOutRate), 1); ....
    repmat({'Timeout'}, length(user3_timeOutRate), 1)]; 

    h = figure('visible', 'on'); 
    % font size of the x axes text 
    set(h, 'DefaultTextFontSize', 9);
    set(h, 'DefaultTextFontWeight', 'bold');
    set(h, 'Position', [10, 10, 600, 250]);
    h1 = boxplot([user1_successRate,user3_successRate, user1_rejectedRate,user3_rejectedRate, user1_timeOutRate,user3_timeOutRate],...
           {group1 group2 group3} );
    ylim([0 110])
    % thickness of boxes
    for ih=1:6
    set(h1(ih,:),'LineWidth',2);
    end
    % font size of the y axes
    set(gca,'FontSize',9);
    set(gca,'FontWeight','bold'); 
    set(gca, 'Position', get(gca, 'OuterPosition') - ...
         get(gca, 'TightInset') * [-1 0 1 0; 0 -11 0 12; 0 0 2 0; 0 0 0 1])

    % need to save these points for pgfplot in latex  
    csvinput = zeros(6,6);
    for ih = 1:6
        csvinput(ih,:) = [get(h1(2,ih),'YData'), get(h1(6,ih),'YData'), get(h1(1,ih),'YData') ];
    end 

    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-boxplotData.csv',RQNo, tech),csvinput);
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-%d.csv',RQNo, tech, 1),user1_successRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-%d.csv',RQNo, tech, 2),user3_successRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-%d.csv',RQNo, tech, 3),user1_rejectedRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-%d.csv',RQNo, tech, 4),user3_rejectedRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-%d.csv',RQNo, tech, 5),user1_timeOutRate);
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-%d.csv',RQNo, tech, 6),user3_timeOutRate);

    csvinput = zeros(6,2);
    csvinput(1,:) = [mean(user1_successRate,1), std(user1_successRate,1,1) ];
    csvinput(2,:) = [mean(user3_successRate,1), std(user3_successRate,1,1) ];
    csvinput(3,:) = [mean(user1_rejectedRate,1), std(user1_rejectedRate,1,1) ];
    csvinput(4,:) = [mean(user3_rejectedRate,1), std(user3_rejectedRate,1,1) ];
    csvinput(5,:) = [mean(user1_timeOutRate,1), std(user1_timeOutRate,1,1) ];
    csvinput(6,:) = [mean(user3_timeOutRate,1), std(user3_timeOutRate,1,1) ];
    csvwrite(sprintf('RQ-Output\\RQ%d-S4-%s-errorBarData.csv',RQNo, tech),csvinput);
    
end

