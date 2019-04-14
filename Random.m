function [ action ] = Random(u)

% u(1) = Load1
% u(2) = Timeout1
% u(3) = Served1
% u(4) = AveQueue1
% u(5) = Queue Length
% u(6) = Ave Integration time for the user requests in Server 1
% u(7) = Service time for the users requests in server 1
% u(8) = End to end response Time for entities from user 1 and 2
% u(9) = user that is severd by the server
% u(10) = Integration time for User 1
% u(11) = Integration time for User 2
% u(12) = Integration time for User 3
% u(13) = queueWait

global served1;
global timeout1;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Random Action %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sys_action_num = 3;
action1 = ceil(sys_action_num.*rand(1,1));
action2 = ceil(sys_action_num.*rand(1,1));
action3 = ceil(sys_action_num.*rand(1,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Fixed Puzzle Action %%%%%%%%%%%%%%%%%%
% action1 = 1; 
% action2 = 1; 
% action3 = 1; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
action = [action1 action2 action3];
% Store the previose values
timeout1 = u(2);
served1 =  u(3);

end

