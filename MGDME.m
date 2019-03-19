function [ action ] = MGDME(u)

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
    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%% Markov Reward Calculation %%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % State
% %     state = findState(load);
%     
%     s = zeros(3);
%     if (current_load > 10) 
%         s(1) = 1;
%     end
%     if (current_responsetime > 100) 
%         s(2) = 1;
%     end
%     %%%%% state mapper
%     state = s(1)*2^0+ s(2)*2^1+ 1;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Reward
% %     rew = reward_function(deltaServed, deltaTimeout, queueLength, ave_integration, serviceTime4User, responseTime, queueWait);
%     mttr = 1; 
%     annoyance = 1;
%     malicious_client = 1; 
%     if (user == 1)
%         if (action1 ~= 1)
%             mttr = 0;
%         end    
%         % this part is only for S4 - from here 
%         if (scenario == 4) % should be treated as an insider attack 
%             if (action1 ~= 2)
%                 mttr = 1; 
%                 malicious_client = 0;
%             end
%         end     
%         % this part is only for S4 - until here         
%     elseif (user == 2)
%          if (action2 ~= 2)
%              malicious_client = 0;
%          end
%     elseif (user == 3)
%          if (action3 ~= 3)
%              annoyance = 0;
%          end
%     end 
%     %%%%%%%%%%%%%%% Utility of attributes 
%     MAX_LOAD = 500;
%     MAX_RT = 10000;
%     load = 1 - (current_load/MAX_LOAD);
%     responsetime = 1 - (current_responsetime/MAX_RT);
% 
%     goal_satisfaction =  (1/6*mttr) + (1/6*load) + (1/6*responsetime) + (1/6*annoyance) + (1/3*malicious_client);
% %     goal_satisfaction =  (1/3*mttr) + (1/3*annoyance) + (1/3*malicious_client);
%     cost = 0;
% %     cost = 0.1;
%     % reward of the current state 
%      cost_action = 0;   
% %     reward = goal_satisfaction - cost_action;
% 
% %     total = total + rew;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % write user data into a file
% %     data = [user,deltaServed, deltaTimeout, queueLength, ave_integration, serviceTime4User, responseTime];
% %     dlmwrite(filename,data,'-append',...  %# Print the matrix
% %     'delimiter',',','precision',8,...
% %     'newline','pc');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%% Markov action selection %%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%     [sys_action] = markov(rew, state, opponent_action, previous_state, previous_action);
% if (user == 1)
%     if (action1== 1 || action1 ==2)
%         cost_action = cost;
%     end
%     reward = goal_satisfaction - cost_action;
%     rew = reward - previous_reward1;
%     previous_reward1 = reward;
%     o1 = 1;
%     [defender_action_user1, previous_state1, GT1, V1, PI1] = defenderAction(rew,state,o1,action1,previous_state1, GT1, V1, PI1);
%     action1 = defender_action_user1;
%     actionUser1 = [actionUser1 action1];
%     actionTimeUser1(1, time) = action1;
%     time = time +1;
% elseif (user == 2)
%     if (action2== 1 || action2 ==2)
%         cost_action = cost;
%     end
%     reward = goal_satisfaction - cost_action;
%     rew = reward - previous_reward2;
%     previous_reward2 = reward;
%     o2 = 2;
%     [defender_action_user2, previous_state2, GT2, V2, PI2] = defenderAction(rew,state,o2,action2,previous_state2,GT2, V2, PI2);
%     action2 = defender_action_user2;
%     actionUser2 = [actionUser2 action2];
%     actionTimeUser2(1, time) = action2;
%     time = time +1;
% elseif (user == 3)
%     if (action3 == 1 || action3 == 2)
%         cost_action = cost;
%     end
%     reward = goal_satisfaction - cost_action;
%     rew = reward - previous_reward3;
%     previous_reward3 = reward;
%     o3 = 3;
%     [defender_action_user3, previous_state3, GT3, V3, PI3] = defenderAction(rew,state,o3,action3,previous_state3, GT3, V3, PI3);
%     action3 = defender_action_user3;
%     actionUser3 = [actionUser3 action3];
%     actionTimeUser3(1, time) = action3;
%     time = time +1;
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% No Defense %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% action1 = 3; 
% action2 = 3; 
% action3 = 3; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Game Payoffs (No learning) %%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%% One user category %%%%%%%%%%%%%%%%%%%%%% 
% % Select an action by solving the game table and then update the payoffs
% % based on both players actions
% %M = [ 8 2 4 ; 4 5 6 ; 1 7 3 ];
% %M = [ 5 7 4 ; 2 3 6 ; 10 9 8 ];
% M = GT_global;
% [v,A,B,Mat]=GTantagonisticgames(M , 1);
% disp(Mat);
% % disp(A);
% %Find cumulative distribution
% c = cumsum(A);
%  disp(c);
% %Draw point at random according to probability density
% draw = rand();
% %disp(['draw = ',  num2str(draw)]);
% action1 = find(c >= draw == 1 , 1); % finds the proper action 
% actionUser1 = [actionUser1 action1];
% actionTimeUser1(1, time) = action1;
% time = time +1;
% disp(['Action = ', num2str(action1)]);
% % same action will be applied to all the users here
% action2 = action1;
% action3 = action1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  State %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    s = zeros(3);
    if (current_load > 10) 
        s(1) = 1;
    end
    if (current_responsetime > 100) 
        s(2) = 1;
    end
    %%%%% state mapping 
    state = s(1)*2^0+ s(2)*2^1+ 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%% Three user category %%%%%%%%%%%%%%%%%%%%%% 
