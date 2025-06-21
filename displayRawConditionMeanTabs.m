function displayRawConditionMeanTabs(conditionMeanWiseTab, subjectList, conditionList, A, B, C)
    % Create grid to include two columnar panels
    rawConditionMeanGrid = uigridlayout(conditionMeanWiseTab, [2 2]);
    rawConditionMeanGrid.RowHeight = {'1x', '1x'};
    rawConditionMeanGrid.ColumnWidth = {'1x', '0.4x'};
    rawConditionMeanGrid.BackgroundColor = "white";


    % Create panel to display plots and control the plots
    displayPanel = uipanel(rawConditionMeanGrid, "Title", "Plots");
    controlPanel = uipanel(rawConditionMeanGrid, "Title", "Control");
    guidePanel = uipanel(rawConditionMeanGrid, "Title", "Guide");

    displayPanel.Layout.Row = [1 2];
    displayPanel.BackgroundColor = "white";
    displayPanel.FontAngle = "italic";
    displayPanel.Scrollable = "on";

    controlPanel.Layout.Row = 1;
    controlPanel.Layout.Column = 2;
    controlPanel.BackgroundColor = "white";
    controlPanel.FontAngle = "italic";
    controlPanel.Scrollable = "on";

    guidePanel.Layout.Row = 2;
    guidePanel.Layout.Column = 2;
    guidePanel.BackgroundColor = "white";
    guidePanel.FontAngle = "italic";
    guidePanel.Scrollable = "on";


    % Create UI components for Control Panel
    controlPanelGrid = uigridlayout(controlPanel, [3,2]);

    controlPanelGrid.BackgroundColor = "white";
    controlPanelGrid.RowHeight = {44, 44, '1x'};
    controlPanelGrid.ColumnWidth = {80, '1x'};

    % Create UI components for Display Panel
    displayPanelGrid = uigridlayout(displayPanel, [1, 2]);
    displayPanelGrid.RowSpacing = 20;
    displayPanelGrid.ColumnWidth = {'1x', 22};
    displayPanelGrid.BackgroundColor = "white";
    displayPanelGrid.Padding = [20 50 50 20];

    displayConditionWiseMean;

    function displayConditionWiseMean
        conditionAMean = zeros(20, 250);
        conditionBMean = zeros(20, 250);
        conditionCMean = zeros(20, 250);

        % calculating mean for condition A
        for subjectId = 1:20
            conditionSubjectData = load(A(subjectId)).y; % size = [30, 250]
            conditionSubjectMean = mean(conditionSubjectData, 1); % size = [1, 250]
            conditionAMean(subjectId, :) = conditionSubjectMean;
        end

        % calculating mean for condition B
        for subjectId = 1:20
            conditionSubjectData = load(B(subjectId)).y; % size = [30, 250]
            conditionSubjectMean = mean(conditionSubjectData, 1); % size = [1, 250]
            conditionBMean(subjectId, :) = conditionSubjectMean;
        end

        % calculating mean for condition C
        for subjectId = 1:20
            conditionSubjectData = load(C(subjectId)).y; % size = [30, 250]
            conditionSubjectMean = mean(conditionSubjectData, 1); % size = [1, 250]
            conditionCMean(subjectId, :) = conditionSubjectMean;
        end
        
        rawConditionMean = [mean(conditionAMean, 1); mean(conditionBMean, 1); mean(conditionCMean, 1);];
        colors = [0, 0.4470, 0.7410; 0.8500, 0.3250, 0.0980; 0.4660, 0.6740, 0.1880];
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 1; 
        ax.Layout.Column = 1; 
        ax.ColorOrder = colors;
        plot(ax, rawConditionMean', LineWidth=2);
        titleName = sprintf("Mean of raw data of 20 subjects across 3 Conditions");
        title(ax, titleName);
        xlabel(ax, 'Data Points');
        ylabel(ax, 'Knee Angle (degree)');
        legend(ax, 'Condition A', 'Condition B', 'Condition C');
    end
end