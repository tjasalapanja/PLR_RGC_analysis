function scaledIntensity=getPattern(lengths, hum)
    times = linspace(0, 6,lengths);  
    scale=times/2;
    scaledIntensity=[];
    for i =1:length(times)
        if hum==1
            intensities=-sin(12*times(i));
        else
            intensities=sin(12*times(i));
        end
        scaledIntensity=[scaledIntensity,intensities*scale(i)];
    end
end
