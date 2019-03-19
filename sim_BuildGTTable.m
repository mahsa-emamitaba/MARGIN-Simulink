function [ GT ] = sim_BuildGTTable( defender_actions, attacker_actions, nstates)

% GT = repmat(100000, [defender_actions attacker_actions nstates]);
GT = zeros(defender_actions, attacker_actions, nstates);
%disp (GT);
end