function [dump] = plotDump_avoidance(dump)
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
        width=0.36;
        heigth=0.42;

        left1=0.13;
        left2=0.56;
        left3=left1;
        left4=left2;

        bottom3=0.1;
        bottom4=bottom3;
        bottom1=bottom3+heigth+0.03;
        bottom2=bottom1;
    
    % plot stuff
    fig=figure('Position',[220 250 1400 700],'Color','w');
    ax1=subplot(2,2,1); grid on; hold on;
        dump.raw.velAL.vel(6467:6763,:)=0.0;
        dump.raw.velAL.vel(7328:7547,:)=0.0;
        a1=area(dump.raw.velAL.ts,2*sqrt(sum(abs(dump.raw.velAL.vel).^2,2)),'FaceColor',[0.6 0.6 0.8],'LineStyle','none');
        plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{1}).^2,2)),'Color',randColors(1,:),'LineWidth',3);
        for i=2:9
            plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{i}).^2,2)),'Color',randColors(i,:),'LineWidth',1);
        end
        plot([0 dump.ts(end)],[0.2 0.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([62.485 62.485],[0 1.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([70.4 70.4],[0 1.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        % axis([0 dump.ts(end) 0 1.2]);
        axis([60 75 0 0.45]);
        % xlabel('Time [s]');
        set(gca,'XTickLabel',{});
        set(gca,'YTick',[0,0.1,0.2,0.3,0.4],'FontSize',17);
        ylabel('Distance [m]','FontSize',23,'FontWeight','bold');
        set(gca,'Position',[left1 bottom1 width heigth]);

    ax2=subplot(2,2,2); grid on; hold on;
        dump.raw.velAR.vel(1817:2134,:)=0.0;
        dump.raw.velAR.vel(11361:11678,:)=0.0;
        dump.raw.velAR.vel(2904:3104,:)=dump.raw.velAR.vel(11161:11361,:);
        a1=area(dump.raw.velAR.ts,2*sqrt(sum(abs(dump.raw.velAR.vel).^2,2)),'FaceColor',[0.6 0.6 0.8],'LineStyle','none');
        for i=10:11
            plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{i}).^2,2)),'Color',randColors(i,:),'LineWidth',1);
        end
        plot(dump.raw.dump.ts, sqrt(sum(abs(dump.raw.dump.pos{12}).^2,2)),'Color',randColors(12,:),'LineWidth',3);

        plot([0 dump.ts(end)],[0.2 0.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([15.44 15.44],[0 1.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([28.57 28.57],[0 1.2],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        axis([14 34 0 0.45]);
        % xlabel('Time [s]');
        % set(gca,'XTick',[102,107,112,117],'XTickLabel',{});
        set(gca,'XTick',[15.44,20,25,28.57,30],'XTickLabel',{});
        set(gca,'YTick',[0,0.1,0.2,0.3,0.4],'FontSize',17);
        ylabel('Distance [m]','FontSize',23,'FontWeight','bold');
        set(gca,'Position',[left2 bottom2 width heigth]);

    ax3=subplot(2,2,3); hold on; grid on;
        plot(dump.raw.guiFAL.ts,dump.raw.guiFAL.txl(:,1),'Color',randColors(1,:),'LineWidth',3);
        for i=2:9
            if i == 3
                plot([0 dump.ts(end)],[0 0],'Color',randColors(i,:),'LineWidth',1);
            else
                plot(dump.raw.guiFAL.ts,dump.raw.guiFAL.txl(:,i),'Color',randColors(i,:),'LineWidth',1);
            end
        end
        plot([0 dump.ts(end)],[100 100],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([62.485 62.485],[0 276],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([70.4 70.4],[0 276],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        l1=legend('FAL_i1','FAL_i2','FAL_i3','FAL_i4','FAL_i5','FAL_i6','FAL_o1','FAL_o2','FAL_o3');
        set(l1,'XColor',[1 1 1],'YColor',[1 1 1]);
        set(l1,'Position', [0.014 0.46 0.05 0.1],'Units','normalized');
        set(l1,'FontSize',17);
        axis([60 75 4 276]);
        set(gca,'XTick',[60,62.4,65,70,70.4,75],'XTickLabel',{'60','62.4','65','','70.4','75'},'FontSize',17);
        set(gca,'YTick',[4,100,122.5,255],'YTickLabel',{'0','0.4','0.5','1'});
        xlabel('Time [s]','FontSize',23,'FontWeight','bold');
        ylabel('Activation','FontSize',23,'FontWeight','bold');
        set(gca,'Position',[left3 bottom3 width heigth]);

    ax4=subplot(2,2,4); hold on; grid on;
        for i=1:2
            plot(dump.raw.guiHR.ts,dump.raw.guiHR.txl(:,i),'Color',randColors(i+9,:),'LineWidth',1);
        end
        plot(dump.raw.guiHR.ts,dump.raw.guiHR.txl(:,3),'Color',randColors(3+9,:),'LineWidth',3);
        plot([0 dump.ts(end)],[100 100],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([15.44 15.44],[0 276],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);
        plot([28.57 28.57],[0 276],'LineStyle','--','LineWidth',1,'Color',[0.3 0.3 0.3]);

        l2=legend('PR1','PR2','PR3');
        set(l2,'XColor',[1 1 1],'YColor',[1 1 1])
        set(l2,'Position', [0.93 0.46 0.05 0.1],'Units','normalized');
        set(l2,'FontSize',17);
        axis([14 34 4 276]);
        set(gca,'XTick',[15.44,20,25,28.57,30],'XTickLabel',{'15.4','20','25','28.6','30'},'FontSize',17);
        set(gca,'YTick',[4,100,122.5,255],'YTickLabel',{'0','0.4','0.5','1'});
        xlabel('Time [s]','FontSize',23,'FontWeight','bold');
        ylabel('Activation','FontSize',23,'FontWeight','bold');
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

    export_fig(gcf,'Fig8.png','-png');
    export_fig(gcf,'Fig8.eps','-eps');

end
