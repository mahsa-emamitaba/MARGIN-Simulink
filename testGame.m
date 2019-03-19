

% M= [8 2 4;
%    4 5 6
%    1 7 3];
% [v,A,B,Mat]=GTantagonisticgames(A);

% M = [ 8 2 4 ; 4 5 6 ; 1 7 3 ];
  M = [ 5 7 4 ; 2 3 6 ; 10 9 8 ];
[v,A,B,Mat]=GTantagonisticgames(M , 1);
disp(Mat);
disp(A);
%Find cumulative distribution
c = cumsum(A);
disp(c);
%Draw point at random according to probability density
draw = rand();
%disp(['draw = ',  num2str(draw)]);
Action = find(c >= draw==1,1);
disp(['Action = ', num2str(Action)]);


% mah = [2 ,2 ,2];
% disp(min(mah));

%************************************
% Example
% Create M - file and type.
%in_mat={[4 1] [0 0];
%        [0 0] [1 4]};
%[solve,A,B]= GTbimatrixgames(in_mat, 1)
%**************************************

%[solve,A,B]= GTbimatrixgames(M , 1); 
