% clearvars -except filenames curFile evnts;
addpath('../0-utils');
addpath('../0-utils/export_fig');

if ~exist(fullfile(cd,'learning_process.mat'),'file')
    error('ERROR: please create the learning_process.mat file before running this script');
    return;
else
    disp(sprintf('Loading data from %s...',fullfile(cd,'learning_process.mat')));
    load('learning_process.mat');
end

% DISPLAY H

% TACTILE VISUAL LEARNING
    disp('First row: one example')
    disp('H for Taxel nr 3:');
    disp(E1.taxels(1).H);
    disp('H for Taxel nr 4:');
    disp(E1.taxels(4).H);

    disp('Middle row: four examples')
    disp('H for Taxel nr 3:');
    disp(E4.taxels(2).H);
    disp('H for Taxel nr 4:');
    disp(E4.taxels(4).H);

    disp('Last row: 53 examples')
    disp('H for Taxel nr 3:');
    disp(E53.taxels(2).H);
    disp('H for Taxel nr 4:');
    disp(E53.taxels(4).H);

% PLOT THE DATA
    figure('Position',[250 800 925 1200],'Color','w');
    
    subplot(3,2,1);
    draw_parzen_estimators(E1.taxels(1),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    xlabel('');
    axis square
    title('Taxel 3','Color', [0.7333    0.0510    0.2118],'FontSize',28,'FontWeight','bold'); 
    text(-0.21,0.28,'1 event','Color', [0.7333    0.0510    0.2118],'FontSize',28,'FontWeight','bold','Rotation',90); 
    % colorbar('off')
        
    subplot(3,2,2);
    draw_parzen_estimators(E1.taxels(4),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    xlabel('');
    ylabel('');
    axis square
    title('Taxel 4','Color', [0.7333    0.0510    0.2118],'FontSize',28,'FontWeight','bold'); 

    subplot(3,2,3);
    draw_parzen_estimators(E4.taxels(2),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    xlabel('');
    axis square
    text(-0.21,0.25,'4 events','Color', [0.7333    0.0510    0.2118],'FontSize',26,'FontWeight','bold','Rotation',90); 
    % colorbar('off');

    subplot(3,2,4);
    draw_parzen_estimators(E4.taxels(4),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    xlabel('');
    ylabel('');
    axis square

    subplot(3,2,5);
    draw_parzen_estimators(E53.taxels(2),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    axis square
    text(-0.21,0.22,'53 events','Color', [0.7333    0.0510    0.2118],'FontSize',26,'FontWeight','bold','Rotation',90); 
    % colorbar('off');

    subplot(3,2,6);
    draw_parzen_estimators(E53.taxels(4),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    ylabel('');
    axis square

    export_fig(gcf,strcat('Fig8'),'-eps','-png','-painters');

clear ans;
