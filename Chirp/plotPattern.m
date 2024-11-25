function plotPattern(old) 
    if old==1
        len=854;
        greenLoc=[2516 2696 2696 2516];
        blueLoc=[2816 2996 2996 2816];
    else
        len=540;
        greenLoc=[2156 2326 2326 2156];
        blueLoc=[2456 2636 2636 2456];
    end
    times = linspace(0, 6, len);  
    intensity= chirp(times, 0.5, 6, 8,'linear');
    scale=times/8;
    scaledIntensity=[];
    for i =1:length(times)
        intensities=sin(12*times(i));
        scaledIntensity=[scaledIntensity,intensities*scale(i)];
    end
    before=zeros(1,116);%(1,600);%116
    after=zeros(1,484);%(1,600);
    b1=-1*ones(1,120);
    b2=-1*ones(1,180);
    w= ones(1,180);
    c=zeros(1,180);
    g=zeros(1,120);
    fullTrace=[before,b1,w,b2,g,intensity,g,scaledIntensity,g,b1,c,b1,c,b1,after];
    patchy= [-1 -1 1 1];
    plot(fullTrace,'color', [0.3,0.3,0.3])
    patch(greenLoc,patchy,[0.6,0.85,0.6],'EdgeColor','None')
    patch(blueLoc,patchy,[0.6,0.6,0.85],'EdgeColor','None')
    xlim([0,length(fullTrace)])
    xticks([])
    ylim([-1.5 1.5])
    yticks([-1 0 1])
    yticklabels({''})%({'black','gray','white'})
    box off
    ax = gca;
    ax.FontSize = 7;
end