

% Game Theory 
% Solve antagonistic games (zero sum game).
%[v,A,B,Mat]=GTantagonisticgames(M, solve_type);
% input
% M - a matrix of game  
% solve_type - 1 linprog or 0 matrix solve 
% output
% v - value of the game 
% A - strategy of the gamer A. 
% B - strategy of the gamer B.
% Mat - optimize matrix.
% Example
% Create M - file and type.
% M= [8 2 4;
%    4 5 6
%    1 7 3];
% [v,A,B,Mat]=GTantagonisticgames(A);
%--------------------------------------
% This algorithm detected saddle point or finding solve in
% mixed strategy with linear programming model (using optimization toolbox).
% Also analyzes a matrix of game on presence of useless strategy and returns optimum.
% Autor - Vsoft. vsoft@pochta.ru



function [solve,A,B,finalmatrix] = GTantagonisticgames(gamemat,lin_flag)

gamematr=[];
gamematr=gamemat;
if isscalar(gamemat)
 error('First argument should be a matrix.');  
 return
elseif size(gamemat,1)==1 || size(gamemat,2)==1   
  error('Minimal dimension of a matrix 2x2.');  
 return
end %if

if min(max(gamemat))==max(min(gamemat'))
   [C,col] = min(max(gamemat));
   [C,row] = max(min(gamemat'));
   Answer=['The Game has a saddle point at the location : (' int2str(row) ',' int2str(col) ') and value of the game is ' num2str(gamemat(row,col)) '. Mixed strategy is needed.'];
   solve=gamemat(row,col);
   A=row;
   B=col;
   finalmatrix=gamemat;
   disp (Answer)
   return
end %if  

[m,n]=size(gamemat);

if lin_flag

A=linprog(-[1;zeros(m,1);zeros(m,1)],[],[],[0 zeros(1,m) ones(1,m); ones(n,1) eye(n,m) -gamemat'],[1;zeros(m,1)],[-inf;zeros(m,1);zeros(m,1)]);
fall_strategy_A=find (roundn(A(2:m+1),-1)>0);

v=A(1,1);

gamemat_B= gamemat*-1;
min_B= min(min(gamemat_B));
gamemat_B=gamemat_B+abs(min_B);

B=linprog(-[1;zeros(n,1);zeros(n,1)],[],[],[0 zeros(1,n) ones(1,n); ones(m,1) eye(m,n) -gamemat_B],[1;zeros(n,1)],[-inf;zeros(n,1);zeros(n,1)]);

fall_strategy_B=find (roundn(B(2:n+1),-1)>0);




if ~isempty(fall_strategy_B)
Ansver= ['Strategy ' num2str(fall_strategy_B)  ' is useless for the gamer A .'];
disp(Ansver); 
for i=fall_strategy_B
gamematr(i,:)=[];
end %for
end %if   


if ~isempty(fall_strategy_A)
Ansver= ['Strategy ' num2str(fall_strategy_A)  ' is useless for the gamer B .'];
disp(Ansver);    
for i=fall_strategy_A
gamematr(:,i)=[];
end %for
end %if    
    
solve=v;
x = num2str(roundn(A(m+2:end),-3)');
y = num2str(roundn(B(n+2:end),-3)');

% Added by Mahsa
A =roundn(A(m+2:end),-3)';
B =roundn(B(n+2:end),-3)';

end %if linflag


if ~lin_flag

u=ones(1,n);

min_elem=min(min(gamemat));

if min_elem < 0
 G_M= gamemat+abs(min_elem);  
v=(1/(u*inv(G_M)*u'));
v_end=v-abs(min_elem);
else
G_M= gamemat;    
v=(1/(u*inv(G_M)*u'));
v_end=v;
end %if    





x= v*u*inv(G_M);
y =abs((v*inv(G_M*-1)*u'))';

solve=v_end;
A =x;
B =y;


end% if


Ansver= ['Value of the game is ' num2str(solve) '.'];
disp(Ansver);
Ansver= ['Strategy A is  ' num2str(x) '.'];
disp(Ansver);

Ansver= ['Strategy B is  ' num2str(y) '.'];
disp(Ansver);


finalmatrix=gamematr;


