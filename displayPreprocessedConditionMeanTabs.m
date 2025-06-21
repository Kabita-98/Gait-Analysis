function displayPreprocessedConditionMeanTabs(conditionMeanWiseTab, subjectList, conditionList, A, B, C)
    
    % Create grid to include two columnar panels
    preprocessedConditionMeanGrid = uigridlayout(conditionMeanWiseTab, [2 2]);
    preprocessedConditionMeanGrid.RowHeight = {'1x', '1x'};
    preprocessedConditionMeanGrid.ColumnWidth = {'1x', '0.4x'};
    preprocessedConditionMeanGrid.BackgroundColor = "white";

    % Create panel to display plots and control the plots
    displayPanel = uipanel(preprocessedConditionMeanGrid, "Title", "Plots");
    controlPanel = uipanel(preprocessedConditionMeanGrid, "Title", "Control");
    guidePanel = uipanel(preprocessedConditionMeanGrid, "Title", "Guide");

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
    
    % Create UI components for Display Panel
    displayPanelGrid = uigridlayout(displayPanel, [1, 2]);
    displayPanelGrid.RowSpacing = 20;
    displayPanelGrid.ColumnWidth = {'1x', 22};
    displayPanelGrid.BackgroundColor = "white";
    displayPanelGrid.Padding = [20 50 50 20];

    preprocessConditionMean(displayPanel, displayPanelGrid, A, B, C);
end