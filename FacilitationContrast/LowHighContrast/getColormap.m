function cmaps=getColormap(colors)
    cmaps=zeros(255,3);
    count=255;
    step=(255-colors)./255;
    for i=1:255
    cmaps(count,:)=colors;
    colors=colors+step;
    count=count-1;
    end
    cmaps=cmaps./255;
end