% clearvars -except filenames curFile evnts;
addpath('../0-utils');
addpath('../0-utils/export_fig');

if ~exist(fullfile(cd,'experiments.mat'),'file')
    error('ERROR: please create the experiments.mat file before running this script');
    return;
else
    disp(sprintf('Loading data from %s...',fullfile(cd,'experiments.mat')));
    load('experiments.mat')

    % DOUBLE TOUCH - LEFT FOREARM - INTERNAL
    F1.protocol = '1_DoubleTouch_FAL_int';
    F1.part     = '[left_forearm]';

    for i=1:6
        F1.taxels(i)      = E.taxels(i);
        F1.taxels(i).negH = E.taxels(i).negH + F.taxels(i).negH;
        F1.taxels(i).posH = E.taxels(i).posH + F.taxels(i).posH;
    end

    for i=1:length(F1.taxels)
        F1.taxels(i).H    = F1.taxels(i).posH./(F1.taxels(i).posH+F1.taxels(i).negH);

        % Remove any NaN thingy and the outliers    
        for j=1:size(F1.taxels(i).H,1)
            for k=1:size(F1.taxels(i).H,2)
                if isnan(F1.taxels(i).H(j,k))
                    F1.taxels(i).H(j,k)=0;
                end
                if (F1.taxels(i).posH(j,k)+F1.taxels(i).negH(j,k)<60)
                    F1.taxels(i).H(j,k)=0;
                else
                    F1.taxels(i).H(j,k)=2*F1.taxels(i).H(j,k);
                end
            end
        end

        F1.taxels(i).H111 = F1.taxels(i).H;
    end
    F1.nEvents     = size(E.evnts,1)+size(F.evnts,1);
    F1.nSamplesTot = sum(sum(F1.taxels(2).posH+F1.taxels(2).negH));

    % FINGERTIP TRACKING - LEFT FOREARM - INTERNAL
    F2.protocol = '2_FingertipTracking_FAL_int';
    F2.part     = '[left_forearm]';
    F2.taxels   = G.taxels;

    for i=1:length(F2.taxels)
        F2.taxels(i).H    = F2.taxels(i).posH./(F2.taxels(i).posH+F2.taxels(i).negH);

        % Remove any NaN thingy and the outliers    
        for j=1:size(F2.taxels(i).H,1)
            for k=1:size(F2.taxels(i).H,2)
                if isnan(F2.taxels(i).H(j,k))
                    F2.taxels(i).H(j,k)=0;
                end
                if (F2.taxels(i).posH(j,k)+F2.taxels(i).negH(j,k)<10)
                    F2.taxels(i).H(j,k)=0;
                end
            end
        end

        F2.taxels(i).H111 = F2.taxels(i).H;
    end
    F2.nEvents     = size(G.evnts,1);
    F2.nSamplesTot = sum(sum(F2.taxels(2).posH+F2.taxels(2).negH));

    % OPTICAL FLOW - LEFT FOREARM - INTERNAL
    F3.protocol = '3_OpticalFlow_FAL_int';
    F3.part     = '[left_forearm]';
    for i=1:3
        F3.taxels(i)      = H.taxels(i);
        F3.taxels(i).negH = H.taxels(i).negH + I.taxels(i).negH;
        F3.taxels(i).posH = H.taxels(i).posH + I.taxels(i).posH;
    end

    for i=1:length(F3.taxels)
        F3.taxels(i).H    = 3*F3.taxels(i).posH./(F3.taxels(i).posH+F3.taxels(i).negH);

        % Remove any NaN thingy and the outliers    
        for j=1:size(F3.taxels(i).H,1)
            for k=1:size(F3.taxels(i).H,2)
                if isnan(F3.taxels(i).H(j,k))
                    F3.taxels(i).H(j,k)=0;
                end
                if (F3.taxels(i).posH(j,k)+F3.taxels(i).negH(j,k)<10)
                    F3.taxels(i).H(j,k)=0;
                end
            end
        end

        F3.taxels(i).H111 = F3.taxels(i).H;
    end
    F3.nEvents     = size(H.evnts,1)+size(I.evnts,1);
    F3.nSamplesTot = sum(sum(F3.taxels(2).posH+F3.taxels(2).negH));

    % OPTICAL FLOW - LEFT FOREARM - EXTERNAL
    F4.protocol = '4_OpticalFlow_FAL_ext';
    F4.part     = '[left_forearm]';
    for i=1:3
        F4.taxels(i)      = J.taxels(i);
        F4.taxels(i).negH = J.taxels(i).negH + K.taxels(i).negH;
        F4.taxels(i).posH = J.taxels(i).posH + K.taxels(i).posH;
    end

    for i=1:length(F4.taxels)
        F4.taxels(i).H    = F4.taxels(i).posH./(F4.taxels(i).posH+F4.taxels(i).negH);

        % Remove any NaN thingy and the outliers    
        for j=1:size(F4.taxels(i).H,1)
            for k=1:size(F4.taxels(i).H,2)
                if isnan(F4.taxels(i).H(j,k))
                    F4.taxels(i).H(j,k)=0;
                end
                if (F4.taxels(i).posH(j,k)+F4.taxels(i).negH(j,k)<15)
                    F4.taxels(i).H(j,k)=0;
                end
            end
        end

        F4.taxels(i).H111 = F4.taxels(i).H;
    end
    F4.nEvents     = size(J.evnts,1)+size(K.evnts,1);
    F4.nSamplesTot = sum(sum(F4.taxels(2).posH+F4.taxels(2).negH));

    % Right Hand optical flow internal
    F5.protocol = '5_OpticalFlow_HR_int';
    F5.part     = '[right_hand]';

    for i=1:4
        F5.taxels(i)      = C.taxels(i);
        F5.taxels(i).negH = C.taxels(i).negH+D.taxels(i).negH;
        F5.taxels(i).posH = C.taxels(i).posH+D.taxels(i).posH;
    end

    for i=1:length(F5.taxels)
        F5.taxels(i).H    = F5.taxels(i).posH./(F5.taxels(i).posH+F5.taxels(i).negH);

        % Remove any NaN thingy and the outliers    
        for j=1:size(F5.taxels(i).H,1)
            for k=1:size(F5.taxels(i).H,2)
                if isnan(F5.taxels(i).H(j,k))
                    F5.taxels(i).H(j,k)=0;
                end
                if (F5.taxels(i).posH(j,k)+F5.taxels(i).negH(j,k)<20)
                    F5.taxels(i).H(j,k)=0;
                end
            end
        end

        F5.taxels(i).H111 = F5.taxels(i).H;
    end
    F5.nEvents     = size(C.evnts,1)+size(D.evnts,1);
    F5.nSamplesTot = sum(sum(F5.taxels(2).posH+F5.taxels(2).negH));
