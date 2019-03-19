function [ action, prev_state , GT, V, PI] = defenderAction( reward, state, opponentAction, systemAction, previous_state, GT , V, PI)

% global algorithm;
% number of defender's actions
% n = size(GT,1);
% 
% if strcmp(algorithm, 'GT')
%     % Minimax-Q for choosing percentage based on flow rate
%     [action, prev_state, GT, V, PI] = sim_GT(reward,state,opponentAction, systemAction, previous_state,GT, V, PI);
% elseif strcmp(algorithm, 'RL')
%     % SARSA for choosing percentage based on flow rate
%     [action, prev_state, GT] = RL(reward,state,opponentAction, systemAction, previous_state, GT);
% elseif strcmp(algorithm, 'Rnd')
%     action = ceil(n.*rand(1,1));
%     prev_state = 1;
% else disp('Algorithm specified should be GT or RL or Rnd');
%     
% end


%%%%%%%%%%%%%%% Minimax-Q 
[action, prev_state, GT, V, PI] = minimaxQ(reward, state, opponentAction, systemAction, previous_state, GT, V, PI);



end

