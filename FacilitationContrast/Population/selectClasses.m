cmap=[255,198,30;175,88,186;0,205,108]./255;
pcall1=lowContrastPCA(LightLevel1,2);
pcall2=lowContrastPCA(LightLevel2,2);
pcall3=lowContrastPCA(LightLevel3,2);
pcall4=lowContrastPCA(LightLevel4,2);
pcall5=lowContrastPCA(LightLevel5,2);
for i=1:3
    figure('Color','w','Position',[100,100,600,200])
    class1=LightLevel1(pcall1.clsKmeans==i);
    class2=LightLevel2(pcall2.clsKmeans==i);
    class3=LightLevel3(pcall3.clsKmeans==i);
    class4=LightLevel4(pcall4.clsKmeans==i);
    class5=LightLevel5(pcall5.clsKmeans==i);
    tiledlayout(1,5)
    nexttile
    populationResponse(class1,flashParams5,cmap,[1:3],0.05,1.5);
    nexttile
    populationResponse(class2,flashParams5,cmap,[1:3],0.05,1.5);
    nexttile
    populationResponse(class3,flashParams5,cmap,[1:3],0.05,1.5);
    nexttile
    populationResponse(class4,flashParams5,cmap,[1:3],0.05,1.5);
    nexttile
    populationResponse(class5,flashParams5,cmap,[1:3],0.05,1.5);
end
OFF_LL1=LightLevel1(pcall1.clsKmeans==1);
OFF_LL2=LightLevel2(pcall2.clsKmeans==2);
OFF_LL3=LightLevel3(pcall3.clsKmeans==2);
OFF_LL4=LightLevel4(pcall4.clsKmeans==2);
OFF_LL5=LightLevel5(pcall5.clsKmeans==2);

% OFF2_LL1=[LightLevel1(pcall1.clsKmeans==2)]%;LightLevel1(pcall1.clsKmeans==1)];
% OFF2_LL2=LightLevel2(pcall2.clsKmeans==3);
% OFF2_LL3=LightLevel3(pcall3.clsKmeans==1);
% OFF2_LL4=LightLevel4(pcall4.clsKmeans==2);
% OFF2_LL5=LightLevel5(pcall5.clsKmeans==3);
%%
figure('Color','w','Position',[100,100,600,200])
tiledlayout(1,5)
nexttile
populationResponse(OFF_LL1,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF_LL2,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF_LL3,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF_LL4,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF_LL5,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
figure('Color','w','Position',[100,100,600,200])
tiledlayout(1,5)
nexttile
populationResponse(OFF2_LL1,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF2_LL2,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF2_LL3,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF2_LL4,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])
nexttile
populationResponse(OFF2_LL5,flashParams5,cmap,[1:2],0.05,1.5);
ylim([-0.5,1.8])