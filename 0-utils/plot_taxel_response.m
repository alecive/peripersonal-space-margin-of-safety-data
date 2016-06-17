function plot_taxel_response(taxels,txl2Plot)
%% PLOTTAXELRESPONSE Plots the response of the receptive field
%
%   plotTaxelResponse(taxels,txl2Plot,eventType,ratio)
%
% This function plots the Parzen Window Estimation of a taxel,
% given the taxel array (i.e. taxels) and the index of the taxel to be plotted.
% It creates a figure made by 4 subplots, that represent the receptive field.

    % disp('posH:')
    % disp(taxels(txl2Plot).posH)
    % disp('negH:')
    % disp(taxels(txl2Plot).negH)
    disp('H:');
    disp(taxels(txl2Plot).H);
    % disp('HLOG111:')
    % disp(taxels(txl2Plot).HLOG111)

    figure('Position',[250 100 1400 700],'Color','w');
    subplot(4,3,[1:2 4:5 7:8 10:11]); hold on; grid on;
    draw_parzen_estimators(taxels(txl2Plot),'111'); view(3); % it is equal to view(-37.5,30)
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
    subplot(4,3,[6 9]); hold on; grid on;
    draw_parzen_estimators(taxels(txl2Plot),'110');view(0,90);
    set(gca,'YTick',[0,0.4,0.8,1.2],'YTickLabel',{'0','1','2','3'},'FontSize',14);
end
