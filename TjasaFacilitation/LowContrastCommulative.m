pcaLow=lowContrastPCA(lowContrast);
pcaHigh=lowContrastPCA(highContrast);
%% Separate ON and OFF
lowON=lowContrast(pcaLow.clsKmeans==1);
lowOFF=lowContrast(pcaLow.clsKmeans==2);
highON=highContrast(pcaHigh.clsKmeans==1);
highOFF=highContrast(pcaHigh.clsKmeans==2);
type1=lowOFF;
type2=highOFF;
%% find modulations
% cmap=[255,198,30;175,88,186;0,205,108]./255;
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
[RMIlow, RMIrandomLow, pdLow]=calculateRMI(type1,lowParams,1);
[RMIhigh, RMIrandomHigh, pdHigh]=calculateRMI(type2,lowParams,1);
RMIrandom=[RMIrandomHigh;RMIrandomLow];
cLow=sort(RMIlow);
listLow=linspace(1,100,length(RMIlow));
cHigh=sort(RMIhigh);
listHigh=linspace(1,100,length(RMIhigh));
cRandom=sort(RMIrandom);
listRandom=linspace(1,100,length(RMIrandom));
pd=fitdist(RMIrandom,'Normal');
lowEdge=pd.mu-2*pd.sigma;
highEdge=pd.mu+2*pd.sigma;
figure('Color','w','Position',[100,100,300,200]);
scatter(cLow,listLow',10,'filled','MarkerFaceColor',colorBlue)
hold on
scatter(cHigh,listHigh',10,'filled','MarkerFaceColor',colorRed)
scatter(cRandom,listRandom',10,'filled','MarkerFaceColor',[0.4,0.4,0.4])
xline(highEdge,'--k')
xline(0)
xline(lowEdge,'--k')
xlim([-0.5,0.7])
xlabel('RMI')
ylabel('Comulative percentage')
yticks([0,25,50,75,100])