disp(['User = ',num2str(user)]);
if (user == 1)
    M = GT_global1(:, :, state);
    [v,A,B,Mat]=GTantagonisticgames(M , 1);
    disp('Mat = ');
    disp(Mat);
    disp('GT_global1 = ');
    disp(GT_global1(:, :, state));
    %disp(A);
    %Find cumulative distribution
%     c = cumsum(A);
     c = [cumsum(A) 1];
    disp(c);
    %Draw point at random according to probability density
    draw = rand();
    disp(['draw = ',  num2str(draw)]);
    action1 = find(c >= draw==1, 1); % finds the proper action
    if (action1 == 4) 
        action1 = 3; % for cases when random was higher than 0.9990
    end
    disp(['Action1 = ', num2str(action1)]);
    actionUser1 = [actionUser1 action1];
    actionTimeUser1(1, time) = action1;
    time = time +1;
%     disp(['Action1 = ', num2str(action1)]);
    % same action will be applied to all the users here
elseif (user == 2)
    M = GT_global2(:, :, state);
    [v,A,B,Mat]=GTantagonisticgames(M , 1);
    disp('Mat = ');
    disp(Mat);
    disp('GT_global2 = ');
    disp(GT_global2(:, :, state));
    %disp(A);
    %Find cumulative distribution
    c = [cumsum(A) 1];
    disp(c);
    %Draw point at random according to probability density
    draw = rand();
    disp(['draw = ',  num2str(draw)]);
    action2 = find(c >= draw==1, 1); % finds the proper action
     if (action2 == 4) 
        action2 = 3; % for cases when random was higher than 0.9990
    end
    actionUser2 = [actionUser2 action2];
    actionTimeUser2(1, time) = action2;
    time = time +1;
    disp(['Action2 = ', num2str(action2)]);
    % same action will be applied to all the users here
elseif (user == 3)
    M = GT_global3(:, :, state);
    [v,A,B,Mat]=GTantagonisticgames(M , 1);
    disp('Mat = ');
    disp(Mat);
    disp('GT_global3 = ');
    disp(GT_global3(:, :, state));
    %disp(A);
    %Find cumulative distribution
    c = [cumsum(A) 1];
    disp(c);
    %Draw point at random according to probability density
    draw = rand();
    disp(['draw = ',  num2str(draw)]);
    action3 = find(c >= draw==1, 1); % finds the proper action
    if (action3 == 4) 
        action3 = 3; % for cases when random was higher than 0.9990
    end
    actionUser3 = [actionUser3 action3];
    actionTimeUser3(1, time) = action3;
    time = time +1;
    disp(['Action3 = ', num2str(action3)]);
    % same action will be applied to all the users here
end

%%%%%%%%%%%%%%%  Update game payoffs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Update game payoffs');

