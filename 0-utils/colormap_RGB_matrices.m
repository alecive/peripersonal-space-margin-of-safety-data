function [simplegray, bluehot, hot2, paruly] = colormapRGBmatrices(N)
% This function creates a custom color map (fucking cool!)
% 
% It expects 4 input parameters: N is the number of intermediate points that your colormap should have. The other three are matrices that contain the transitions for each channel. Such a matrix should have the following form:
%
% M = [ 0, b1;
%       x1,b2;
%       ...
%       x_n, b_(n+1);
%       1, b_(n+1);
%     ];
%
% the first column give the fractions, where a brightness value should be defined. The second column should contain the brightness levels. Make sure to start the first column at 0 and end it with 1!
%
% A simple, linear grayscale map can be created with
%
%
% M = [0,0;1,1;];
% simplegray = colormapRGBmatrices( 256, M, M, M);
%
% Try also with:
%
% MR=[0,0; 
%     0.02,0.3; %this is the important extra point
%     0.3,1;
%     1,1];
% MG=[0,0;
%     0.3,0; 
%     0.7,1;
%     1,1];
% MB=[0,0; 
%     0.7,0;
%     1,1];
% hot2 = colormapRGBmatrices(500,MR,MG,MB);
%
% Or:
%
% bluehot = colormapRGBmatrices(500,MB,MG,MR);
%

    M  = [  0,   0;    1,  1;];
    MR = [  0,0.10; 0.02,0.3; 0.3,1; 1,0.95];
    MG = [  0,0.10;  0.3,  0; 0.7,1; 1,0.95];
    MB = [0.1,0.10;  0.7,  0;        1,0.95];
    simplegray = createColormap(N, M, M, M);
    hot2       = createColormap(N,MR,MG,MB);
    bluehot    = createColormap(N,MB,MG,MR);
    paruly     = createParulyMap(N);
end

function mymap = createParulyMap(n)
    %PARULY Blueish-greenish-orangey-yellowish color map mimics, but 
    % does not exactly match, the default parula color map introduced 
    % in Matlab R2014b.  
    % 
    % Syntax and Description:
    % map = paruly(n) returns an n-by-3 matrix containing a parula-like 
    % colormap. If n is not specified, a value of 64 is used. 
    % 
    % Chad A. Greene. The University of Texas at Austin. 
    % 
    % See also AUTUMN, BONE, COOL, COPPER, FLAG, GRAY, HOT, HSV,
    % JET, LINES, PINK, SPRING, SUMMER, WINTER, COLORMAP.
    C.B = [1058482033.44853  -10748732834.0071   50517346203.7914    -145801965208.361   289144750640.383    -417695642652.491   454671842221.995    -380534553294.152   247676664244.303    -125979265217.504   50051575381.9942    -15444738162.7808   3659928686.04537    -653929236.498032   85661200.2538053    -7885370.81078983   478474.328246893    -17443.0004135579   332.002511499741    0.583692035048707   0.531791023379267];
    C.G = [197305387.967731  -1925711190.84183   8716944379.05960    -24297299084.9147   46695527134.3723    -65652015186.8817   69922556706.2649    -57634757763.3276   37243804342.6212    -18997216547.5248   7663150613.75323    -2437617957.87483   606395040.065959    -116132918.873322   16670219.7935428    -1716627.28665654   118246.594923277    -4898.51327391422   105.770980145826    0.591540259267455   0.167447289862944];
    C.R = [47920986.9845841  -432002789.961282   1661169948.99912    -3328209661.13657   2708603217.88626    3475566512.89112    -14225668415.7445   23164115071.2720    -24467511476.1342   18546728112.8514    -10457617267.0848   4438525756.52115    -1415345262.44771   334628886.548897    -57176214.1899078   6769646.99828671    -519953.565824257   23439.8810049338    -544.946889629835   5.15413211632107    0.200909555611123];

    x = linspace(0,1,n-int16(n/3))'; 

    r = polyval(C.R,x);
    g = polyval(C.G,x);
    b = polyval(C.B,x);

    % Clamp: 
    r(r<0)=0; 
    g(g<0)=0; 
    b(b<0)=0; 
    r(r>1)=1; 
    g(g>1)=1; 
    b(b>1)=1; 

    mymap = [r g b];
    finalpart = repmat(mymap(end,:),int16(n/3),1);
    mymap = [mymap;finalpart];

end



function mymap=createColormap(N,rm,gm,bm)
    x = linspace(0,1, N);
    rv = interp1( rm(:,1), rm(:,2), x);
    gv = interp1( gm(:,1), gm(:,2), x);
    mv = interp1( bm(:,1), bm(:,2), x);
    mymap = [ rv', gv', mv'];
    %exclude invalid values that could appear
    mymap( isnan(mymap) ) = 0;
    mymap( (mymap>1) ) = 1;
    mymap( (mymap<0) ) = 0;
end
