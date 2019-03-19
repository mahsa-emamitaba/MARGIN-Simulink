function [ GT ] = sim_Update_GT( GT, s1, a1, o1, rew, alpha, gamma, v)

%[GT] = sim_Update_GT( GT, s1, a1, r, s2, a2, alpha, gamma, att )

%Q(s,a) =  Q(s,a) + alpha * ( r + gamma*Q(sp,ap) - Q(s,a) );

%GT(a,:,s) =  GT(a,:,s) + r;

%GT(a1,att,s1) =  GT(a1,att,s1) + alpha * ( r + gamma*GT(a2,att,s2) - GT(a1,att,s1) );


GT(a1,o1,s1) = GT(a1,o1,s1) + alpha * ( rew + gamma*v - GT(a1,o1,s1) );

end




