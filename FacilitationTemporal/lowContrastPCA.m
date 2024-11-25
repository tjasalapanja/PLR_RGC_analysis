classdef lowContrastPCA
    properties
        D_PCA
        clsKmeans
        clsGM
        clusterNumber
        Ckmeans
        percentage
    end
    methods
        function obj=lowContrastPCA(ROIlist,varargin)
            [obj.D_PCA,obj.percentage]=obj.calculatePCA(ROIlist,varargin);
            [obj.clsKmeans,obj.clsGM,obj.clusterNumber,obj.Ckmeans]=obj.classify(varargin);
        end
        function [D_PCA,percentage]=calculatePCA(~,ROIlist,varargin)
            if ~isempty(varargin) 
                if size(varargin{1},2)==2
                    beforeLength=varargin{1}(2);
                else
                    beforeLength=25;
                end
            else
                beforeLength=25;
            end
            mean_flash=zeros(length(ROIlist),size(ROIlist(1).meanSlow,1)-beforeLength);
            for i=1:length(ROIlist)
                mean_flash(i,:)=ROIlist(i).meanSlow(beforeLength+1:end,2);
            end
            difference=smoothdata(normalize((mean_flash),2),5);
            [~,D_PCA,eigval]=pca(difference);
            csum=cumsum(eigval);
            percentage=100*csum/csum(end);
        end
        function [clsKmeans,clsGM,clusterNumber,Ckmeans]=classify(obj,varargin)
            if isempty(varargin{1})
                rng(0);eval=evalclusters(obj.D_PCA(:,1:5),'kmeans','silhouette','klist',1:30);
                clusterNumber=eval.OptimalK;
            else
                clusterNumber=varargin{1}{1};
            end
            rng(0);[clsKmeans,Ckmeans]=kmeans(obj.D_PCA(:,1:4),clusterNumber,'Replicates',5,'Start','cluster');
            options = statset('Display','final'); 
            rng(0);gm = fitgmdist(obj.D_PCA(:,1:3),clusterNumber,'Replicates',10,'Options',options); 
            clsGM = cluster(gm,obj.D_PCA(:,1:3));
        end
    end
end