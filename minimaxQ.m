function [action, prev_state, GT, V, PI]= minimaxQ(reward, state, opponent_action, previous_action, previous_state, GT, V, PI)

global epsilon;             % probability of a random action selection
global alpha;               % learning rate
global gamma;               % discount factor
global GT_sumfun;
global state_sumfun;

GT = sim_Update_GT(GT, previous_state, previous_action, opponent_action, reward, alpha, gamma, V(state));

% Update alpha using decay rate 0.97
%alpha = alpha * 0.99;

%linear programming to find pi[s,.]
GT_sumfun = GT; % pass GT to sumfun fucntion
state_sumfun = previous_state;

[PI(state,:), V(state)] = sim_minV(previous_state, V, PI);

prev_state = state;
action = next_action(GT,PI(state,:),epsilon);

end
    