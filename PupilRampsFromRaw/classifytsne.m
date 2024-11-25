classdef classifytsne
    properties
        tsneMatrix
        kmeanscls
        gmcls
        linkagecls
        clsnumKmeans
        clsnumGM
        clsnumLinkage
        classPlot
    end
    methods
        function obj=classifytsne(ROIlist,flashParams,varargin)
            obj.tsneMatrix=obj.calculateTsne(ROIlist,flashParams);
            [obj.kmeanscls,obj.clsnumKmeans,obj.gmcls,obj.clsnumGM, obj.linkagecls, obj.clsnumLinkage]=obj.classify(varargin);
            obj.classPlot=obj.plotClasses();
        end
        function tsneMatrix=calculateTsne(~,ROIlist,flashParams)
            for i=1:length(ROIlist)
                meanFlash(i,:)=ROIlist(i).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,2);
            end
            difference=normalize(meanFlash,2);
            rng(0);tsneMatrix=tsne(difference,'Distance','cosine','NumPCAComponents',50,'Standardize',1,'Theta',0.1);
        end
        function [kmeanscls,clsnumKmeans,gmcls,clsnumGM,linkagecls,clsnumLinkage]=classify(obj,varargin)
           if isempty(varargin{1})
               rng(0);eval=evalclusters(obj.tsneMatrix,'kmeans','silhouette','klist',1:30);
               clsnumKmeans=eval.OptimalK;
               rng(0);eval=evalclusters(obj.tsneMatrix,'gmdistribution','silhouette','klist',1:30);
               clsnumGM=eval.OptimalK;
               rng(0);eval=evalclusters(obj.tsneMatrix,'linkage','silhouette','klist',1:30);
               clsnumLinkage=eval.OptimalK;
           else
               clsnumKmeans=varargin{1}{1};
               clsnumGM=varargin{1}{1};
               clsnumLinkage=varargin{1}{1};
           end
           rng(0);kmeanscls=kmeans(obj.tsneMatrix,clsnumKmeans,'Replicates',5,'Start','cluster');
           options = statset('Display','final'); 
           rng(0);gm = fitgmdist(obj.tsneMatrix,clsnumGM,'Replicates',10,'Options',options); 
           gmcls = cluster(gm,obj.tsneMatrix);
           rng(0);linkagecls=clusterdata(obj.tsneMatrix,'linkage','ward',clsnumLinkage);
        end
        function classPlot=plotClasses(obj)
            color={[0.8350 0.0780 0.1840],[0.3010 0.7450 0.9330],[0.4660 0.6740 0.1880],[0.5940 0.1840 0.6560],[0.9290 0.6940 0.1250],[0.8500 0.3250 0.0980],[0 0.4470 0.7410],[1 1 0],[0 1 1],[0.8 0 1],[0.254,0.569,0.588],[0.488,0.894,0.125],[0.894,0.255,0.148],[0.314,0.889,0.658]};
            classPlot=figure('Color','w','Position',[100,100,900,300]);
            sz=25;
            subplot(1,3,1)
            for class=1:obj.clsnumKmeans
                cls=find(obj.kmeanscls==class);
                subtsne=obj.tsneMatrix(cls,:);
                scatter(subtsne(:,1),subtsne(:,2),sz,color{class},'filled','MarkerFaceAlpha',0.3)
                hold on
            end
            xticklabels('')
            yticklabels('')
            T=['K means clustering, n= ',num2str(obj.clsnumKmeans)];
            title(T)
            subplot(1,3,2)
            for class=1:obj.clsnumGM
                cls=find(obj.gmcls==class);
                subtsne=obj.tsneMatrix(cls,:);
                scatter(subtsne(:,1),subtsne(:,2),sz,color{class},'filled','MarkerFaceAlpha',0.3)
                hold on
            end
            xticklabels('')
            yticklabels('')
            T=['GM clustering, n= ',num2str(obj.clsnumGM)];
            title(T)
            subplot(1,3,3)
            for class=1:obj.clsnumLinkage
                cls=find(obj.linkagecls==class);
                subtsne=obj.tsneMatrix(cls,:);
                scatter(subtsne(:,1),subtsne(:,2),sz,color{class},'filled','MarkerFaceAlpha',0.3)
                hold on
            end
            xticklabels('')
            yticklabels('')
            T=['Linkage clustering, n= ',num2str(obj.clsnumLinkage)];
            title(T)
        end
    end
end