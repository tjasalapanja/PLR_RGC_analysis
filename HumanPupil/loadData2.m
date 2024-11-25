%% Human pupils
%  Load excel data
%  Stim frequency =20Hz
uiopen('Y:\Tjasa\Data_analysis\Paper\Figure4\Subject1\sin_2Hz.csv',1);
%%
subject1_2.meanPupil=sin2Hz.frq2_sin(1:183);
subject1_2.allPupil=zeros(6,183);
subject1_2.allPupil(1,:)=sin2Hz.Average_cleaned(1:183);
subject1_2.allPupil(2,:)=sin2Hz.Average_cleaned1(1:183);
subject1_2.allPupil(3,:)=sin2Hz.Average_cleaned2(1:183);
subject1_2.allPupil(4,:)=sin2Hz.Average_cleaned3(1:183);
subject1_2.allPupil(5,:)=sin2Hz.Average_cleaned4(1:183);
subject1_2.allPupil(6,:)=sin2Hz.Average_cleaned5(1:183);
%% 
uiopen('Y:\Tjasa\Data_analysis\Paper\Figure4\Subject2\sin_2Hz.csv',1);
%%
subject2_2.meanPupil=sin2Hz1.frq2_sin(1:183);
subject2_2.allPupil=zeros(6,183);
subject2_2.allPupil(1,:)=sin2Hz1.Average_cleaned(1:183);
subject2_2.allPupil(2,:)=sin2Hz1.Average_cleaned1(1:183);
subject2_2.allPupil(3,:)=sin2Hz1.Average_cleaned2(1:183);
subject2_2.allPupil(4,:)=sin2Hz1.Average_cleaned3(1:183);
subject2_2.allPupil(5,:)=sin2Hz1.Average_cleaned4(1:183);
subject2_2.allPupil(6,:)=sin2Hz1.Average_cleaned5(1:183);

%%
uiopen('Y:\Tjasa\Data_analysis\Paper\Figure4\Subject3\sin_2Hz.csv',1);
%%
subject3_2.meanPupil=sin2Hz2.frq2_sin(1:183);
subject3_2.allPupil=zeros(3,183);
subject3_2.allPupil(1,:)=sin2Hz2.Average_cleaned(1:183);
subject3_2.allPupil(2,:)=sin2Hz2.Average_cleaned1(1:183);
subject3_2.allPupil(3,:)=sin2Hz2.Average_cleaned2(1:183);
%% Get all together
allPupil2Human.meanAll=zeros(3,183);
allPupil2Human.allData=zeros(15,183);
allPupil2Human.sem=zeros(1,183);
allPupil2Human.mean=zeros(1,183);
allPupil2Human.meanAll(1,:)=subject1_2.meanPupil;
allPupil2Human.meanAll(2,:)=subject2_2.meanPupil;
allPupil2Human.meanAll(3,:)=subject3_2.meanPupil;
allPupil2Human.allData(1:6,:)=subject1_2.allPupil;
allPupil2Human.allData(7:12,:)=subject2_2.allPupil;
allPupil2Human.allData(13:15,:)=subject3_2.allPupil;
allPupil2Human.mean=mean(allPupil2Human.allData,'omitnan');
allPupil2Human.sem=std(allPupil2Human.allData,'omitnan')./sqrt(15);








