for j=1:70
    u1_perc_1(j) = sum(actions1(1:100,j) == 1);
    u1_perc_2(j) = sum(actions1(1:100,j) == 2);
    u1_perc_3(j) = sum(actions1(1:100,j) == 3);
end
figure;
plot(1:70,u1_perc_1,'-o',1:70,u1_perc_2,'-x',1:70, u1_perc_3,'-+');
legend('Issue Puzzle','Drop','No Defense');
xlabel('Episode');
ylabel('Selected Action Percentage For DoS Attacker');


% PlotS4(user1_successRate, user3_successRate, user1_rejectedRate, ... 
%     user3_rejectedRate,user1_timeOutRate, user3_timeOutRate, 1, 'a'); 