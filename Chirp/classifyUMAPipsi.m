classdef classifyUMAPipsi
    properties
        UMAPmatrix
        kmeanscls
        gmcls
        linkagecls
        clsnumKmeans
        clsnumGM
        clsnumLinkage
        classPlot
    end
    methods
        function obj=classifyUMAPipsi(ROIlist,chirpParams,NumNeighbors,minDist,varargin)
            obj.UMAPmatrix=obj.UMAP(ROIlist,chirpParams,NumNeighbors,minDist);
            [obj.kmeanscls,obj.clsnumKmeans,obj.gmcls,obj.clsnumGM, obj.linkagecls, obj.clsnumLinkage]=obj.classify(varargin);
            obj.classPlot=obj.plotClasses();
        end
        function UMAPmatrix=UMAP(~,ROIlist,chirpParams,NumNeighbors,minDist)
            for i=1:length(ROIlist)
                meanChirp(i,:,:)=ROIlist(i).meanChirp(chirpParams.framesBeforeChirp+1:chirpParams.framesBeforeChirp+chirpParams.framesDuringChirp,3);%2= contra
            end
            difference=normalize(meanChirp,2);
            ParameterNames={};
            for i=1:size(difference,2)
                ParameterNames{i}=num2str(i);
            end
            rng(10);UMAPmatrix=run_umap(difference,'parameter_names',ParameterNames,'n_neighbors',NumNeighbors,'min_dist',minDist,'randomize','False');
        end
                function [kmeanscls,clsnumKmeans,gmcls,clsnumGM,linkagecls,clsnumLinkage]=classify(obj,varargin)
           if isempty(varargin{1})
               rng(0);eval=evalclusters(obj.UMAPmatrix,'kmeans','silhouette','klist',1:30);
               clsnumKmeans=eval.OptimalK;
               rng(0);eval=evalclusters(obj.UMAPmatrix,'gmdistribution','silhouette','klist',1:30);
               clsnumGM=eval.OptimalK;
               rng(0);eval=evalclusters(obj.UMAPmatrix,'linkage','silhouette','klist',1:30);
               clsnumLinkage=eval.OptimalK;
           else
               clsnumKmeans=varargin{1}{1};
               clsnumGM=varargin{1}{1};
               clsnumLinkage=varargin{1}{1};
           end
           rng(0);kmeanscls=kmeans(obj.UMAPmatrix,clsnumKmeans,'Replicates',5,'Start','cluster');
           options = statset('Display','final'); 
           rng(0);gm = fitgmdist(obj.UMAPmatrix,clsnumGM,'Replicates',10,'Options',options); 
           gmcls = cluster(gm,obj.UMAPmatrix);
           rng(0);linkagecls=clusterdata(obj.UMAPmatrix,'linkage','ward',clsnumLinkage);
        end
        function classPlot=plotClasses(obj)
            color=[0,101,146;0,154,222;44,255,215;210,0,56;255,109,148]./255;%[68,119,170;102,204,238;34,136,51;204,187,68;204,100,119]./255;%204,187 for red instead of 220 200
            %color=crameri('hawaii',6);
            classPlot=figure('Color','w','Position',[100,100,500,500]);
            sz=20;
            for class=1:obj.clsnumLinkage
                cls=find(obj.linkagecls==class);
                subtsne=obj.UMAPmatrix(cls,:);
                scatter(subtsne(:,1),subtsne(:,2),sz,color(class,:),'filled','MarkerFaceAlpha',0.3)
                hold on
            end
%             xticklabels('')
%             yticklabels('')
            xlabel('UMAP-x')
            ylabel('UMAP-y')
            xlim([-8,15])
            ylim([-15,8])
            ax=gca;
            ax.Color='w';
            ax.YColor = 'w';
            ax.XColor ='w';
%             T=['Linkage clustering, n= ',num2str(obj.clsnumLinkage)];
%             title(T)
        end
    end
end

