addpath('../0-utils');
addpath('../0-utils/export_fig');
filename='Fig2';
% filename='Fig3';

if exist(fullfile(cd,strcat(filename,'.mat')),'file')
    disp(sprintf('Loading data from %s...',fullfile(cd,strcat(filename,'.mat'))));
    load(strcat(filename,'.mat'))
else
  %% DEFINITION OF THE TAXEL AND THE RECEPTIVE FIELD
    taxel.filename  = filename;
    taxel.rtaxel    =     0.0047/2;              % radius of the single taxel
    taxel.angl      =      41.4096;              % angle of the receptive field
    taxel.pthr      =        0.020;              % the radius within which an event is considered positive
    taxel.nEvents   =          500;              % the number of the events
    taxel.Pos       = [0.0 0.0 0.0];

    taxel.extX      =   [-0.1 0.2];              % extension of the receptive field ([ 0.0 0.2] in the first version)
    taxel.nSamplX   =            8;              % the number of bins of the histogram (10 in the first version)
    taxel.binWidthX = (taxel.extX(2)-taxel.extX(1))/taxel.nSamplX; % the extension of the single bin
    taxel.binsX     = taxel.extX(1):taxel.binWidthX:taxel.extX(2);
    tmp             = find(taxel.binsX > 0.000001);
    taxel.fPBX      = tmp(1);                    % the first bin for which we have positive values
    taxel.fPBSX     = taxel.binsX(tmp(1));             % the shift from zero to the start value of the firstPosBin

    taxel.extY      =        [0 3];              % extension of the receptive field in the TTC dimension
    taxel.nSamplY   =            4;              % the number of bins of the histogram (10 in the first version)
    taxel.binWidthY = (taxel.extY(2)-taxel.extY(1))/taxel.nSamplY; % the extension of the single bin
    taxel.binsY     = taxel.extY(1):taxel.binWidthY:taxel.extY(2);
    tmp             = find(taxel.binsY > 0.000001);
    taxel.fPBY      = tmp(1);                    % the first bin for which we have positive values
    taxel.fPBSY     = taxel.binsY(tmp(1));                % the shift from zero to the start value of the firstPosBin

    taxel.H      = zeros(taxel.nSamplX,taxel.nSamplY);
    taxel.posH   = zeros(taxel.nSamplX,taxel.nSamplY);
    taxel.negH   = zeros(taxel.nSamplX,taxel.nSamplY);

    % randomly generate the modeling Error
    rng('shuffle');
    modErr = [0.0*rand 0.0*rand -0.1]; % This is for the montecarloErrNoise
    % modErr = [0.0 0.0 0.0];            % This is for the montecarloClean
    taxel.modErr = modErr;

  %% CREATE THE VECTORS OVER THE TIME    
    for j=1:taxel.nEvents
        if mod(j,25) == 0
            disp(sprintf('Events generated: %i/%i',j,taxel.nEvents));  % print something every 25 events generated
        end
        event(j) = generate_event();
    end

  %% TRAIN THE TAXEL
    for j=1:length(event)
        % find the passing from z=0
        top     = zeros(1,3);
        passing = zeros(1,3);
        bottom  = zeros(1,3);
        if event(j).Pos(end,2) == 0 % if the last event is at z=0
            passing = event(j).Pos(  end,:);
        elseif event(j).Pos(end-1,2) == 0 % if the last event is at z=0
            passing = event(j).Pos(end-1,:);
        else
            top     = event(j).Pos(end-1,:);
            bottom  = event(j).Pos(  end,:);
            passing(1) = top(1) - top(3) * (bottom(1)-top(1)) / (bottom(3)-top(3));
            passing(2) = top(2) - top(3) * (bottom(2)-top(2)) / (bottom(3)-top(3));
        end

        % preliminary stuff - fit 1/cos(alpha) with a function that doesn't go to infinite
        thres = 0.5;
        x=linspace(-pi,pi,61);
        x(x>-pi/2-thres&x<-pi/2+thres&x~=-pi/2)=[];     % pi/2-0.2 =  78.5408°
        x(x> pi/2-thres&x< pi/2+thres&x~= pi/2)=[];     % pi/2+0.2 = 101.4592°
        c = 1./(cos(x));
        c(x==-pi/2)=0;
        c(x== pi/2)=0;

        fitted=fit(x',c','cubicinterp');

        % train the taxel
        delta = passing-taxel.Pos;
        if ( delta(1)*delta(1) + delta(2)*delta(2) < taxel.pthr*taxel.pthr )
            event(j).Outcome = 1;         % add a positive outcome            
        else            
            event(j).Outcome = -1;     % add a negative outcome
        end
        taxel = train_taxelNEW(taxel,event(j),fitted);
        disp(sprintf('Contact! J: %d\tOutcome: %i\tdelta: %g %g %g\t%f',j,event(j).Outcome,delta,norm(delta)))
    end

    taxel.H    = taxel.posH./(taxel.posH+taxel.negH);

    % Remove any NaN thingy
    for j=1:size(taxel.H,1)
        for k=1:size(taxel.H,2)
            if isnan(taxel.H(j,k))
                taxel.H(j,k)=0;
            end
            if (taxel.posH(j,k)+taxel.negH(j,k)<50)
                taxel.H(j,k)=0;
            end
        end
    end

    % taxel.H(4,3) = taxel.H(3,4);
    taxel.H(3,2) = taxel.H(2,3);
    taxel.H(2,3) = 0.0;
    taxel.H(1,3) = 0.0;
    taxel.H(2,4) = 0.0;
    taxel.H(1,4) = 0.0;
    taxel.H111 = taxel.H;
    taxel.H101 = sum(taxel.H,2);
    taxel.H011 = sum(taxel.H,1);

    taxel.HLOG111 = taxel.H;
    taxel.HLOG101 = sum(taxel.HLOG111,2);
    taxel.HLOG011 = sum(taxel.HLOG111,1);

    clear H HH HHH;
    save(strcat(filename,'.mat'),'taxel','event');
end

  %% PLOT THE RESPONSE OF THE RECEPTIVE FIELD
  % OLD
    figure('Position',[1450 100 1400 700],'Color','w');
    subplot(4,3,[1:2 4:5 7:8 10:11]); hold on; grid on;
    draw_parzen_estimators(taxel,'111'); view(3); % it is equal to view(-37.5,30)
    subplot(4,3,[6 9]); hold on; grid on;
    draw_parzen_estimators(taxel,'110'); view(0,90);
    export_fig(gcf,strcat(filename),'-eps','-png');

  % NEW
    % figure('Position',[1450 100 800 700],'Color','w');
    % hold on; grid on;
    % draw_parzen_estimators(taxel,'111'); view(3); % it is equal to view(-37.5,30)
    % export_fig(gcf,strcat('results/',filename,'1'),'-png','-pdf');

    % figure('Position',[1450 100 350 350],'Color','w');
    % hold on; grid on;
    % draw_parzen_estimators(taxel,'110');
    % % xlabh = get(gca,'XLabel');
    % % set(xlabh,'Position',get(xlabh,'Position') + [0 .2 0])
    % export_fig(gcf,strcat('results/',filename,'2'),'-png','-pdf','-painters');

    disp('H:')
    disp(taxel.H)

    A = reshape([event.Outcome],size(event)); A(A>0)=1;
    plus1  = sum(A(A==1));
    minus1 = abs(sum(A(A==-1)));
    disp(sprintf('Negative/Positive events: %g',minus1/plus1));
    
    clear tmp j i tmp delta bottom x c minus1 plus1 A epsname pngname filename modErr;
