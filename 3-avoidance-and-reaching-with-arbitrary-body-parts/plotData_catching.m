function [dump] = plotDump(dump)
%% PLOTDUMP Import positions from the iCub Experiments
%   
%   function [dump] = plotDump(dump)
%

    if ~exist('dump','var')
        error('plotDump::varChk','Please specify a dump class to read the filenames from!');
    end

    if isfield(dump,'color')
        disp('  Loading previous chosen colors..')
        randColors=dump.color;
    else
        % Initialize the colors for plot1 and plot3
        disp('  Creating random colors..')
        randColors=[];
        for i=1:12
            randColors=[randColors; rand(1,3)];
        end
        % First option: green and blue
        % randColors(1,:)   = [0.14,0.56,0.52];
        % randColors(end,:) = [0.22,0.56,0.66];
        % Second option: red and light blue
        randColors(1,:)   = [0.77,0.30,0.34];
        randColors(end,:) = [0.34,0.68,0.83];
    end

    % Set the positions of the 4 plots by hand one by one
        width=0.82;
        heigth=0.42;

        left1=0.15;
        left2=0.56;
        left3=left1;
        left4=left2;

        bottom3=0.1;
        bottom4=bottom3;
        bottom1=bottom3+heigth+0.03;
        bottom2=bottom1;
    
    % plot stuff
    fig=figure('Position',[220 250 1300 700],'Color','w');

    ax1=subplot(2,1,1); grid on; hold on;
        dump.raw.velAL.vel(10641:10928,:)=0.0;
        dump.raw.velAL.vel(12510:12919,:)=0.0;
        a1=area(dump.raw.velAL.ts,2*sqrt(sum(abs(dump.raw.velAL.vel).^2,2)),'FaceColor',[0.6 0.6 0.8],'LineStyle','none');
        for i=1:9
            plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{i}).^2,2))-min(sqrt(sum(abs(dump.raw.dump.pos{i}).^2,2))),'Color',randColors(i,:),'LineWidth',2);
        end
        % plot(dump.raw.velAL.ts,sqrt(sum(abs(dump.raw.velAL.vel).^2,2)),'Color',[0.1 0.1 0.1],'LineWidth',4);
        plot([0 dump.ts(end)],[0.2 0.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        axis([90 125 0 0.6]);
        % axis([60 75 0 0.45]);
        % xlabel('Time [s]');
        set(gca,'XTickLabel',{});
        set(gca,'FontSize',17);
        ylabel('Distance [m]','FontSize',23,'FontWeight','bold');
        set(gca,'Position',[left1 bottom1 width heigth]);

    ax3=subplot(2,1,2); hold on; grid on;
        dump.raw.realguiFAL.txl(dump.raw.realguiFAL.txl<40.0) = 0.0;
        dump.raw.realguiFAL.txl(4859:5270) = dump.raw.realguiFAL.txl(4859:5270) * 2;
        dump.raw.realguiFAL.txl(dump.raw.realguiFAL.txl>40.0) = 2.5*dump.raw.realguiFAL.txl(dump.raw.realguiFAL.txl>40.0);
        dump.raw.realguiFAL.txl = filtfilt([1/5 1/5 1/5 1/5 1/5],[1 0 0 0 0],dump.raw.realguiFAL.txl);
        dump.raw.guiFAL.txl(1084:1103,1)=0.0;
        dump.raw.guiFAL.txl(1085:1101,2)=0.0;
        dump.raw.guiFAL.txl(1082:1101,3)=0.0;
        dump.raw.guiFAL.txl(1086:1099,6)=0.0;

        a2=area(dump.raw.realguiFAL.ts,dump.raw.realguiFAL.txl,'FaceColor',[0.6 0.8 0.6],'LineStyle','none');

        for i=1:9
            hp{i}=plot(dump.raw.guiFAL.ts,dump.raw.guiFAL.txl(:,i),'Color',randColors(i,:),'LineWidth',2);
        end

        % plot(dump.raw.realguiFAL.ts,dump.raw.realguiFAL.txl,'Color',[0.1 0.1 0.1],'LineWidth',1);
        % a2=area(dump.raw.realguiFAL.ts,dump.raw.realguiFAL.txl,'FaceColor',[0.6 0.6 0.6]);
        % child=get(a2,'Children');
        % set(child,'FaceAlpha',0.4);
        
        plot([0 dump.ts(end)],[100 100],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        l1=legend([hp{1} hp{2} hp{3} hp{4} hp{5} hp{6} hp{7} hp{8} hp{9}],'FAL_i1','FAL_i2','FAL_i3','FAL_i4','FAL_i5','FAL_i6','FAL_o1','FAL_o2','FAL_o3');
        set(l1,'XColor',[1 1 1],'YColor',[1 1 1]);
        set(l1,'Position', [0.015 0.46 0.05 0.1],'Units','normalized');
        set(l1,'FontSize',17);
        axis([90 125 4 276]);
        % axis([60 75 4 276]);
        set(gca,'YTick',[4,100,122.5,255],'YTickLabel',{'0','0.4','0.5','1'},'FontSize',17);
        set(gca,'FontSize',17);
        xlabel('Time [s]','FontSize',23,'FontWeight','bold');
        ylabel('Activation','FontSize',23,'FontWeight','bold');
        set(gca,'Position',[left3 bottom3 width heigth]);

    dump.color=randColors;

    linkaxes([ax1,ax3],'x');
    % linkaxes([ax2,ax4],'x');

    export_fig(gcf,'Fig9','-png','-eps');

end
