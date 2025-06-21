function preprocessConditionMean(displayPanel, displayPanelGrid, A, B, C)
    samplingFreq = 250;
    timeVector = linspace(0, 1, samplingFreq); % 1sec = 250 points | also equivalent to normalized time
    
    allSubjectsDataA = zeros(20, 250);
    allSubjectsDataB = zeros(20, 250);
    allSubjectsDataC = zeros(20, 250);
    for subjectId=1:20
        % load subject data
        subjectData.A = load(A(subjectId)).y;
        subjectData.B = load(B(subjectId)).y;
        subjectData.C = load(C(subjectId)).y;

        subjectData = doDataRectification(subjectData);
    
        windowSize = 20;
        subjectData = doDataSmoothing(windowSize, subjectData);
        
        subjectData = doTemporalNormalization(samplingFreq, subjectData);
        
        subjectData = doDataSynchronisation(samplingFreq, subjectData);

        allSubjectsDataA(subjectId, :) = mean(subjectData.A, 1);
        allSubjectsDataB(subjectId, :) = mean(subjectData.B, 1);
        allSubjectsDataC(subjectId, :) = mean(subjectData.C, 1);
    end
    
    displayTabs(allSubjectsDataA, allSubjectsDataB, allSubjectsDataC, timeVector);


    function [meanData, upperBound, lowerBound] = getMeanAndStd(data)
        % data = 30 X 250
        meanData = mean(data, 1);
        stdData = std(data, 1);
        upperBound = meanData + stdData;
        lowerBound = meanData - stdData;
    end
    

    function [zeroNormalizedTime, notNanMeanData, notNanUpperBound, notNanLowerBound] = getNormalizedTime(meanData, upperBound, lowerBound, timeVector)
        firstNonNanIdx = sum(isnan(meanData)) + 1;
        totalDuration = timeVector(end) - timeVector(firstNonNanIdx);
        zeroNormalizedTime = linspace(0, totalDuration, length(timeVector)-firstNonNanIdx+1);
    
        notNanMeanData = meanData(firstNonNanIdx:end);
        notNanUpperBound = upperBound(firstNonNanIdx:end);
        notNanLowerBound = lowerBound(firstNonNanIdx:end);
    end


    function displayTabs(allSubjectsDataA, allSubjectsDataB, allSubjectsDataC, timeVector)
        % delete previous displayPanelGrid
        delete(displayPanelGrid);

        % create new displayPanelGrid
        displayPanelGrid = uigridlayout(displayPanel, [1, 1]);
        displayPanelGrid.RowSpacing = 20;
        displayPanelGrid.ColumnWidth = {'1x', 22};
        displayPanelGrid.BackgroundColor = "white";
        displayPanelGrid.Padding = [50 50 50 50];
        
        colors = [0, 0.4470, 0.7410; 0.8500, 0.3250, 0.0980; 0.4660, 0.6740, 0.1880];
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 1; 
        ax.Layout.Column = 1;
        ax.ColorOrder = colors;

        patchBlue = [0, 0.4470, 0.7410];
        patchRed = [0.8500, 0.3250, 0.0980];
        patchGreen = [0.4660, 0.6740, 0.1880];
        
        
        [meanDataA, upperBoundA, lowerBoundA] = getMeanAndStd(allSubjectsDataA);
        [meanDataB, upperBoundB, lowerBoundB] = getMeanAndStd(allSubjectsDataB);
        [meanDataC, upperBoundC, lowerBoundC] = getMeanAndStd(allSubjectsDataC);

        [timeVectorA, notNanMeanDataA, notNanUpperBoundA, notNanLowerBoundA] = getNormalizedTime(meanDataA, upperBoundA, lowerBoundA, timeVector);
        [timeVectorB, notNanMeanDataB, notNanUpperBoundB, notNanLowerBoundB] = getNormalizedTime(meanDataB, upperBoundB, lowerBoundB, timeVector);
        [timeVectorC, notNanMeanDataC, notNanUpperBoundC, notNanLowerBoundC] = getNormalizedTime(meanDataC, upperBoundC, lowerBoundC, timeVector);
        
        plot(ax, timeVectorA, notNanMeanDataA, timeVectorB, notNanMeanDataB, ...
            timeVectorC, notNanMeanDataC, "LineWidth", 2);

        titleName = sprintf("Mean of preprocessed data of 20 subjects across 3 Conditions");
        title(ax, titleName);
        xlabel(ax, 'Time (s)');
        ylabel(ax, 'Knee Angle (degree)');
        legend(ax, 'Condition A', 'Condition B', 'Condition C');
        
        % patch for condition A
        x = [timeVectorA, fliplr(timeVectorA)];
        y = [notNanUpperBoundA fliplr(notNanLowerBoundA)];
        p1 = patch(ax, x, y, patchBlue, "Facealpha", 0.3);
        p1.Annotation.LegendInformation.IconDisplayStyle = 'off';

        % patch for condition B
        x = [timeVectorB, fliplr(timeVectorB)];
        y = [notNanUpperBoundB fliplr(notNanLowerBoundB)];
        p2 = patch(ax, x, y, patchRed, "Facealpha", 0.3);
        p2.Annotation.LegendInformation.IconDisplayStyle = 'off';

        % patch for condition C
        x = [timeVectorC, fliplr(timeVectorC)];
        y = [notNanUpperBoundC fliplr(notNanLowerBoundC)];
        p3 = patch(ax, x, y, patchGreen, "Facealpha", 0.3);
        p3.Annotation.LegendInformation.IconDisplayStyle = 'off';
    end
end