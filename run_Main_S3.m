
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
 
%%%%%%%%%%%%%%%%%%%%%%%%  S3  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    user1(1:50) = 10; % dos attack 
    user2(1:50) = 10; % S3 insider attack 
    user3(1:50) = 10; % regular user     
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    disp(['Start run = ',num2str(r)]);
    init_m;
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
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    timeoutUser = zeros(500,1);
    index = 1;
    
    timeOut1 = 0;
    timeOut2 = 0;
    timeOut3 = 0;
    
    % number of total requests from user 1
        user1_totalEntities = Entities1(length(Entities1));
    % number of total requests from user2
        user2_totalEntities = Entities2(length(Entities2));
    % number of total requests from user3
        user3_totalEntities = Entities3(length(Entities3));
        
    reject1 = RejectedUser1(length(RejectedUser1));
    reject2 = RejectedUser2(length(RejectedUser2));
    reject3 = RejectedUser3(length(RejectedUser3));
    
    r1 = 100 * (reject1) / user1_totalEntities;
    r2 = 100 * (reject2) / user2_totalEntities;
    r3 = 100 * (reject3) / user3_totalEntities;
    
    user1_rejectedRate(r,1) = r1;
    user2_rejectedRate(r,1) = r2;
    user3_rejectedRate(r,1) = r3;
    
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
% This is for RQ#, S3 , case#
PlotS3(user1_successRate, user2_successRate, user3_successRate, ... 
    user1_rejectedRate, user2_rejectedRate, user3_rejectedRate, ... 
    user1_timeOutRate, user2_timeOutRate, user3_timeOutRate, 1, 'gt'); 
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