MAX_LOAD = 500;
MAX_RT = 10000;
load = 1 - (current_load/MAX_LOAD);
responsetime = 1 - (current_responsetime/MAX_RT);
cost_action = 0;
cost = 0;
%cost = 0.1;    
if (action1== 1 || action1 ==2)
    cost_action = cost;
end
% update the payoffs now
sys_action = action1;
user_action = 3; %default is regular user which is no attack 
% update attributes 
mttr = 1;
malicious_client = 1;
annoyance = 1;

if (user == 1)
    user_action = 1;
    if (sys_action == 1)
        mttr = 1;
        malicious_client = 1;
        annoyance = 1;
        
        % this part is only for S4 - from here
        if (scenario == 4) % should be treated as an insider attack
            mttr = 1;
            malicious_client = 0;
            annoyance = 1;
        end % this part is only for S4 - until here
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global1(sys_action, user_action, state) = reward;
        
    elseif (sys_action == 2)
        mttr = 0;
        malicious_client = 1;
        annoyance = 1;
        
        % this part is only for S4 - from here
        if (scenario == 4) % should be treated as an insider attack
            mttr = 1;
            malicious_client = 1;
            annoyance = 1;
        end % this part is only for S4 - until here
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global1(sys_action, user_action, state) = reward;
        
    elseif (sys_action == 3)
        mttr = 0;
        malicious_client = 1;
        annoyance = 1;
        
        % this part is only for S4 - from here
        if (scenario == 4) % should be treated as an insider attack
            mttr = 1;
            malicious_client = 0;
            annoyance = 1;
        end % this part is only for S4 - until here
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global1(sys_action, user_action, state) = reward;
        
    end
elseif (user == 2)
    user_action = 2;
    if (sys_action == 1)
        mttr = 1;
        malicious_client = 0;
        annoyance = 1;
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global2(sys_action, user_action, state) = reward;
        
    elseif (sys_action == 2)
        mttr = 1;
        malicious_client = 1;
        annoyance = 1;
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global2(sys_action, user_action, state) = reward;
        
    elseif (sys_action == 3)
        mttr = 1;
        malicious_client = 0;
        annoyance = 1;
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global2(sys_action, user_action, state) = reward;
        
    end
    
elseif (user == 3)
    user_action = 3;
    if (sys_action == 1)
        mttr = 1;
        malicious_client = 1;
        annoyance = 0;
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global3(sys_action, user_action, state) = reward;
        
    elseif (sys_action == 2)
        mttr = 1;
        malicious_client = 1;
        annoyance = 0;
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global3(sys_action, user_action, state) = reward;
        
    elseif (sys_action == 3)
        mttr = 1;
        malicious_client = 1;
        annoyance = 1;
        
        goal_satisfaction = (1/6*load) + (1/6*responsetime) + (1/6*mttr) + (1/6*annoyance) + (1/3*malicious_client);
        reward = goal_satisfaction - cost_action;
        GT_global3(sys_action, user_action, state) = reward;
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Random Action %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sys_action_num = 3;
% action1 = ceil(sys_action_num.*rand(1,1));
% action2 = ceil(sys_action_num.*rand(1,1));
% action3 = ceil(sys_action_num.*rand(1,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Fixed Puzzle Action %%%%%%%%%%%%%%%%%%
% action1 = 1; 
% action2 = 1; 
% action3 = 1; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
action = [action1 action2 action3];
% Store the previose values
timeout1 = u(2);
served1 =  u(3);

% [new_action1, drop_percentage1] = actionAgainstUser(action1);
% [new_action2, drop_percentage2] = actionAgainstUser(action2);
% [new_action3, drop_percentage3] = actionAgainstUser(action3);
% 
% drop_percentageUser1 = [drop_percentageUser1 drop_percentage1]; 
% drop_percentageUser2 = [drop_percentageUser2 drop_percentage2]; 
% drop_percentageUser3 = [drop_percentageUser3 drop_percentage3];  
% 
% % Systems' action
% action = [new_action1 new_action2 new_action3 new_action4 new_action5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Keep track of countermeasures to polot them later on
% countermeasures1 = [countermeasures1 drop_percentage1];
% countermeasures2 = [countermeasures2 drop_percentage2];

end

