% FOV from 2022_12_02_TL_OBO030701_8fRandomizedSet-- FOV number 6
ROIanimal=[(sum(num(1:5))+1:sum(num(1:6)))];
allROI_FOV=allROI(ROIanimal);
classes=chirpClass.linkagecls(ROIanimal);
ipsiType=zeros(1,length(ROIanimal));
count=0;
for roi=ROIanimal
    count=count+1;
    if  ismember(roi,RQIipsi)
       [~,loc]=ismember(roi,RQIipsi);
       ipsiType(count)=chirpIpsi.clsKmeans(loc);
    end
end
%% AllClasses
contours=figure('Color',[1,1,1],'Units','centimeters','Position',[5,5,18,14],'Visible','on');
%color=crameri('hawaii',6);
%color=[68,119,170;102,204,238;34,136,51;204,187,68;204,100,119]./255;
colorSet=[0,101,146;0,154,222;44,255,215;210,0,56;255,109,148]./255;%[68,119,170;102,204,238;34,136,51;204,187,68;170,51,119]./255;
p=colorSet*0.9;
color=0.1+p;
for c=1:8
    class=find(classes==c);
    for ROI = class'
        x=statsIsCell{ROI}.xpix;
        y=statsIsCell{ROI}.ypix;
        sz=8;
        p=scatter(x,y,sz,color(c,:),'.');
        hold on
        set(gca,'visible','off')
        set(gcf, 'InvertHardcopy', 'off');
        caxis([-0.6,0.6]);
        set(findall(gca, 'type', 'text'), 'visible', 'on')
    end
end
%% Ipsi type
contours=figure('Color',[1 1 1],'Units','centimeters','Position',[5,5,18,14],'Visible','on');
color=[180,180,180;0,146,45;255,193,110]./255;
for c=0:3
    class=find(ipsiType==c);
    for ROI = class
        x=statsIsCell{ROI}.xpix;
        y=statsIsCell{ROI}.ypix;
        sz=8;
        p=scatter(x,y,sz,color(c+1,:),'.');
        hold on
        set(gca,'visible','off')
        set(gcf, 'InvertHardcopy', 'off');
        caxis([-0.6,0.6]);
        set(findall(gca, 'type', 'text'), 'visible', 'on')
    end
end