cmap=[255,198,30;175,88,186;0,205,108]./255;
LLs={responsesLL1,responsesLL2,responsesLL3,responsesLL4,responsesLL5};
fps={flashParams2,flashParams2,flashParams2,flashParams2,flashParams2};
figure('Color','w','Position',[100,100,500,250])
tiledlayout(1,5,"TileSpacing","compact","Padding","compact")
titles={'12 lux','20 lux','31 lux','44 lux','65 lux'};
 for t=10
    figure('Color','w','Position',[100,100,500,250])
    tiledlayout(1,5,"TileSpacing","compact","Padding","compact")
    titles={'12 lux','20 lux','31 lux','44 lux','65 lux'};
    for i=1:5
        nexttile
        classROI=LLs{i}(allOFFcontrol{i},:);
        populationResponse(classROI,fps{i},cmap,[1:2],0.05,1.5);
        xticks([0,5])
        yticks([0,0.5,1]) 
        title(titles{i})
        if i~=1
            ylabel('')
            xlabel('')

        end
%         axis off
    end
 end
