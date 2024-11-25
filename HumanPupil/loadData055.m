%% Human pupils
%  Load excel data
%  Stim frequency =20Hz
uiopen('Y:\Tjasa\Data_analysis\Paper\Figure4\Subject1\sin_0.55Hz.csv',1);
%%
subject1_055.meanPupil=sin0.frq0_55_sin(1:500);
subject1_055.allPupil=zeros(5,500);
subject1_055.allPupil(1,:)=sin0.Average_cleaned(1:500);
subject1_055.allPupil(2,:)=sin0.Average_cleaned1(1:500);
subject1_055.allPupil(3,:)=sin0.Average_cleaned2(1:500);
subject1_055.allPupil(4,:)=sin0.Average_cleaned3(1:500);
subject1_055.allPupil(5,:)=sin0.Average_cleaned4(1:500);
%% 
uiopen('Y:\Tjasa\Data_analysis\Paper\Figure4\Subject2\sin_0.55Hz.csv',1);
%%
subject2_055.meanPupil=sin1.frq0_55_sin(1:500);
subject2_055.allPupil=zeros(5,500);
subject2_055.allPupil(1,:)=sin1.Average_cleaned(1:500);
subject2_055.allPupil(2,:)=sin1.Average_cleaned1(1:500);
subject2_055.allPupil(3,:)=sin1.Average_cleaned2(1:500);
subject2_055.allPupil(4,:)=sin1.Average_cleaned3(1:500);
subject2_055.allPupil(5,:)=sin1.Average_cleaned4(1:500);
%%
uiopen('Y:\Tjasa\Data_analysis\Paper\Figure4\Subject3\sin_0.55Hz.csv',1);
%%
subject3_055.meanPupil=sin2.frq0_55_sin(1:500);
subject3_055.allPupil=zeros(4,500);
subject3_055.allPupil(1,:)=sin2.Average_cleaned(1:500);
subject3_055.allPupil(2,:)=sin2.Average_cleaned1(1:500);
subject3_055.allPupil(3,:)=sin2.Average_cleaned2(1:500);
subject3_055.allPupil(4,:)=sin2.Average_cleaned3(1:500);
%% Get all together
allPupil055Human.meanAll=zeros(3,500);
allPupil055Human.allData=zeros(14,500);
allPupil055Human.sem=zeros(1,500);
allPupil055Human.mean=zeros(1,500);
allPupil055Human.meanAll(1,:)=subject1_055.meanPupil;
allPupil055Human.meanAll(2,:)=subject2_055.meanPupil;
allPupil055Human.meanAll(3,:)=subject3_055.meanPupil;
allPupil055Human.allData(1:5,:)=subject1_055.allPupil;
allPupil055Human.allData(6:10,:)=subject2_055.allPupil;
allPupil055Human.allData(11:14,:)=subject3_055.allPupil;
allPupil055Human.mean=mean(allPupil055Human.allData,'omitnan');
allPupil055Human.sem=std(allPupil055Human.allData,'omitnan')./sqrt(14);








