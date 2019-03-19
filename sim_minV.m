function [argmax, maxValue] = sim_minV(s, V, PI)

global no_defender_actions;

% PI(s,:) = 1/defender_actions;
%PI(s,:) = [1,0,0];
x0 = PI(s,:);

Aeq = ones(1,no_defender_actions);
beq = 1;
lb = zeros(no_defender_actions,1);
    
% i = 0; 
[x,fval, maxfval] = fminimax(@maxPIfun,x0,[],[],Aeq,beq,lb);

PI(s,:) = x;

% V(s) = min(fval);
% V(s) = min(-fval);
V(s) = -maxfval;

%%%%%%%%%%%%%%%%%%%%

v = maxPIfun(x);
%disp(['v =', num2str(v)]);
%%%%%%%%%%%%%%%%%%%%

%disp(['PI(s,:) = ', num2str(PI(s,:))]);
%disp(['fval = ', num2str(fval)]);
%disp(['V(s) = ', num2str(V(s))]);

argmax = PI(s,:);
maxValue = V(s);

end

