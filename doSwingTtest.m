function [swingPhaseData, h, p, t] = doSwingTtest(condition1, condition2, A, B, C)
    samplingFreq = 250;
    timeVector = linspace(0, 1, samplingFreq); % 1sec = 250 points | also equivalent to normalized time

    swingPhaseData = zeros(20, 2);
    swingPhasePerc = 0.4;

    for subjectId = 1:20
        % load subject data
        subjectData.A = load(A(subjectId)).y;
        subjectData.B = load(B(subjectId)).y;
        subjectData.C = load(C(subjectId)).y;

        timeIndexedA = sum(~isnan(subjectData.A'));
        timeVectorA = timeIndexedA/samplingFreq;
        swingPhaseTime = timeVectorA * swingPhasePerc;
        meanTimeA = mean(swingPhaseTime);

        timeIndexedB = sum(~isnan(subjectData.B'));
        timeVectorB = timeIndexedB/samplingFreq;
        swingPhaseTime = timeVectorB * swingPhasePerc;
        meanTimeB = mean(swingPhaseTime);

        timeIndexedC = sum(~isnan(subjectData.C'));
        timeVectorC = timeIndexedC/samplingFreq;
        swingPhaseTime = timeVectorC * swingPhasePerc;
        meanTimeC = mean(swingPhaseTime);

        switch condition1
            case 1
                swingPhaseData(subjectId, 1) = meanTimeA;
            case 2
                swingPhaseData(subjectId, 1) = meanTimeB;
            otherwise
                swingPhaseData(subjectId, 1) = meanTimeC;
        end

        switch condition2
            case 1
                swingPhaseData(subjectId, 2) = meanTimeA;
            case 2
                swingPhaseData(subjectId, 2) = meanTimeB;
            otherwise
                swingPhaseData(subjectId, 2) = meanTimeC;
        end
    end

    [h, p, ci, stats] = ttest2(swingPhaseData(1:end, 1), swingPhaseData(1:end, 2));
    t = stats.tstat;
end