
% Game Theory 
% Solve nonantagonistic  games (bimatrix game).
% [solve,A,B, fail_strat]= GTbimatrixgames(in_mat, plot_flag, solve_type)
% input
% M - a matrix of game  
% plot_flag - 0 or 1
% solve_type - 1 linprog or 0 matrix solve 
% output
% v - value of the game 
% A - strategy of the gamer A. 
% B - strategy of the gamer B.
%************************************
% Example
% Create M - file and type.
%in_mat={[4 1] [0 0];
%        [0 0] [1 4]};
%[solve,A,B]= GTbimatrixgames(in_mat, 1)
%**************************************
% This algorithm detected pure Nash equilibria, Strong Nash equilibria,
% Pareto optimum. Graphically represents space of game. Also finding solve in
% mixed strategy with linear programming model (using optimization toolbox).
% Autor - Vsoft. vsoft@pochta.ru


function  [v1,v2,A_s,B_s, fail_strat]= GTbimatrixgames(in_mat, plot_flag, lin_flag)


%in_mat={[4 1] [0 0];
%        [0 0] [1 4]};
%
%in_mat= {[5,5] [0,10];
%         [10,0] [1,1]};

%

 plot_flag=1;
 
% A{2}(1)

[m,n]=size(in_mat);
A=[];B=[];
x=[]; y=[];
count=1;
for i=1:m
    for j=1:n
A(i,j)=in_mat{i,j}(1);
B(i,j)=in_mat{i,j}(2);
x(count)=in_mat{i,j}(1);
y(count)=in_mat{i,j}(2);
count=count+1;

    end%for
end%for
x=[x x(1)];
y=[y y(1)];

if plot_flag
plot(x,y,'-o')
title('Convex game space.')
end%if

count=0;
h={};
a=[]; b=[];
for i=1:m
    for j=1:n
 if (A(i,j)==max(A(:,j)) && B(i,j)==max(B(i,:)))
    count=count+1;
    h{count}=[i j];
    a(count)=A(i,j);
    b(count)=B(i,j);
    
 end%if
    end%for
end%for

A_temp=A;
B_temp=B;

row_A=[];col_A=[];row_B=[];col_B=[];

for i=1:max([m n])
   
%Pareto optimum
[row_A,col_A]=find(A_temp==max(max(A_temp)));
ind_B= find(B_temp<B_temp(row_A,col_A));

if ~isempty(ind_B)
   %row_A,col_A;
else
A_temp(row_A,col_A)=min(min(A_temp));    
end%if    

[row_B,col_B]=find(B_temp==max(max(B_temp)));
ind_A= find(A_temp<A_temp(row_B,col_B));

if ~isempty(ind_A)
  % row_B,col_B ;
else
B_temp(row_B,col_B)=min(min(B_temp));    
end%if    

if ~isempty(ind_A)&&~isempty(ind_B)
   break; 
end%if

    end%for


if plot_flag


x=[]; y=[];
hold on

if ~isempty(ind_B)&&~isempty(ind_B)
text(A(row_A,col_A)*0.8,B(row_A,col_A)*0.8, 'Pareto optimum')  
text(B(row_A,col_A)*0.8,A(row_A,col_A)*0.8, 'Pareto optimum')  
end%if

for i=1:size(h,2)
text(in_mat{h{i}(1),h{i}(2)}(1),in_mat{h{i}(1),h{i}(2)}(2), 'Pure Nash equilibria')    
if in_mat{h{i}(1),h{i}(2)}(1)~=in_mat{h{i}(1),h{i}(2)}(2)
text(in_mat{h{i}(1),h{i}(2)}(1),in_mat{h{i}(1),h{i}(2)}(2)-in_mat{h{i}(1),h{i}(2)}(2)*0.1, 'Strong Nash equilibria','color','red')        
end%if    

end % for
    
hold off
end%if




ms=[];
ms1=[];

if count>0
    
  for i=1:count
            ms=[ms ' (A' int2str(h{i}(1)) ',B' int2str(h{i}(2)) ') ' ';'];
            if in_mat{h{i}(1),h{i}(2)}(1)~=in_mat{h{i}(1),h{i}(2)}(2)
             ms1=[ ms1 ' (A' int2str(h{i}(1)) ',B' int2str(h{i}(2)) ') ' ';'];
            end %if
  end %for 
        
        ms=['Pure Nash equilibria: ' ms];
        disp(ms)
       
        ms1=[ 'Strong Nash equilibria: ' ms1];
        disp(ms1)
end %if

if ~isempty(ind_B)&&~isempty(ind_B)

 disp(['Pareto optimum: ' ' (A' int2str(row_A) ',B' int2str(col_A) ') ' ';'] ); 
 if row_A~=row_B&&col_A~=col_B
 disp(['Pareto optimum: ' ' (A' int2str(row_B) ',B' int2str(col_B) ') ' ';'] );   
 end%if
 
end%if


if lin_flag

[m,n]=size(A);
C=A+B;

H=-[[[zeros(m,m) C zeros(m,2);C' zeros(n,n+2);zeros(2,n+m+2)] zeros(m+m+m,m+m)]; zeros(m+n,n+m+n+m+2)];
    f=[zeros(m+n,1);1;1];
    Aeq=[ones(1,m) zeros(1,n+2); zeros(1,m) ones(1,n) zeros(1,2)];
    beq=[1;1];b=zeros(m+n,1);
    A_m=[zeros(m,m) A -ones(m,1) zeros(m,1); B' zeros(n,n+1) -ones(n,1)];
    lb=[zeros(m+n,1);-inf;-inf;zeros(m+n,1)];ub=[ones(m+n,1);inf;inf];
    
    fal_s=[zeros(m,m+n);-eye(m+n,m+n)];
    
    Aeq=[[Aeq;A_m]  fal_s];
    beq=[ beq;b;];
    f=[f; zeros(m+n,1)];

[x,fval,exitflag,output,lambda]= quadprog(-H,-f,[],[],Aeq,beq,lb,ub);
 

fall_strategy=find (abs(roundn(x(7:end),-1))>0);

if isempty(fall_strategy)
v1=x(m+n+1);
v2=x(m+n+2);
fail_strat=[];

else
v1=fval/2;
v2=fval/2;
disp ('Warning! Detected failed strategy!')    

er=[]; 
for i= size(fall_strategy,1)
if fall_strategy(i)>2
    
  fall_strategy(i)=fall_strategy(i)-2;  
end
end% for    
fail_strat=fall_strategy;

end%if
A_s = roundn(x(1:m),-3)';
B_s = roundn(x(n+1:n+m),-3)';

end%if




if ~lin_flag

u=[1 1];

v1=1/(u*inv(A)*u');

v2=1/(u*inv(B)*u');


x= v2*u*inv(B);
y =(v1*inv(A)*u')';

A_s =x;
B_s =y;

end% if


Ansver= ['Value of the game is v1 ' num2str(v1) ' and v2 ' num2str(v2) ' .'];
disp(Ansver);
Ansver= ['Strategy A is  ' num2str(A_s) '.'];
disp(Ansver);

Ansver= ['Strategy B is  ' num2str(B_s) '.'];
disp(Ansver);


