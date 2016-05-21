function [x y p] = draw_parzen_estimators(taxel,viewPoint)
%draw_parzen_estimators Summary of this function goes here
%   Detailed explanation goes here

    if ~exist('viewPoint','var')
        viewPoint='111';
    else
        if viewPoint~='111' & viewPoint~='101' & viewPoint~='011' & viewPoint~='110'
            warning('Using the default viewPoint, ie 111!');
            viewPoint='111';
        end
    end

    if ~exist('taxel','var')
        H    = randi([-20 20],10,5);    % [x1,y1 x1,y2 ... x1,yN; ...; xM,y1 xM,y2 ... xM,yN; ]
        % H    = [  0   0  
        %           0  10   ];
        % H    = [  0   0  10  0  10  0  10  0
        %           0  10  0  10  0  10  0  10
        %           0  10  0  10  0  10  0  10
        %           0  10  0  10  0  10  0  10
        %           10  0  0  10  0  10  0  10
        %           10  0  10  0  10  0  10  0
        %           10  0  10  0  10  0  10  0 ];

        H011 = sum(H,1);
        H101 = sum(H,2);

        nSamplX = size(H,1);
        extX = [0.0 0.2];
        binWidthX   = (extX(2)-extX(1))/nSamplX;
        nSamplY = size(H,2);
        extY = [0.0   3];
        binWidthY   = (extY(2)-extY(1))/nSamplY;

        zCX  = 1;
        zCY  = 1;
    else
        H     = taxel.H111;

        NaNness=0;

        for i=1:size(H,1)
            for j=1:size(H,2)
                if isnan(H(i,j))
                    H(i,j)=0;
                    NaNness = NaNness+1;
                end
            end
        end

        if NaNness == size(H,1)*size(H,2)
            error('NaNness; return.');
            % close;
            return;
        end

        H011  = taxel.H011;
        H101  = taxel.H101;
        nSamplX = size(H,1);
        extX  = taxel.extX;
        binWidthX = taxel.binWidthX;
        fPBX = taxel.fPBX;
        fPBSX = taxel.fPBSX;

        nSamplY = size(H,2);
        extY  = taxel.extY;
        binWidthY = taxel.binWidthY;
        fPBY = taxel.fPBY;
        fPBSY = taxel.fPBSY;
    end

    sigmX   = 0.75*binWidthX;
    sigmY   = 0.75*binWidthY;
    
    if viewPoint=='111'
        x = linspace(extX(1),extX(2),10*nSamplX); x(end) = [];
        y = linspace(extY(1),extY(2),10*nSamplY); y(end) = [];
        p = zeros(length(x),length(y));

        % for i=1:length(x)
        %     for j=1:length(y)
        %         idxX = ((x(i)-fPBSX)/binWidthX+fPBX);
        %         idxY = ((y(j)-fPBSY)/binWidthY+fPBY);
        %         %p(i,j)=interpImg(H,[idxX,idxY]);
        %         p(i,j)=bilinInterpWiki(taxel,[idxX,idxY]);
        %     end
        % end

        for i=1:length(x)
            for j=1:length(y)
                p(i,j)=0;
                for ii=1:nSamplX
                    for jj=1:nSamplY
                        x_0 = extX(1)+(ii-1)*binWidthX;
                        y_0 = extY(1)+(jj-1)*binWidthY;
                        if H(ii,jj) > 0
                            p(i,j) = p(i,j) + H(ii,jj)*(1/(2*pi*sigmX*sigmY))*exp(-0.5*( (x(i)-x_0)*(x(i)-x_0)/(sigmX*sigmX) +(y(j)-y_0)*(y(j)-y_0)/(sigmY*sigmY) ));
                        end
                    end
                end
            end
        end

        % p
        p = p.*(max(max(H))/max(max(p)));      % Scale it to the maximum of H

        [simplegray,bluehot,hot2,paruly] = colormap_RGB_matrices(1000);

        surf(x,y,p','EdgeColor',[0.4 0.4 0.4],'EdgeAlpha',0.4);
        
        set(gca,'YTick',[0,1,2,3],'XTick',[-0.1,0,0.1,0.2],'FontSize',18);
        xlabel('D [m]','FontSize',30,'FontWeight','bold');
        ylabel('TTC [s]','FontSize',30,'FontWeight','bold');
        zlabel('Activation','FontSize',30,'FontWeight','bold');
        colormap(paruly);
        caxis([0.0 1.0]);
        axis([taxel.extX(1) taxel.extX(2) taxel.extY(1) taxel.extY(2) 0.0 1]);
        viewPoint(3);             % viewPoint(-37.5,30)
        grid on;

        clear i ii j jj x_0 y_0

    elseif viewPoint=='110'
        x = linspace(extX(1),extX(2),4*nSamplX);
        y = linspace(extY(1),extY(2),4*nSamplY);
        p = zeros(length(x),length(y));

        for i=1:length(x)
            for j=1:length(y)
                p(i,j)=0;
                for ii=1:nSamplX
                    for jj=1:nSamplY
                        x_0 = extX(1)+(ii-1)*binWidthX;
                        y_0 = extY(1)+(jj-1)*binWidthY;
                        if H(ii,jj) > 0
                            p(i,j) = p(i,j) + H(ii,jj)*(1/(2*pi*sigmX*sigmY))*exp(-0.5*( (x(i)-x_0)*(x(i)-x_0)/(sigmX*sigmX) +(y(j)-y_0)*(y(j)-y_0)/(sigmY*sigmY) ));
                        end
                    end
                end
            end
        end

        p = p.*(max(max(H))/max(max(p)));      % Scale it to the maximum of H
        p(p<0.0001)=0.0001;                    % Avoid a visualization problem

        [simplegray,bluehot,hot2,paruly] = colormap_RGB_matrices(1000);

        surf(x,y',p','EdgeColor',[0.4 0.4 0.4],'EdgeAlpha',0.4);

        set(gca,'YTick',[0,1,2,3],'XTick',[-0.1,0,0.1,0.2],'FontSize',18);
        xlabel('D [m]','FontSize',30,'FontWeight','bold');
        ylabel('TTC [s]','FontSize',30,'FontWeight','bold');
        colormap(paruly);
        caxis([0.0 1.0]);
        grid off;
        axis([taxel.extX(1) taxel.extX(2) taxel.extY(1) taxel.extY(2) 0.0 1]);
        hcb=colorbar('FontSize',18);
        set(hcb,'YTick',[0,0.5,1]);
        % axis square;
        % view(0,90);

        clear i ii j jj x_0 y_0
    
    elseif viewPoint=='101'
        H      = H101;
        ext    = extX;
        nSampl = length(H);
        binWidth   = binWidthX;
        sigm   = sigmX;

        x = linspace(ext(1),ext(2),10*nSampl);
        p = zeros(1,length(x));
        for i = 1:length(x)
            p(i)=0;
            for j = 1:nSampl
                x_0 = ext(1)+(j-1)*binWidth;
                if H(j) > 0 
                    p(i) = p(i) + H(j)*(1/(sqrt(2*pi)*sigm))*exp(-0.5*(x(i)-x_0)*(x(i)-x_0)/(sigm*sigm));
                end
            end
        end

        res = zeros(1,length(x));
        res(p>0) = p(p>0);
        res = res*1/max(res);                   % Scale it to 1

        bC = zeros(1,length(H));
        bC(H>0)=H(H>0);
        bC=bC*1/max(bC);                        % Scale it to 1
        bX =ext(1):binWidth:ext(2); bX(end)=[];
        
        grid on; hold on;
        bar(bX,bC,0.4);
        plot(x,res,'LineWidth',2,'color',[1 0 1]);
        set(gca,'YTick',[0,1,2,3],'XTick',[-0.1,0,0.1,0.2],'FontSize',18);
        xlabel('D [m]','FontSize',30,'FontWeight','bold');
        axis([ext(1) ext(2) 0 1]);

    elseif viewPoint=='011'
        H      = H011;
        ext    = extY;
        nSampl = length(H);
        binWidth   = binWidthY;
        sigm   = sigmY;

        x = linspace(ext(1),ext(2),10*nSampl);
        p = zeros(1,length(x));
        for i = 1:length(x)
            p(i)=0;
            for j = 1:nSampl
                x_0 = ext(1)+(j-1)*binWidth;
                if H(j) > 0 
                    p(i) = p(i) + H(j)*(1/(sqrt(2*pi)*sigm))*exp(-0.5*(x(i)-x_0)*(x(i)-x_0)/(sigm*sigm));
                end
            end
        end

        res = zeros(1,length(x));
        res(p>0) = p(p>0);
        res = res*1/max(res);           % Scale it to 1

        bC = zeros(1,length(H));
        bC(H>0)=H(H>0);
        bC=bC*1/max(bC);                % Scale it to 1
        bX =ext(1):binWidth:ext(2); bX(end)=[];
        
        grid on; hold on;
        bar(bX,bC,0.4);
        plot(x,res,'LineWidth',2,'color',[1 0 1]);
        set(gca,'YTick',[0,1,2,3],'XTick',[-0.1,0,0.1,0.2],'FontSize',18);
        xlabel('TTC [s]','FontSize',30,'FontWeight','bold');
        axis([ext(1) ext(2) 0 1]);
    end
        
end

% idea is copied from http://en.wikipedia.org/wiki/Bilinear_interpolation
% it should mimic the implementation in  double parzenWindowEstimator2D::getF_X_interpolated(const std::vector<double> x)
% differences - matlab vs. C++
 % here bins are indexed from 1
 % the idxX and idxY are real values, they already specify where in the bin
 % the data point is - e.g. idxX 1.2 means at the fist fifth of the first
 % bin in the x dim
 % H is the taxel struct
function result = bilinInterpWiki(taxel,idx)
        idxX=idx(1);
        idxY=idx(2);
        MIN_BIN_INDEX = 1;
        q11_indexX = -1; %bottom-left bin from our target - see http://en.wikipedia.org/wiki/Bilinear_interpolation
        q11_indexY = -1;
        q12_indexX = -1; %top-left bin from our target
        q12_indexY = -1;
        q21_indexX = -1; %bottom-right bin from our target 
        q21_indexY = -1;
        q22_indexX = -1; %top-right bin from our target
        q22_indexY = -1;
        fR1 = 0.0; % value at (x, y1)
        fR2 = 0.0; %value at (x,y2)
        f_x_interpolated = 0.0;
               
        halfBinWidthX = 0.5; % here we do interpolation in the bin indexes space rather than real units
        halfBinWidthY = 0.5;
        
        if( (idxX<MIN_BIN_INDEX) || (idxX>=taxel.binsNumX+1) || (idxY<MIN_BIN_INDEX) || (idxY>=taxel.binsNumY+1) )
            error(['idx is out of range! idxX:' num2str(idxX) ', idxY:' num2str(idxY)]);
        end
        
        indexX = floor(idxX);
        indexY = floor(idxY);
                 
        if((idxX-indexX)<0.5)
            q11_indexX = indexX-1;   
            q12_indexX = indexX-1;
            q21_indexX = indexX;   
            q22_indexX = indexX;
        else %x[0]>=binCenterX
            q11_indexX = indexX;   
            q12_indexX = indexX;
            q21_indexX = indexX+1;   
            q22_indexX = indexX+1;
        end
        if((idxY-indexY)<0.5)
            q11_indexY = indexY-1;   
            q12_indexY = indexY;
            q21_indexY = indexY-1;   
            q22_indexY = indexY;
        else %x[1]>=binCenterY
            q11_indexY = indexY;   
            q12_indexY = indexY+1;
            q21_indexY = indexY;   
            q22_indexY = indexY+1;
        end
        
        if( (indexX==MIN_BIN_INDEX) || (indexX==taxel.binsNumX) || (indexY==MIN_BIN_INDEX) || (indexY==taxel.binsNumY) )%bin is on the border
        %if we are out of range - we were at the border - we simply set it to the last bin - in that dimension, there won't be any interpolation       
            if(q11_indexX<MIN_BIN_INDEX) q11_indexX=MIN_BIN_INDEX; end
            if(q12_indexX<MIN_BIN_INDEX) q12_indexX=MIN_BIN_INDEX; end %N.B. for q21 and q22, <0 cannot happen, they will be checked on the other side
            if(q21_indexX>taxel.binsNumX) q21_indexX = taxel.binsNumX; end
            if(q22_indexX>taxel.binsNumX) q22_indexX = taxel.binsNumX; end
            if(q11_indexY<MIN_BIN_INDEX) q11_indexY=MIN_BIN_INDEX;end
            if(q21_indexY<MIN_BIN_INDEX) q21_indexY=MIN_BIN_INDEX;end
            if (q12_indexY>taxel.binsNumY) q12_indexY = taxel.binsNumY;end
            if (q22_indexY>taxel.binsNumY) q22_indexY = taxel.binsNumY;end
        end
        if (q11_indexX ~= q21_indexX)% we perform interpolation in x direction, see http://en.wikipedia.org/wiki/Bilinear_interpolation
            % in this bin space, bin width is simply one
              fR1 =  (q21_indexX +halfBinWidthX - idxX) * taxel.H(q11_indexX,q11_indexY) + ...
                     (idxX - (q11_indexX+halfBinWidthX))  * taxel.H(q21_indexX,q21_indexY);
              fR2 =  (q21_indexX+halfBinWidthX - idxX)  * taxel.H(q12_indexX,q12_indexY) + ...
                    (idxX - (q11_indexX+halfBinWidthX)) * taxel.H(q22_indexX,q22_indexY);
        else
              fR1 = taxel.H(q11_indexX,q11_indexY);  
              fR2 = taxel.H(q12_indexX,q12_indexY);  
        end
        %let's continue in the y direction
        if (q11_indexY ~= q12_indexY)
            f_x_interpolated = (q12_indexY+halfBinWidthY - idxY)  * fR1 + (idxY - (q11_indexY+halfBinWidthY))  * fR2;
        else
             f_x_interpolated = fR1;   
        end
        %debug
        fprintf(1,'Interpolation - looking for "bin" value at %f,%f which is bin with indices %d,%d.\n',idxX,idxY,indexX,indexY);
        fprintf(1,'    interpolating from these bins - (indexX,indexY): value\n');
        fprintf(1, 'Q11 (%d,%d): %f\n',q11_indexX,q11_indexY,taxel.H(q11_indexX,q11_indexY));
        fprintf(1, 'Q21 (%d,%d): %f\n',q21_indexX,q21_indexY,taxel.H(q21_indexX,q21_indexY));
        fprintf(1, 'Q12 (%d,%d): %f\n',q12_indexX,q12_indexY,taxel.H(q12_indexX,q12_indexY));
        fprintf(1, 'Q22 (%d,%d): %f\n',q22_indexX,q22_indexY,taxel.H(q22_indexX,q22_indexY));
        fprintf(1,'Final interpolated value is: %f\n',f_x_interpolated);
        result =  f_x_interpolated; 
        
end

