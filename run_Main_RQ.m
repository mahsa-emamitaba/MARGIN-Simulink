% global rewards;
% global total;
% global algorithm;

% global user1_percentage;
% global user2_percentage;
% global user3_percentage;

% integrationtimes(1:25)=20;
% integrationtimes(26:86)=5;
% integrationtimes(87:92)=50;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global filename;
% filename = 'userdata.csv';
% fid2 = fopen(filename,'w');

% fName = strcat('GTSim_one_server_results.csv');
% fid = fopen(fName,'w');
% fprintf(fid,'%s\r\n','run,attacker%,attacker%,user%,user%,user%,total_reward');
% fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% technique = cell(runs,1);
% users = cell(runs*5,1);
% serviced_percentage = zeros(runs*3,1);
% user1_percentage = zeros(runs);
% user2_percentage = zeros(runs);
% user3_percentage = zeros(runs);
% x = zeros(runs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clearvars

actions1 = zeros(100, 90);
actions2 = zeros(100, 90);
actions3 = zeros(100, 90);

actionsTime1 = zeros(100, 200);
actionsTime2 = zeros(100, 200);
actionsTime3 = zeros(100, 200);

rewards = zeros(100, 90);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
runs = 100;
user1_successRate = zeros(runs,1);
user1_rejectedRate = zeros(runs,1);
user1_timeOutRate = zeros(runs,1);

user2_successRate = zeros(runs,1);
user2_rejectedRate = zeros(runs,1);
user2_timeOutRate = zeros(runs,1);

user3_successRate = zeros(runs,1);
user3_rejectedRate = zeros(runs,1);
user3_timeOutRate = zeros(runs,1);

total_rewards = zeros(runs,1);

for r=1:runs
    
    clearvars -global

global actionUser1;
global actionUser2;
global actionUser3;

global actionTimeUser1;
global actionTimeUser2;
global actionTimeUser3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    st1(1:50) = 51; % = 50 (50 action), = 30 (100 action)
    st2(1:50) = 52; 
    st3(1:50) = 50; 
    scenario1(1:50) = 0; 
    scenario2(1:50) = 0; 
    scenario3(1:50) = 0; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%  S1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Scenarios for user 1, DoS attacker
    user1(1:50) = 10; % S1  dos attack !!!
%%% Scenarios for user 2, Insider attacker
    user2(1:500) = 10000; % S1 no insider attack
%%% Scenarios for user 3, regular user 
    user3(1:50) = 10; % regular user     
%%%%%%%%%%%%%%%%%%%%%%%%  S2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%     user1(1:500) = 10000; % S2  no dos attack
%     user2(1:50) = 10; % S2  regular insider attack !!!
%     user3(1:50) = 10; % regular user     
%%%%%%%%%%%%%%%%%%%%%%%%  S3  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     user1(1:50) = 10; % dos attack !!!
%     user2(1:50) = 10; % S3 insider attack !!!
%     user3(1:50) = 10; % regular user     
%%%%%%%%%%%%%%%%%%%%%%%%  S4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      user1(1:15) = 10; % SS4 dos attack first!!!
%      user1(16:50) = 9; % SS4 insider attack second!!!     
%      scenario1(1:15) = 1; % SS4 dos attack first!!!
%      scenario1(16:50) = 4; % SS4 insider attack second!!!
% 
%     user2(1:500) = 10000; % S4 insider attack
%     user3(1:50) = 10; % regular user     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     
%%%%%%%%%%%%%%%%%%%%% old S4, S5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     user1(1:35) = 10; % S4 regular dos attack first  !!!
%     user1(36:50) = 100; % S4 regular dos attack first  !!!

%     user1(1:15) = 100; % S5 regular dos attack second!!!
%     user1(16:50) = 10; % S5 regular dos attack second!!!

%     user1(1:250) = 10; % SS4 regular dos attack first  !!!
%     user1(251:500) = 10000; % SS4 regular dos attack first  !!!
%     user1(1:10) = 250; % SS5 regular dos attack second!!!
%     user1(11:500) = 10; % SS5 regular dos attack second!!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% old S4, S5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     user2(1:15) = 100; % S4 regular insider attack second!!!
%     user2(16:50) = 10; % S4 regular insider attack second!!!

%     user2(1:35) = 10; % S5 regular insider attack first  !!!
%     user2(36:50) = 100; % S5 regular insider attack first  !!!

%     user2(1:10) = 250; % SS4 regular insider attack second!!!
%     user2(11:500) = 10; % SS4 regular insider attack second!!!
%     user2(1:250) = 10; % SS5 regular insider attack first  !!!
%     user2(251:500) = 10000; % SS5 regular insider attack first  !!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     user3(1:500) = 10; % regular user
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp(['Start run = ',num2str(r)]);
    init_m;
%     algorithm = 'GT';
    % no strategy change
%     sim('GTSim_one_server_m_ZeroST_attack', 1000);
    % strategy change , S#1
    
    %sim('GTSim_RQ', 5000);
    sim('GTSim_RQ', 5000);
    
    user_1 = 0;
    user_2 = 0;
    user_3 = 0;
    user1_total = 0;
    user2_total = 0;
    user3_total = 0;
    
    servedRequests = zeros(500,1);
    severdUser = zeros(500,1);
    serviceTime = zeros(500,1);
    serverLoad = zeros(500,1);
    serverRT = zeros(500,1);
        
    user1_load = zeros(500,1);
    user1_rt = zeros(500,1);
    user1_action = zeros(500,1);
    
    user2_load = zeros(500,1);
    user2_rt = zeros(500,1);
    user2_action = zeros(500,1);
    
    user3_load = zeros(500,1);
    user3_rt = zeros(500,1);
    user3_action = zeros(500,1);
    
%     action_User1 = actionUser1;
%     action_User2 = actionUser2;
%     action_User3 = actionUser3;
    
    index = 1;
    for i = 2:size(Served1,1)
        if (Served1(i)~=Served1(i-1))
            servedRequests(index) =  Served1(i);
            severdUser(index) = Server1Users(i);
            serviceTime(index) = Server1ServiceTime(i);
%             if (serviceTime(index) ~= 0)
%                 severdUser(index) = Server1Users(i);
%             end
            serverLoad(index) =  Load(i);
            serverRT(index) =  ResponseTime(i);
            index = index +1; 
        end
    end
    
%     user1_ind = 1;
%     user2_ind = 1;
%     user3_ind = 1;
%     for i = 1:size(severdUser,1)
%         if (severdUser(i) == 1)
%             if (serviceTime(i) ~= 0)
%                 user_1 = user_1 + 1;
%             end
% %             user1_total = user1_total + 1;
%             user1_rt(user1_ind) = serverRT(i);
%             user1_ind = user1_ind +1;
%             
%         elseif (severdUser(i) == 2)
%             if (serviceTime(i) ~= 0)
%                 user_2 = user_2 +1;
%             end
% %             user2_total = user2_total + 1;
%             user2_rt(user2_ind) = serverRT(i);
%             user2_ind = user2_ind +1;
%             
%         elseif (severdUser(i) == 3)
%             if (serviceTime(i) ~= 0)
%                 user_3 = user_3 +1;
%             end
% %             user3_total = user3_total + 1;
%             user3_rt(user3_ind) = serverRT(i);
%             user3_ind = user3_ind +1;
%             
%         end
%     end
%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    timeoutUser = zeros(500,1);
    index = 1;
    
    timeOut1 = 0;
    timeOut2 = 0;
    timeOut3 = 0;
%     for i = 2:size(Timeout,1)
%         if (Timeout(i)~=Timeout(i-1))
%             timeoutUser(index) = TimeoutUsers(i);
%             index = index +1; 
%         end
%     end
%     
%     for i = 1:size(timeoutUser,1)
%         if (timeoutUser(i) == 1)
%             timeOut1 = timeOut1 +1;
%             
%         elseif (timeoutUser(i) == 2)
%             timeOut2 = timeOut2 +1;
%             
%         elseif (timeoutUser(i) == 3)
%             timeOut3 = timeOut3 +1;
%             
%         end
%     end

%     user1_totalEntities = user1_total + timeOut1;
%     user2_totalEntities = user2_total + timeOut2;
%     user3_totalEntities = user3_total + timeOut3;
    
    % number of total requests from user 1
        user1_totalEntities = Entities1(length(Entities1));
    % number of total requests from user2
        user2_totalEntities = Entities2(length(Entities2));
    % number of total requests from user3
        user3_totalEntities = Entities3(length(Entities3));
        
    % Calculate the percentage of handeled requests for each user
%     u1 = 100*user_1/user1_total;
%     u2 = 100*user_2/user2_total;
%     u3 = 100*user_3/user3_total; 

%     user1_total = user_1;
%     user2_total = user_2;
%     user3_total = user_3;
% 
%     u1 = 100*user1_total/user1_totalEntities;
%     u2 = 100*user2_total/user2_totalEntities;
%     u3 = 100*user3_total/user3_totalEntities; 
%     
%     user1_successRate(r,1) = u1; 
%     user2_successRate(r,1) = u2; 
%     user3_successRate(r,1) = u3; 
%     
    % Calculate the percentage of rejected  requests for each user
%     r1 = 100 * (user1_total - user_1) / user1_totalEntities;
%     r2 = 100 * (user2_total - user_2) / user2_totalEntities;
%     r3 = 100 * (user3_total - user_3) / user3_totalEntities;

%     reject1 = BeforeUser1(length(BeforeUser1)) - AfterUser1(length(AfterUser1));
%     reject2 = BeforeUser2(length(BeforeUser2)) - AfterUser2(length(AfterUser2));
%     reject3 = BeforeUser3(length(BeforeUser3)) - AfterUser3(length(AfterUser3));
    
    reject1 = RejectedUser1(length(RejectedUser1));
    reject2 = RejectedUser2(length(RejectedUser2));
    reject3 = RejectedUser3(length(RejectedUser3));
    
    r1 = 100 * (reject1) / user1_totalEntities;
    r2 = 100 * (reject2) / user2_totalEntities;
    r3 = 100 * (reject3) / user3_totalEntities;
    
    user1_rejectedRate(r,1) = r1;
    user2_rejectedRate(r,1) = r2;
    user3_rejectedRate(r,1) = r3;
    
    % Calculate the percentage of timed out requests for each user
%     timeOut1 = user1_totalEntities - (user1_total + reject1);
%     timeOut2 = user2_totalEntities - (user2_total + reject2);
%     timeOut3 = user3_totalEntities - (user3_total + reject3);
    
    timeOut1 = TimeoutUsers1(length(TimeoutUsers1));
    timeOut2 = TimeoutUsers2(length(TimeoutUsers2));
    timeOut3 = TimeoutUsers3(length(TimeoutUsers3));

    t1 = 100*timeOut1/user1_totalEntities;
    t2 = 100*timeOut2/user2_totalEntities;
    t3 = 100*timeOut3/user3_totalEntities;
    
    user1_timeOutRate(r,1) = t1; 
    user2_timeOutRate(r,1) = t2; 
    user3_timeOutRate(r,1) = t3; 

    user1_total = user1_totalEntities - (reject1 + timeOut1);
    user2_total = user2_totalEntities - (reject2 + timeOut2);
    user3_total = user3_totalEntities - (reject3 + timeOut3);

    u1 = 100*user1_total/user1_totalEntities;
    u2 = 100*user2_total/user2_totalEntities;
    u3 = 100*user3_total/user3_totalEntities; 
    
    user1_successRate(r,1) = u1; 
    user2_successRate(r,1) = u2; 
    user3_successRate(r,1) = u3; 
    
    
    disp(['user_1 = ',num2str(user1_total), ' , ', num2str(reject1), ' , ',num2str(timeOut1),' = ',num2str(user1_totalEntities)]);
    disp(['user_2 = ',num2str(user2_total), ' , ', num2str(reject2), ' , ',num2str(timeOut2),' = ',num2str(user2_totalEntities)]);
    disp(['user_3 = ',num2str(user3_total), ' , ', num2str(reject3), ' , ',num2str(timeOut3),' = ',num2str(user3_totalEntities)]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     disp(['user_1% = ',num2str(user1_total)]);
    %     disp(['user_2% = ',num2str(user2_total)]);
    %     disp(['user_1% = ',num2str(100*user_1/user1_total)]);
    %     disp(['user_2% = ',num2str(100*user_2/user2_total)]);
      
%     ind = r;
%     ind = round(ind);
%     total_rewards(ind) = total;
%     serviced_percentage(ind*5-4) = u1;
%     serviced_percentage(ind*5-3) = u2;
%     serviced_percentage(ind*5-2) = u3;
%     users(ind*5-4) = {'u1'};
%     users(ind*5-3) = {'u2'};
%     users(ind*5-2) = {'u3'};
%     users(ind*5-1) = {'u4'};
%     users(ind*5) = {'u5'};
    
%     user1_percentage(ind) = u1; 
%     user2_percentage(ind) = u2;
%     user3_percentage(ind) = u3;
%     x(ind) = ind;
    
%     technique(ind) = {algorithm};
%     dlmwrite(fName,[ind, u1, u2,u3, u4, u5, total],'-append',...  %# Print the matrix
%         'delimiter',',','precision',8,...
%         'newline','pc');

    actions1(r,1:length(actionUser1)) = actionUser1(:);
    actions2(r,1:length(actionUser2)) = actionUser2(:);
    actions3(r,1:length(actionUser3)) = actionUser3(:);
    
    actionsTime1(r,1:length(actionTimeUser1)) = actionTimeUser1(:);  
    actionsTime2(r,1:length(actionTimeUser2)) = actionTimeUser2(:);
    actionsTime3(r,1:length(actionTimeUser3)) = actionTimeUser3(:);
end
 
disp(['user_1 = ',num2str(mean(user1_successRate)), '(',num2str(std(user1_successRate)), ')', ' , ', ...
    num2str(mean(user1_rejectedRate)), '(',num2str(std(user1_rejectedRate)), ')',' , ', ...
    num2str(mean(user1_timeOutRate)),'(',num2str(std(user1_timeOutRate)), ')']);

disp(['user_2 = ',num2str(mean(user2_successRate)), '(',num2str(std(user2_successRate)), ')',  ' , ', ...
    num2str(mean(user2_rejectedRate)),  '(',num2str(std(user2_rejectedRate)), ')', ' , ',...
    num2str(mean(user2_timeOutRate)), '(',num2str(std(user2_timeOutRate)), ')']);

disp(['user_3 = ',num2str(mean(user3_successRate)), '(',num2str(std(user3_successRate)), ')', ' , ', ...
    num2str(mean(user3_rejectedRate)),  '(',num2str(std(user3_rejectedRate)), ')', ' , ',...
    num2str(mean(user3_timeOutRate)), '(',num2str(std(user3_timeOutRate)), ')',]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for RQ#, S1 , case#
PlotS1(user1_successRate, user3_successRate, user1_rejectedRate, ... 
    user3_rejectedRate,user1_timeOutRate, user3_timeOutRate, 1, 'gt'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for RQ#, S2 , case#
% PlotS2(user2_successRate, user3_successRate, user2_rejectedRate, ... 
%     user3_rejectedRate,user2_timeOutRate, user3_timeOutRate, 1, 'gt'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for RQ#, S3 , case#
% PlotS3(user1_successRate, user2_successRate, user3_successRate, ... 
%     user1_rejectedRate, user2_rejectedRate, user3_rejectedRate, ... 
%     user1_timeOutRate, user2_timeOutRate, user3_timeOutRate, 1, 'gt'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is for RQ#, S4 , case#
% PlotS4(user1_successRate, user3_successRate, user1_rejectedRate, ... 
%     user3_rejectedRate,user1_timeOutRate, user3_timeOutRate, 1, 'gt'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:50
    u1_perc_1(j) = sum(actions1(1:100,j) == 1);
    u1_perc_2(j) = sum(actions1(1:100,j) == 2);
    u1_perc_3(j) = sum(actions1(1:100,j) == 3);
end
figure;
plot(1:50,u1_perc_1,'-o',1:50,u1_perc_2,'-x',1:50, u1_perc_3,'-+');
legend('Issue Puzzle','Drop','No Defense');
xlabel('Episode');
ylabel('Selected Action Percentage For DoS Attacker');

for j=1:50
    u2_perc_1(j) = sum(actions2(1:100,j) == 1);
    u2_perc_2(j) = sum(actions2(1:100,j) == 2);
    u2_perc_3(j) = sum(actions2(1:100,j) == 3);
end
figure;
plot(1:50,u2_perc_1,'-o',1:50,u2_perc_2,'-x',1:50, u2_perc_3,'-+');
legend('Issue Puzzle','Drop','No Defense');
xlabel('Episode');
ylabel('Selected Action 2 Percentage For Insider Attacker');

for j=1:50
    u3_perc_1(j) = sum(actions3(1:100,j) == 1);
    u3_perc_2(j) = sum(actions3(1:100,j) == 2);
    u3_perc_3(j) = sum(actions3(1:100,j) == 3);
end
figure;
plot(1:50,u3_perc_1,'-o',1:50,u3_perc_2,'-x',1:50, u3_perc_3,'-+');
legend('Issue Puzzle','Drop','No Defense');
xlabel('Episode');
ylabel('Selected Action Percentage For Regular User');   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% plot(user1_rt,'Color','k');hold on;
% plot(user2_rt,'Color','b');
% plot(user3_rt,'Color','g');
% title('Response Time Per User');
% hold off;
% 
% figure;
% plot(user1_action,'Color','k');hold on;
% plot(user2_action,'Color','b');
% plot(user3_action,'Color','g');
% axis([0,500,-1,4]);
% title('Action Per User');
% hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure;
% plot(action_User1);
% title('actionUser1');
% 
% figure;
% plot(action_User2);
% title('actionUser2');
% figure;
% plot(action_User3);
% title('actionUser3');

% average = mean(total_rewards);
% standv = std(total_rewards);
% miin = min(total_rewards);
% maax = max(total_rewards);

% figure;
% boxplot(total_rewards, technique);
% title('Total Rewards');

% dlmwrite(fName,['A', 'S', 'm', 'M'],'-append',...  %# Print the matrix
%     'delimiter',',','precision',8,...
%     'newline','pc');
% 
% dlmwrite(fName,[average, standv, miin, maax],'-append',...  %# Print the matrix
%     'delimiter',',','precision',8,...
%     'newline','pc');

%Plot

% % subplot(2,2,1)
% 
% figure;
% plot(serverLoad(1:200));
% title('Load');

% figure;
% plot(serverRT(1:200));
% title('Response Time');

% subplot(2,3,2)
% plot(Timeout1);
% title('Timeout for Server 1');

% figure;
% % subplot(2,2,2)
% plot(AveQueue1);
% title('Average Queue wait');

%Plot
% figure;
% % subplot(2,2,3)
% plot(QueueLength);
% title('Queue Length');

%Plot
% figure;
% % subplot(2,3,4);
% plot(QueueRT);
% title('Queue Wait');


% figure;
% % subplot(2,3,4)
% plot(rewards);
% title('Rewards');

% subplot(2,3,5)
% plot(1./IntegrationUser1);
% title('Flow rate for User 1 (Attacker action)');

% subplot(2,3,5)
% plot(countermeasures1);
% title('Drop Rate for User 1');

% subplot(2,3,6)
% plot(countermeasures2);
% title('Drop Rate for User 2');

% figure;
% boxplot(serviced_percentage, users);
% title('Serviced Percentage');

% figure;
% plot(user1_percentage,'Color','k');hold on;
% plot(user2_percentage,'Color','r');
% plot(user3_percentage,'Color','y');
% plot(user4_percentage,'Color','b');
% plot(user5_percentage,'Color','g');
% hold off;
% plot(x, user1_percentage,'k',x, user2_percentage,'red',x, user3_percentage,'green',x, user4_percentage,'blue',x, user5_percentage,'m');
% legend('u1','u2','u3','u4','u5');

% figure;
% plot(drop_percentageUser1,'Color','k');
% figure;
% plot(drop_percentageUser2,'Color','r');
% figure;
% plot(drop_percentageUser3,'Color','y');
% figure;
% plot(drop_percentageUser4,'Color','b');
% figure;
% plot(drop_percentageUser5,'Color','g');

% save GTTable1 GT1;
% save GTTable2 GT2;
% save GTTable3 GT3;
% save GTTable4 GT4;
% save GTTable5 GT5;
% save VTable V;
% save PITable PI;



