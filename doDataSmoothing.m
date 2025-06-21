function subjectData = doDataSmoothing(windowSize, subjectData)
    % smoothing for condition A: dataA = 30 X 250
    smoothingDataConditionA = zeros(30,250);
    smoothingDataConditionB = zeros(30,250);
    smoothingDataConditionC = zeros(30,250);

    for i=1:30            
        smoothingDataConditionA(i, :) = movmean(subjectData.A(i, :), windowSize, "omitnan");
        smoothingDataConditionB(i, :) = movmean(subjectData.B(i, :), windowSize, "omitnan");
        smoothingDataConditionC(i, :) = movmean(subjectData.C(i, :), windowSize, "omitnan");
    end

    subjectData.A = smoothingDataConditionA;
    subjectData.B = smoothingDataConditionB;
    subjectData.C = smoothingDataConditionC;
end