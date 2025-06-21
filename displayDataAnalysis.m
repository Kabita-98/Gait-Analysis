function dataAnalysisGrid = displayDataAnalysis(tab, subjectList, conditionList, A, B, C)
    
    % Create grid to include two columnar panels
    dataAnalysisGrid = uigridlayout(tab, [2 2]);
    dataAnalysisGrid.RowHeight = {'1x', '1x'};
    dataAnalysisGrid.ColumnWidth = {'1x', '0.4x'};
    dataAnalysisGrid.BackgroundColor = "white";


    % Create panel to display plots and control the plots
    analysisPanel = uipanel(dataAnalysisGrid, "Title", "Analysis");
    controlPanel = uipanel(dataAnalysisGrid, "Title", "Control");
    guidePanel = uipanel(dataAnalysisGrid, "Title", "Guide");

    analysisPanel.Layout.Row = [1 2];
    analysisPanel.BackgroundColor = "white";
    analysisPanel.FontAngle = "italic";
    analysisPanel.Scrollable = "on";

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
    controlPanelGrid = uigridlayout(controlPanel, [2,1]);
    controlPanelGrid.BackgroundColor = "white";
    controlPanelGrid.RowHeight = {20, 50};
    controlPanelGrid.ColumnWidth = {'1x'};

    % Label for selecting features
    featureSelectionLabel = uilabel(controlPanelGrid, "Text", "Select a feature");
    featureSelectionLabel.FontWeight = "bold";
    featureSelectionLabel.Layout.Row = 1;
    featureSelectionLabel.Layout.Column = 1;

    % Create radio button group
    featureRadioBtnGroup = uibuttongroup(controlPanelGrid);
    featureRadioBtnGroup.Layout.Row = 2;
    featureRadioBtnGroup.Layout.Column = 1;
    featureRadioBtnGroup.BackgroundColor = "white";
    featureRadioBtnGroup.BorderType = "none";

    % Create radio buttons
    maxKneeAngleRadioBtn = uiradiobutton(featureRadioBtnGroup, "Text", "Maximum Knee Angle", "Position", [1 28 150 22]);
    swingDurationRadioBtn = uiradiobutton(featureRadioBtnGroup, "Text", "Swing Phase Duration", "Position", [1 0 150 22]);

    % Assign behavior to the radio button group
    featureRadioBtnGroup.SelectionChangedFcn = @(src, event) changeAnalysis(src, event);
    
    % Default behavior
    analysisAndPlots(analysisPanel, subjectList, conditionList, A, B, C, "maxKneeAngle");

    
    % Create function to change the analysis based on selected radio button
    function changeAnalysis(src, event)
        switch event.NewValue.Text
            case "Maximum Knee Angle"
                analysisAndPlots(analysisPanel, subjectList, conditionList, A, B, C, "maxKneeAngle");
            case "Swing Phase Duration"
                analysisAndPlots(analysisPanel, subjectList, conditionList, A, B, C, "swingPhase");
        end
    end
end

