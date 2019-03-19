function [ PI ] = sim_BuildPITable(nstates, defender_actions)

PI = zeros(nstates, defender_actions);
PI(:,:) = 1/defender_actions;



