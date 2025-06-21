function [swingPhaseData, p, f, explainedVar, unexplainedVar] = doSwingPhaseAnova(A, B, C)
    samplingFreq = 250;
    timeVector = linspace(0, 1, samplingFreq); % 1sec = 250 points | also equivalent to normalized time

    swingPhaseData = zeros(20, 3);

    for subjectId = 1:20
        % load subject data
        subjectData.A = load(A(subjectId)).y;
        subjectData.B = load(B(subjectId)).y;
        subjectData.C = load(C(subjectId)).y;

        timeIndexedA = sum(~isnan(subjectData.A'));
        timeVectorA = timeIndexedA/samplingFreq;
        meanTimeA = mean(timeVectorA);

        timeIndexedB = sum(~isnan(subjectData.B'));
        timeVectorB = timeIndexedB/samplingFreq;
        meanTimeB = mean(timeVectorB);

        timeIndexedC = sum(~isnan(subjectData.C'));
        timeVectorC = timeIndexedC/samplingFreq;
        meanTimeC = mean(timeVectorC);

        swingPhaseData(subjectId, 1) = meanTimeA;
        swingPhaseData(subjectId, 2) = meanTimeB;
        swingPhaseData(subjectId, 3) = meanTimeC;
    end
    [p, tbl, stats] = anova1(swingPhaseData, [], "off");
    f = tbl(2, 5);
    explainedVar = tbl(2, 2);
    unexplainedVar = tbl(3, 2);
end