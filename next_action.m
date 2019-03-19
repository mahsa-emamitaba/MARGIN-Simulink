function [ Action ] = next_action(GT,pi,epsilon)


% number of defender's actions
actions = size(GT,1);

if (rand() > epsilon)
    %#Find cumulative distribution
    c = cumsum(pi);
    %#Draw point at random according to probability density
    draw = rand();
    Action = find(c >= draw==1,1);
    %disp(['Action = ', num2str(Action)]);
    
else
    Action = ceil(actions.*rand(1,1));
end

end

