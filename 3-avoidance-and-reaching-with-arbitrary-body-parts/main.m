% clearvars -except filenames curFile evnts;
addpath('../0-utils');
addpath('../0-utils/export_fig');

if ~exist(fullfile(cd,'data.mat'),'file')

    %% HARD CODE THE PATHS FOR THE DUMPS
        dump1.filename.avDump = './avoidance_20141205/data1/avoidance_dumper/data.log';
        dump1.filename.dump   = './avoidance_20141205/data1/dumper/data.log';
        dump1.filename.guiFAL = './avoidance_20141205/data1/skinGui_leftForearm_dumper/data.log';
        dump1.filename.guiHR  = './avoidance_20141205/data1/skinGui_rightHand_dumper/data.log';

        dump2.filename.avDump = './avoidance_20141205/data2/avoidance_dumper/data.log';
        dump2.filename.dump   = './avoidance_20141205/data2/dumper/data.log';
        dump2.filename.guiFAL = './avoidance_20141205/data2/skinGui_leftForearm_dumper/data.log';
        dump2.filename.guiHR  = './avoidance_20141205/data2/skinGui_rightHand_dumper/data.log';

        dump3.filename.avDump = './avoidance_20141205/data3/avoidance_dumper/data.log';
        dump3.filename.dump   = './avoidance_20141205/data3/dumper/data.log';
        dump3.filename.guiFAL = './avoidance_20141205/data3/skinGui_leftForearm_dumper/data.log';
        dump3.filename.guiHR  = './avoidance_20141205/data3/skinGui_rightHand_dumper/data.log';

        dump4.filename.avDump = './avoidance_20141205/data4/avoidance_dumper/data.log';
        dump4.filename.dump   = './avoidance_20141205/data4/dumper/data.log';
        dump4.filename.guiFAL = './avoidance_20141205/data4/skinGui_leftForearm_dumper/data.log';
        dump4.filename.guiHR  = './avoidance_20141205/data4/skinGui_rightHand_dumper/data.log';
        dump4.filename.velAL  = './avoidance_20141205/data4/vel_leftArm/data.log';
        dump4.filename.velAR  = './avoidance_20141205/data4/vel_rightArm/data.log';

        dump5.filename.avDump = './catching_20141211/data1/avoidance_dumper/data.log';
        dump5.filename.dump   = './catching_20141211/data1/dumper/data.log';
        dump5.filename.guiFAL = './catching_20141211/data1/skinGui_leftForearm_dumper/data.log';
        dump5.filename.guiHR  = './catching_20141211/data1/skinGui_rightHand_dumper/data.log';
        dump5.filename.realguiFAL = './catching_20141211/data1/skin_tactile_comp_left_forearm/data.log';
        dump5.filename.velAL  = './catching_20141211/data1/vel_leftArm/data.log';

        dump6.filename.avDump = './catching_20141211/data2/avoidance_dumper/data.log';
        dump6.filename.dump   = './catching_20141211/data2/dumper/data.log';
        dump6.filename.guiFAL = './catching_20141211/data2/skinGui_leftForearm_dumper/data.log';
        dump6.filename.guiHR  = './catching_20141211/data2/skinGui_rightHand_dumper/data.log';

    %% IMPORT THE DATA
        disp('Importing the data..');

        disp('  Importing from dump1..');
        dump1 = importDump(dump1);

        disp('  Importing from dump2..');
        dump2 = importDump(dump2);

        disp('  Importing from dump3..');
        dump3 = importDump(dump3);

        disp('  Importing from dump4..');
        dump4 = importDump(dump4);

        disp('  Importing from dump5..');
        dump5 = importDump(dump5);

        disp('  Importing from dump6..');
        dump6 = importDump(dump6);

        disp('Done.');    

    %% SAVING THE DATA
        clear curFiles f;
        save('data.mat','dump1','dump2','dump3','dump4','dump5','dump6');
        % save('data.mat','dump1');
else
    disp(sprintf('Loading data from %s...',fullfile(cd,'data.mat')));
    load('data.mat')
end
        
%% PLOT THE MEANINGFUL RESPONSES
    disp(sprintf('Displaying stuff...'));

    % dump1=plotData(dump1);
    % dump2=plotData(dump2);
    % dump3=plotData(dump3);
    dump4=plotData_avoidance(dump4);
    dump5=plotData_catching(dump5);
    % dump6=plotData(dump6);

    disp('Done.');
    disp('DONE.');
