function responseFrameDifference=responseFdiff(response)
    responseFrameDifference=zeros(length(response),size(response(1).mean_flash,1));
    for i=1:length(responseFrameDifference)
        responseFrameDifference(i,:)=smoothdata(response(i).mean_flash(:,1))-smoothdata(response(i).mean_flash(:,2));
    end