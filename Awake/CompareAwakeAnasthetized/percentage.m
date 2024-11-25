%Anasthetized classes: 1=OFF 2=ON
%Awake classes: 1=ON 2=OFF
pcaAnasthetized=lowContrastPCA(anasthetized);
pcaAwake=lowContrastPCA(awake);
%% Anasthetized
[~,ipsiAnasthetized]=findIpsiZscore(anasthetized,3,0.3);
OFF=[1:1232];%find(pcaAnasthetized.clsKmeans==1);
location=1:10;
animal=[1,1,1,2,2,3,3,4,5,5];
NumIpsiAnasthetized=zeros(1,10);
OFFlocAnasthetized=zeros(1,10);
count=0;
before=0;
for i=1:10
roi=before+1:before+anasthetizedNum(i);
off_temp=intersect(roi,OFF);
OFFlocAnasthetized(i)=length(off_temp);
offIpsi=intersect(off_temp,ipsiAnasthetized);
    if ~isempty(offIpsi)
        NumIpsiAnasthetized(i)=length(offIpsi);
    end
before=before+length(roi);
end
offIpsi_percentage=NumIpsiAnasthetized*100./OFFlocAnasthetized;
% Per animal
NumAnimalAnasthetized=zeros(1,5);
NumIpsiAnimalAnasthetized=zeros(1,5);
for i=1:5
   a=find(animal==i);
   NumIpsiAnimalAnasthetized(i)=sum(NumIpsiAnasthetized(a));
   NumAnimalAnasthetized(i)=sum(OFFlocAnasthetized(a));
end
PercentIpsiAnimalAnasthetized=NumIpsiAnimalAnasthetized*100./NumAnimalAnasthetized;
PercentageAnasthetized=sum(NumIpsiAnasthetized)*100./sum(OFFlocAnasthetized);
%% Awake 
[~,ipsiAwake]=findIpsiZscore(awake,3,0.3);
OFF=[1:1402];%find(pcaAwake.clsKmeans==1);
location=1:4;
animal=[1,2,3,4];
NumIpsiAwake=zeros(1,4);
OFFlocAwake=zeros(1,4);
count=0;
before=0;
for i=1:4
roi=before+1:before+awakeNum(i);
off_temp=intersect(roi,OFF);
OFFlocAwake(i)=length(off_temp);
offIpsi=intersect(off_temp,ipsiAwake);
    if ~isempty(offIpsi)
        NumIpsiAwake(i)=length(offIpsi);
    end
before=before+length(roi);
end
offIpsi_percentage=NumIpsiAwake*100./OFFlocAwake;