end
        
%% PLOT THE RESPONSES
    disp(sprintf('Displaying data...'));
    % TACTILE MOTOR LEARNING - DOUBLE TOUCH - LEFT FOREARM - INTERNAL
        disp(F1.protocol);
        plot_taxel_response(F1.taxels,2);
        export_fig(gcf,strcat('Fig4'),'-eps','-png');

        % figure('Position',[250 100 800 700],'Color','w');
        % draw_parzen_estimators(F1.taxels(2),'111'); view(3);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('Fig4'),'-eps','-png');

        % figure('Position',[250 100 500 500],'Color','w');
        % draw_parzen_estimators(F1.taxels(2),'110');view(0,90);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('results/',F1.protocol,'2'),'-eps','-png','-painters');

    % TACTILE VISUAL LEARNING - DOUBLE TOUCH - LEFT FOREARM - INTERNAL
        disp(F2.protocol);
        plot_taxel_response(F2.taxels,1);
        export_fig(gcf,strcat('Fig5'),'-eps','-png');

        % figure('Position',[250 100 800 700],'Color','w');
        % draw_parzen_estimators(F2.taxels(1),'111'); view(3);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('results/',F2.protocol,'1'),'-eps','-png');

        % figure('Position',[250 100 500 500],'Color','w');
        % draw_parzen_estimators(F2.taxels(1),'110');view(0,90);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('results/',F2.protocol,'2'),'-eps','-png','-painters');

    % TACTILE VISUAL LEARNING
        disp(F3.protocol);
        disp('H:');
        disp(F3.taxels(2).H);

        disp(F4.protocol);
        disp('H:');
        disp(F4.taxels(2).H);

        disp(F5.protocol);
        disp('H:');
        disp(F5.taxels(2).H);

    % TACTILE VISUAL LEARNING - EXTERNAL OBJECTS 
        figure('Position',[250 100 1785 500],'Color','w');
        
        subplot(1,3,1);
        draw_parzen_estimators(F3.taxels(2),'110');view(0,90);
        set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        axis square
        % colorbar('off')
        
        subplot(1,3,2);
        draw_parzen_estimators(F4.taxels(2),'110');view(0,90);
        set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        axis square
        % colorbar('off')

        subplot(1,3,3);
        draw_parzen_estimators(F5.taxels(2),'110');view(0,90);
        set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        axis square
        export_fig(gcf,strcat('Fig7'),'-eps','-png','-painters');

    % TACTILE VISUAL LEARNING - EXTERNAL OBJECTS FIG A
        % disp(F3.protocol);
        % plot_taxel_response(F3.taxels,2);
        % export_fig(gcf,strcat('results/',F3.protocol),'-eps','-png');

        % figure('Position',[250 100 800 700],'Color','w');
        % draw_parzen_estimators(F3.taxels(2),'111'); view(3);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('results/',F3.protocol,'1'),'-eps','-png');

        figure('Position',[250 100 500 500],'Color','w');
        draw_parzen_estimators(F3.taxels(2),'110');view(0,90);
        set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        axis square
        export_fig(gcf,strcat('Fig7A'),'-eps','-png','-painters');

    % TACTILE VISUAL LEARNING - EXTERNAL OBJECTS FIG B
        % disp(F4.protocol);
        % plot_taxel_response(F4.taxels,2);
        % export_fig(gcf,strcat('results/',F4.protocol),'-eps','-png');

        % figure('Position',[250 100 800 700],'Color','w');
        % draw_parzen_estimators(F4.taxels(2),'111'); view(3);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('results/',F4.protocol,'1'),'-eps','-png');

        figure('Position',[250 100 500 500],'Color','w');
        draw_parzen_estimators(F4.taxels(2),'110');view(0,90);
        set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        axis square
        export_fig(gcf,strcat('Fig7B'),'-eps','-png','-painters');

    % TACTILE VISUAL LEARNING - EXTERNAL OBJECTS FIG C
        % disp(F5.protocol);
        % plot_taxel_response(F5.taxels,2);
        % export_fig(gcf,strcat('results/',F5.protocol),'-eps','-png');

        % figure('Position',[250 100 800 700],'Color','w');
        % draw_parzen_estimators(F5.taxels(2),'111'); view(3);
        % set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        % axis square
        % export_fig(gcf,strcat('results/',F5.protocol,'1'),'-eps','-png');

        figure('Position',[250 100 500 500],'Color','w');
        draw_parzen_estimators(F5.taxels(2),'110');view(0,90);
        set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
        axis square
        export_fig(gcf,strcat('Fig7C'),'-eps','-png','-painters');

    disp('DONE.');

clear i j k ans;
