function [f] = maxPIfun(PIs)

global no_attacker_actions;
% global i;

num_of_o = no_attacker_actions;
f = zeros(1,num_of_o);

for op = 1:num_of_o
    f(op) = -sumfun(op,PIs());
%     f(op) = sumfun(op,PIs());
end

% if isempty(i)
%     i =0;
% end
% i = i+1;
% disp(['itr = ',num2str(i)]);
%disp(['f = ', num2str(f)]);

end

