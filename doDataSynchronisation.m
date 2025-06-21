function synchronisedData = doDataSynchronisation(samplingFreq, data)
    normalizedTime = linspace(0, 1, samplingFreq);   

   
    subjectDataList = {data.A, data.B, data.C};
    
    for i = 1:3
        currentData = subjectDataList(i);
        currentData = currentData{1};
        [~, maxLoc] = max(currentData, [], 2);
        [referenceIdxVal, ~] = max(maxLoc);
        synchronisedSubjectData = zeros(30, 250);

        for j=1:30
            shift = referenceIdxVal - maxLoc(j, 1);
            if shift > 0
                synchronisedSubjectData(j, shift:end) = currentData(j, 1:(length(currentData)-shift+1));
                synchronisedSubjectData(j, :) = interp1(normalizedTime(shift:end),synchronisedSubjectData(j, shift:end), normalizedTime);
            else
                synchronisedSubjectData(j, :) = currentData(j, :);
            end
        end

        if i == 1
            synchronisedData.A = synchronisedSubjectData;
        elseif i == 2
            synchronisedData.B = synchronisedSubjectData;
        else
            synchronisedData.C = synchronisedSubjectData;
        end
    end     
end