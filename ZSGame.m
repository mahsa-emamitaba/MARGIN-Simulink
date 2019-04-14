function [ action ] = ZSGame(u)

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
global GT_global1;
global GT_global2;
global GT_global3;

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

current_load = u(1);
current_responsetime = u(8);
user = u(9);
scenario = u(12);
    
%%%%%%%%%%% Game Payoffs (No learning) %%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
action = [action1 action2 action3];
% Store the previose values
timeout1 = u(2);
served1 =  u(3);


end

