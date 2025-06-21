function [maxKneeAngleData, h, p, t] = doMaxKneeTtest(condition1, condition2, A, B, C)
    samplingFreq = 250;
    timeVector = linspace(0, 1, samplingFreq); % 1sec = 250 points | also equivalent to normalized time

    maxKneeAngleData = zeros(20, 2);

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
        
        switch condition1
            case 1
                 meanSubjectDataFirst = mean(subjectData.A, 1);
            case 2
                 meanSubjectDataFirst = mean(subjectData.B, 1);
            otherwise
                 meanSubjectDataFirst = mean(subjectData.C, 1);
        end
        switch condition2
            case 1
                meanSubjectDataSecond = mean(subjectData.A, 1);
            case 2
                meanSubjectDataSecond = mean(subjectData.B, 1);
            case 3
                meanSubjectDataSecond = mean(subjectData.C, 1);
        end
        

        maxKneeAngleData(subjectId, 1) = max(meanSubjectDataFirst);
        maxKneeAngleData(subjectId,2) = max(meanSubjectDataSecond);
    end

    [h, p, ci, stats] = ttest2(maxKneeAngleData(1:end, 1), maxKneeAngleData(1:end, 2));
    t = stats.tstat;
end