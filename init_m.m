function  init_m()

global no_states;
global no_defender_actions;
global no_attacker_actions;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global alpha;               % learning rate
global gamma;               % discount factor
global epsilon;             % probability of a random action selection

if isempty(alpha) 
    alpha = 0.5;
end

if isempty(gamma) 
    gamma = 0.5;
end

if isempty(epsilon) 
    epsilon = 0.1;
end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global state_sumfun;
global GT_sumfun;

% global Q;
% global GT;                   % the GT table
% global V;
% global PI;

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

% global state;
% global previous_state;
% global previouse_action;
% global opponent_action;

% global MAX_LOAD;
% global MAX_RT;
% global MAX_USABILITY;

% global current_load;
% global current_responsetime;
% global current_usability;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAX_LOAD = 10;
% MAX_RT = 10;
% MAX_USABILITY = 10;

% if isempty(current_load)
%    current_load = 5;
% end
% 
% if isempty(current_responsetime)
%    current_responsetime = 5;
% end
% 
% if isempty(current_usability)
%    current_usability = 5;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global rew;
% rew = 0;
% global r;
% r = 0;
% global rewards;
% rewards = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(no_states) 
    no_states = 8;
end

% if isempty(state)
%     state = 0;
% end

if isempty(no_defender_actions) 
    no_defender_actions = 3;
end

if isempty(no_attacker_actions) 
    no_attacker_actions = 3;
end

% if isempty(previous_state)
%     previous_state = 1;
% end
% 
% if isempty(previouse_action)
%     previouse_action = 3;
% end
% 
% if isempty(opponent_action)
%     opponent_action = 3;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(GT1) 
    GT1 = sim_BuildGTTable(no_defender_actions, no_attacker_actions, no_states);
end

if isempty(GT2) 
    GT2 = sim_BuildGTTable(no_defender_actions, no_attacker_actions, no_states);
end

if isempty(GT3) 
    GT3 = sim_BuildGTTable(no_defender_actions, no_attacker_actions, no_states);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(GT_global) 
%     GT_global = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];    
    GT_global = zeros(3,3,no_states);
    for i = 1 : no_states 
        GT_global (: , : , i ) = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
    end
%     disp(GT_global);
end

% if isempty(GT_global1) 
%     GT_global1 = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
% end
% if isempty(GT_global2) 
%     GT_global2 = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
% end
% if isempty(GT_global3) 
%     GT_global3 = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
% end

if isempty(GT_global1) 
%     GT_global1 = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];    
    GT_global1 = zeros(3,3,no_states);
    for i = 1 : no_states 
        GT_global1 (: , : , i ) = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
    end
end
if isempty(GT_global2) 
%     GT_global2 = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];    
    GT_global2 = zeros(3,3,no_states);
    for i = 1 : no_states 
        GT_global2 (: , : , i ) = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
    end
end
if isempty(GT_global3) 
%     GT_global3 = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];    
    GT_global3 = zeros(3,3,no_states);
    for i = 1 : no_states 
        GT_global3 (: , : , i ) = [1 0.5 0.5 ; 0.5 1 0.5 ; 0.5 0.5 1 ];
    end
   % disp(GT_global3);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(GT_sumfun) 
    GT_sumfun = sim_BuildGTTable(no_defender_actions, no_attacker_actions, no_states);
end

if isempty(state_sumfun) 
    state_sumfun = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(V1)
   V1 = sim_BuildVTable(no_states); 
end
if isempty(V2)
   V2 = sim_BuildVTable(no_states); 
end
if isempty(V3)
   V3 = sim_BuildVTable(no_states); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(PI1)
    PI1 = sim_BuildPITable(no_states, no_defender_actions);
end 
if isempty(PI2)
    PI2 = sim_BuildPITable(no_states, no_defender_actions);
end
if isempty(PI3)
    PI3 = sim_BuildPITable(no_states, no_defender_actions);
end 

% if isempty(Q) 
%     Q = BuildQTable(no_states, no_defender_actions);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global actionUser1;
global actionUser2;
global actionUser3;

if isempty(actionUser1)
    actionUser1 = 0;
end    

if isempty(actionUser2)
    actionUser2 = 0;
end    

if isempty(actionUser3)
    actionUser3 = 0;
end    

global time; 
if isempty(time)
    time = 1;
end    

global actionTimeUser1;
if isempty(actionTimeUser1)
    actionTimeUser1 = zeros(1, 700);
end

global actionTimeUser2;
if isempty(actionTimeUser2)
    actionTimeUser2 = zeros(1, 700);
end


global actionTimeUser3;
if isempty(actionTimeUser3)
    actionTimeUser3 = zeros(1, 700);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Initialization Completed');








