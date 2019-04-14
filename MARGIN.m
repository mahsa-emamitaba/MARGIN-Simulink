function [ action ] = MARGIN(u)

% u(1) = Load1
% u(2) = Timeout1
% u(3) = Served1
% u(4) = AveQueue1
% u(5) = Queue Length
% u(6) = Ave Integration time for the user requests in Server 1
% u(7) = Service time for the users requests in server 1
% u(8) = End to end response Time for entities from user 1 and 2
% u(9) = user that is severd by the server
% u(10) = Integration time for User 1
% u(11) = Integration time for User 2
% u(12) = Integration time for User 3
% u(13) = queueWait



global served1;
global timeout1;
global total;

global countermeasures1;
global countermeasures2;

global GT1;                   % the GT table
global GT2;                   % the GT table
global GT3;                   % the GT table
global GT_global;
global GT_global1;
global GT_global2;
global GT_global3;

global V1;
global V2;
global V3;

global PI1;
global PI2;
global PI3;

global drop_percentageUser1;
global drop_percentageUser2;
global drop_percentageUser3;

global actionUser1;
global actionUser2;
global actionUser3;

global actionTimeUser1;
global actionTimeUser2;
global actionTimeUser3;

global time; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% in case of no adaptation all actions are = 3
global action1;
if isempty(action1)
    action1 = 3;
end
global action2;
if isempty(action2)
    action2 = 3;
end
global action3;
if isempty(action3)
    action3 = 3;
end

global previous_state1;
if isempty(previous_state1)
    previous_state1 = 1;
end
global previous_state2;
if isempty(previous_state2)
    previous_state2 = 1;
end
global previous_state3;
if isempty(previous_state3)
    previous_state3 = 1;
end

global previous_reward1;
if isempty(previous_reward1)
    previous_reward1 = 0;
end
global previous_reward2;
if isempty(previous_reward2)
    previous_reward2 = 0;
end
global previous_reward3;
if isempty(previous_reward3)
    previous_reward3 = 0;
end


% global filename;
% global p
% if isempty(p)
%     p = 0;
% end
% p = p+1;
% disp(num2str(p));

% calculate flow from the average integration time
ave_integration = u(6);
% if (u(6)~= 0)
%     flow_rate = 1/u(6);
% else
%     flow_rate =0;
% end

deltaServed = u(3) - served1;
deltaTimeout = u(2) - timeout1;
% if (deltaServed ~= 0)
queueLength = u(5);
% service time of the current request of the uer
serviceTime4User = u(7);
aveQueueWait = u(4);
current_load = u(1);
current_responsetime = u(8);
user = u(9);
integrationUser1 = u(10);
serviceTime1 = u(11);
scenario = u(12);
    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%% Markov Reward Calculation %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % State
%     state = findstate(load);
    
    s = zeros(3);
    if (current_load > 10) 
        s(1) = 1;
    end
    if (current_responsetime > 100) 
        s(2) = 1;
    end
    %%%%% state mapper
    state = s(1)*2^0+ s(2)*2^1+ 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % reward
%     rew = reward_function(deltaserved, deltatimeout, queuelength, ave_integration, servicetime4user, responsetime, queuewait);
    mttr = 1; 
    annoyance = 1;
    malicious_client = 1; 
    if (user == 1)
        if (action1 ~= 1)
            mttr = 0;
        end    
        % this part is only for s4 - from here 
        if (scenario == 4) % should be treated as an insider attack 
            if (action1 ~= 2)
                mttr = 1; 
                malicious_client = 0;
            end
        end     
        % this part is only for s4 - until here         
    elseif (user == 2)
         if (action2 ~= 2)
             malicious_client = 0;
         end
    elseif (user == 3)
         if (action3 ~= 3)
             annoyance = 0;
         end
    end 
    %%%%%%%%%%%%%%% utility of attributes 
    max_load = 500;
    max_rt = 10000;
    load = 1 - (current_load/max_load);
    responsetime = 1 - (current_responsetime/max_rt);

    goal_satisfaction =  (1/6*mttr) + (1/6*load) + (1/6*responsetime) + (1/6*annoyance) + (1/3*malicious_client);
%     goal_satisfaction =  (1/3*mttr) + (1/3*annoyance) + (1/3*malicious_client);
    cost = 0;
%     cost = 0.1;
    % reward of the current state 
     cost_action = 0;   
%     reward = goal_satisfaction - cost_action;

%     total = total + rew;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % write user data into a file
%     data = [user,deltaserved, deltatimeout, queuelength, ave_integration, servicetime4user, responsetime];
%     dlmwrite(filename,data,'-append',...  %# print the matrix
%     'delimiter',',','precision',8,...
%     'newline','pc');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% markov action selection %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     [sys_action] = markov(rew, state, opponent_action, previous_state, previous_action);
if (user == 1)
    if (action1== 1 || action1 ==2)
        cost_action = cost;
    end
    reward = goal_satisfaction - cost_action;
    rew = reward - previous_reward1;
    previous_reward1 = reward;
    o1 = 1;
    [defender_action_user1, previous_state1, GT1, V1, PI1] = defenderAction(rew,state,o1,action1,previous_state1, GT1, V1, PI1);
    action1 = defender_action_user1;
    actionUser1 = [actionUser1 action1];
    actionTimeUser1(1, time) = action1;
    time = time +1;
elseif (user == 2)
    if (action2== 1 || action2 ==2)
        cost_action = cost;
    end
    reward = goal_satisfaction - cost_action;
    rew = reward - previous_reward2;
    previous_reward2 = reward;
    o2 = 2;
    [defender_action_user2, previous_state2, GT2, V2, PI2] = defenderAction(rew,state,o2,action2,previous_state2,GT2, V2, PI2);
    action2 = defender_action_user2;
    actionUser2 = [actionUser2 action2];
    actionTimeUser2(1, time) = action2;
    time = time +1;
elseif (user == 3)
    if (action3 == 1 || action3 == 2)
        cost_action = cost;
    end
    reward = goal_satisfaction - cost_action;
    rew = reward - previous_reward3;
    previous_reward3 = reward;
    o3 = 3;
    [defender_action_user3, previous_state3, GT3, V3, PI3] = defenderAction(rew,state,o3,action3,previous_state3, GT3, V3, PI3);
    action3 = defender_action_user3;
    actionUser3 = [actionUser3 action3];
    actionTimeUser3(1, time) = action3;
    time = time +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
action = [action1 action2 action3];
% Store the previose values
timeout1 = u(2);
served1 =  u(3);

end

