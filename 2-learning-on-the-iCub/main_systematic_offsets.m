%%
 % Copyright (C) 2016 iCub Facility, Italian Institute of Technology
 % Author: Alessandro Roncone
 % email:  alessandro.roncone@yale.edu
 % website: www.icub.org
 % Permission is granted to copy, distribute, and/or modify this program
 % under the terms of the GNU General Public License, version 3 or any
 % later version published by the Free Software Foundation.
 %
 % This program is distributed in the hope that it will be useful, but
 % WITHOUT ANY WARRANTY; without even the implied warranty of
 % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
 % Public License for more details
%%

addpath('../0-utils/');
addpath('../0-utils/export_fig');

if ~exist(fullfile(cd,'systematic_offsets.mat'),'file')
    error('main_taxelsCalibration::varChk','Please specify a .mat file to load data from!');
else
    disp(sprintf('Loading data from %s...',fullfile(cd,'systematic_offsets.mat')));
    load('systematic_offsets.mat')
end

% caliO is the offset
% caliL is the body part (limb)

%% PRINT THE OFFSETS

for j = 1:length(data)
    disp(data{j}.protocol);
    for i = 1:length(data{j}.taxels)
        disp(['    Taxel #',num2str(i),': ',num2str(data{j}.taxels(i).cali)]);
    end
end

%% PLOT THE OFFSETS
figure('Position', [200 400 600 500], 'Color', 'w');

blue = [0.3725    0.6314    0.9431];
red  = [0.7333    0.0510    0.2118];

grid on; hold on;

avg = [mean(caliO(find(caliL==1))),mean(caliO(find(caliL==2))),mean(caliO(find(caliL==3)))];
std = [std(caliO(find(caliL==1))),std(caliO(find(caliL==2))),std(caliO(find(caliL==3)))];

h = errorbar([1 2 3],avg,std,'LineWidth',2,'Color',blue);
plot    ([1 2 3],avg,'.','Color',blue,'MarkerSize',35,'LineWidth',2);
scatter(caliL, caliO,[ ], red,'d','filled','SizeData', 100);

set(gca,'YTick',[-0.01,0.0,0.01,0.02,0.03,0.035], ...
        'XTick',[1,2,3,4], 'FontSize',16);
set(gca,'YTickLabel',{'','0','0.01','0.02','0.03',''}, ...
        'XTickLabel',{'FALi','FALo','PR',''}, 'FontSize',16);

xlabel('Body Part','FontSize',20,'FontWeight','bold');
ylabel('Offset[m]','FontSize',20,'FontWeight','bold');
axis([0 4 -0.005 0.035]);

export_fig(gcf,'Fig8','-png','-eps');

clearvars -except data caliO caliL
