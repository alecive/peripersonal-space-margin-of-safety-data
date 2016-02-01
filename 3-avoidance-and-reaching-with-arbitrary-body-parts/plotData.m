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
        width=0.34;
        heigth=0.42;

        left1=0.13;
        left2=0.56;
        left3=left1;
        left4=left2;

        bottom3=0.08;
        bottom4=bottom3;
        bottom1=bottom3+heigth+0.03;
        bottom2=bottom1;
    
    % plot stuff
    figure('Position',[220 250 1300 700],'Color','w');
    ax1=subplot(2,2,1); grid on; hold on;
        plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{1}).^2,2)),'Color',randColors(1,:),'LineWidth',3);
        for i=2:9
            plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{i}).^2,2)),'Color',randColors(i,:),'LineWidth',1);
        end
        plot([0 dump.ts(end)],[0.2 0.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        axis([0 dump.ts(end) 0 1.2]);
        % axis([60 75 0 0.45]);
        % xlabel('Time [s]');
        set(gca,'XTickLabel',{});
        ylabel('Distance [m]','FontSize',20,'FontWeight','bold');
        set(gca,'Position',[left1 bottom1 width heigth]);

    ax2=subplot(2,2,2); grid on; hold on;
        for i=10:11
            plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{i}).^2,2)),'Color',randColors(i,:),'LineWidth',1);
        end
        plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{12}).^2,2)),'Color',randColors(12,:),'LineWidth',3);
        plot([0 dump.ts(end)],[0.2 0.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        axis([0 dump.ts(end) 0 1.2]);
        % axis([102 117 0 0.45]);
        % xlabel('Time [s]');
        set(gca,'XTickLabel',{});
        ylabel('Distance [m]','FontSize',20,'FontWeight','bold');
        set(gca,'Position',[left2 bottom2 width heigth]);

    ax3=subplot(2,2,3); hold on; grid on;
        plot(dump.raw.guiFAL.ts,dump.raw.guiFAL.txl(:,1),'Color',randColors(1,:),'LineWidth',3);
        for i=2:9
            plot(dump.raw.guiFAL.ts,dump.raw.guiFAL.txl(:,i),'Color',randColors(i,:),'LineWidth',1);
        end
        plot([0 dump.ts(end)],[100 100],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        l1=legend('FAL_i1','FAL_i2','FAL_i3','FAL_i4','FAL_i5','FAL_i6','FAL_o1','FAL_o2','FAL_o3');
        set(l1,'XColor',[1 1 1],'YColor',[1 1 1]);
        set(l1,'Position', [0.025 0.46 0.05 0.1],'Units','normalized');
        set(l1,'FontSize',18);
        axis([0 dump.ts(end) 4 276]);
        % axis([60 75 4 276]);
        set(gca,'YTick',[4,100,122.5,255],'YTickLabel',{'0','0.4','0.5','1'});
        xlabel('Time [s]','FontSize',20,'FontWeight','bold');
        ylabel('Activation','FontSize',20,'FontWeight','bold');
        set(gca,'Position',[left3 bottom3 width heigth]);

    ax4=subplot(2,2,4); hold on; grid on;
        for i=1:2
            plot(dump.raw.guiHR.ts,dump.raw.guiHR.txl(:,i),'Color',randColors(i+9,:),'LineWidth',1);
        end
        plot(dump.raw.guiHR.ts,dump.raw.guiHR.txl(:,3),'Color',randColors(3+9,:),'LineWidth',3);
        plot([0 dump.ts(end)],[100 100],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        l2=legend('PR1','PR2','PR3');
        set(l2,'XColor',[1 1 1],'YColor',[1 1 1])
        set(l2,'Position', [0.93 0.46 0.05 0.1],'Units','normalized');
        set(l2,'FontSize',14);
        axis([0 dump.ts(end) 4 276]);
        % axis([102 117 4 276]);
        set(gca,'YTick',[4,100,122.5,255],'YTickLabel',{'0','0.4','0.5','1'});
        xlabel('Time [s]','FontSize',20,'FontWeight','bold');
        ylabel('Activation','FontSize',20,'FontWeight','bold');
        set(gca,'Position',[left4 bottom4 width heigth]);

    dump.color=randColors;

    % ax3=subplot(3,1,3); grid on; hold on;
    %     part=[];
    %     for i=1:dump.maxlen
    %         part = [part, 'n'];
    %     end

    %     for i=1:size(dump.raw.avDump.part,1)
    %         if dump.raw.avDump.part(i) == 'l'
    %             part(dump.raw.avDump.ts_id(i)+1) = 'l';
    %         elseif dump.raw.avDump.part(i) == 'r'
    %             part(dump.raw.avDump.ts_id(i)+1) = 'r';
    %         end
    %     end
    %     part=part';

    %     stairs(dump.ts,part=='l','Color',rand(3,1));
    %     stairs(dump.ts,part=='r','Color',rand(3,1));
    %     legend('left','right');
    %     dump.raw.avDump.partAligned=part;
    %     axis([0 dump.ts(end) 0 1]);


    linkaxes([ax1,ax3],'x');
    linkaxes([ax2,ax4],'x');

end
