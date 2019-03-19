function [sum] = sumfun(o,PIs)

global GT_sumfun;
global state_sumfun;

sum = 0.0;
for ap = 1:size(PIs,2)
    sum = sum + GT_sumfun(ap,o,state_sumfun)* PIs(ap);
    %sum = round( (sum + GT(ap,o,s)* PIs(ap)) *100)/100;
end


end

