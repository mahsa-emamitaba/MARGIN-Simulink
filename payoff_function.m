function [ rew ] = payoff_function( deltaServed, deltaTimeout, ave_integration, serviceTime4User , responseTime)
%REWARD_FUNCTION Summary of this function goes here
%   Detailed explanation goes here

global rewards;

% Server info:
% deltaServed
% deltaTimeout

% User info 
% average from the beginning: flow_rate
% current info: serviceTime4User
% end to end response time 

% Reward with service time
% r = ( deltaServed - deltaTimeout )* u(5) ;


% Reward function
if (ave_integration == 0)
    rew = 0;
elseif (ave_integration > 40) % regular user
        % reward fucntion includes the service time of the request
%     rew = ((deltaServed - deltaTimeout)/flow_rate);
%     rew = (((deltaServed - deltaTimeout)*serviceTime4User))* ave_integration;
    rew = ((deltaServed - deltaTimeout)/flow_rate)* serviceTime4User - responseTime;
   
else % suspicious user 
%       rew = ((-deltaServed)* ave_integration);
%     rew = ((deltaServed - deltaTimeout)/flow_rate) - responseTime;
end

rewards = [rewards rew]; 

end

