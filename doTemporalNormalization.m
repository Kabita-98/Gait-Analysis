function temporalNormalizedData = doTemporalNormalization(samplingFreq, subjectData)  
    normalizedTime = linspace(0, 1, samplingFreq);
    
    for i=1:3 % to iterate over condition
        if i == 1
            currentData = subjectData.A;
        elseif i == 2
            currentData = subjectData.B;
        else
            currentData = subjectData.C;
        end
        normalizedData = zeros(30, length(normalizedTime));
        
        for j=1:30 %to iterate over trials
            trialData = currentData(j, :);
            validLength = sum(~isnan(trialData));
            localizedNormalizedTime = linspace(0, 1, validLength);
            normalizedData(j, :) = interp1(localizedNormalizedTime, trialData(1, 1:validLength), normalizedTime);
        end

        if i == 1
            temporalNormalizedData.A = normalizedData;
        elseif i == 2
            temporalNormalizedData.B = normalizedData;
        else
            temporalNormalizedData.C = normalizedData;
        end
    end
end