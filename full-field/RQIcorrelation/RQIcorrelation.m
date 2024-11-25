% color
cmap=[255,198,30;175,88,186;0,205,108;255,198,30;175,88,186]./255;
cmapDark=cmap*0.8;
ft = fittype( 'poly1' );
% RQIs
class=find(pca.clsKmeans==1);
classROI=allTogether(class,:);
[~,ipsiResponding,RQIipsi]=findIpsiZscore(classROI,3,0.3);
[contraDuringResponding,RQIcontra]=findDuring(classROI,0.3,2);
[contraAfterResponding,RQIcontraAfter]=findAfter(classROI,0.3,2);
% Test for notmality: k-s test: Not normal, can't use Pearson, use Spearman
[a,b]=corr(RQIcontra',RQIipsi','type','Spearman')
[c,d]=corr(RQIcontraAfter',RQIipsi','type','Spearman')
figure()
tiledlayout(1,2)
nexttile()
[fitresult, gof] = fit( RQIipsi', RQIcontra', ft );
plot(fitresult,RQIipsi, RQIcontra)
nexttile()
[fitresult, gof] = fit( RQIipsi', RQIcontraAfter', ft );
plot(fitresult,RQIipsi, RQIcontraAfter)