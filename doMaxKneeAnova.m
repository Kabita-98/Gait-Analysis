function [maxKneeAngleData, p, f, explainedVar, unexplainedVar] = doMaxKneeAnova(A, B, C)
    samplingFreq = 250;
    timeVector = linspace(0, 1, samplingFreq); % 1sec = 250 points | also equivalent to normalized time

    maxKneeAngleData = zeros(20, 3);

    for subjectId = 1:20
        % load subject data
        subjectData.A = load(A(subjectId)).y;
        subjectData.B = load(B(subjectId)).y;
        subjectData.C = load(C(subjectId)).y;

        subjectData = doDataRectification(subjectData);
    
        windowSize = 20;
        subjectData = doDataSmoothing(windowSize, subjectData);

        subjectData = doTemporalNormalization(samplingFreq, subjectData);
        
        subjectData = doDataSynchronisation(samplingFreq, subjectData);

        meanSubjectDataA = mean(subjectData.A, 1);
        meanSubjectDataB = mean(subjectData.B, 1);
        meanSubjectDataC = mean(subjectData.C, 1);

        maxKneeAngleData(subjectId, 1) = max(meanSubjectDataA);
        maxKneeAngleData(subjectId, 2) = max(meanSubjectDataB);
        maxKneeAngleData(subjectId, 3) = max(meanSubjectDataC);
    end
    
    [p, tbl, stats] = anova1(maxKneeAngleData, [], "off");
    f = tbl(2, 5);
    explainedVar = tbl(2, 2);
    unexplainedVar = tbl(3, 2);
end