function [RMIrandom, edge]=findRandomRMI(allROI,l,repeats)
    RMIrandom=zeros(length(allROI),1);
    for roi=1:length(allROI)
        area1list=zeros(1,repeats);
        area2list=zeros(1,repeats);
        c1_mix=zeros(size(allROI(roi).allSlow(l,:,2)));
        c2_mix=zeros(size(allROI(roi).allSlow(l,:,2)));
        for repeat=1:repeats
            c1_index=randi(5,[1,5]);
            c2_index=randi(5,[1,5]);
            for flash=1:5
                c1_mix(:,flash)=allROI(roi).allSlow(l,c1_index(flash),3);
                c2_mix(:,flash)=allROI(roi).allSlow(l,c2_index(flash),3);
            end
            c1_mean=mean(c1_mix,2);
            c2_mean=mean(c2_mix,2);
            area1list(repeat)=trapz(abs(c1_mean));
            area2list(repeat)=trapz(abs(c2_mean));
        end
        area1=mean(area1list);
        area2=mean(area2list);
        RMIrandom(roi)=(area1-area2)/(area1+area2);
    end
    pd=fitdist(RMIrandom,'Normal');
    edge=pd.mu+2*pd.sigma;
end