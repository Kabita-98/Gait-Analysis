function displayPreprocessedSubjectMeanTabs(fig, subjectMeanWiseTab, subjectList, conditionList, A, B, C)
    
    % Create grid to include two columnar panels
    preprocessedSubjectMeanGrid = uigridlayout(subjectMeanWiseTab, [2 2]);
    preprocessedSubjectMeanGrid.RowHeight = {'1x', '1x'};
    preprocessedSubjectMeanGrid.ColumnWidth = {'1x', '0.4x'};
    preprocessedSubjectMeanGrid.BackgroundColor = "white";

    % Create panel to display plots and control the plots
    displayPanel = uipanel(preprocessedSubjectMeanGrid, "Title", "Plots");
    controlPanel = uipanel(preprocessedSubjectMeanGrid, "Title", "Control");
    guidePanel = uipanel(preprocessedSubjectMeanGrid, "Title", "Guide");

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

    % Create UI Components for Guide Panel
    guidePanelGrid = uigridlayout(guidePanel, [1, 1]);
    guidePanelGrid.BackgroundColor = "white";
    guidePanelGrid.RowHeight = {'1x'};
    guidePanelGrid.ColumnWidth = {'1x'};
    
    guideData = uilabel(guidePanelGrid);
    guideData.WordWrap = "on";
    guideData.VerticalAlignment = "top";
    guideData.Text = "To display the plots for a specific subject, please use the drop-down menu in the control panel to select the desired subject.";

    % Create UI components for Control Panel
    controlPanelGrid = uigridlayout(controlPanel, [2,1]);
    controlPanelGrid.BackgroundColor = "white";
    controlPanelGrid.RowHeight = {44, '1x'};

    dropDownPanelGrid = uigridlayout(controlPanelGrid, [1, 2]);
    dropDownPanelGrid.BackgroundColor = "white";
    dropDownPanelGrid.Padding = [0 0 0 0];
    dropDownPanelGrid.ColumnWidth = {80, '1x'};
    
    subjectDropDownLabel = uilabel(dropDownPanelGrid, "Text", "Subject:");
    subjectDropDownLabel.FontWeight = "bold";

    subjectDropDown = uidropdown(dropDownPanelGrid);
    subjectDropDown.Items = subjectList;
    subjectDropDown.ItemsData = 1:20;
    subjectDropDown.BackgroundColor = "white";

    preprocessingParametersGrid = uigridlayout(controlPanelGrid, [5,1]);
    preprocessingParametersGrid.BackgroundColor = "white";
    preprocessingParametersGrid.RowHeight = {22, 22, 22, 22, 22, '1x'};
    preprocessingParametersGrid.Padding = [0 0 0 20];
    
    % Subject drop down behavior
    subjectDropDown.ValueChangedFcn = @(src, event)changePlot(src, event);

    % Create UI components for Display Panel
    displayPanelGrid = uigridlayout(displayPanel, [3, 2]);
    displayPanelGrid.RowSpacing = 20;
    displayPanelGrid.ColumnWidth = {'1x', 22};
    displayPanelGrid.BackgroundColor = "white";
    displayPanelGrid.Padding = [20 50 50 20];

    % Default Behavior
    preprocessSubjectMean(fig, subjectDropDown, displayPanel, displayPanelGrid, A, B, C);

    % Create function to change plot when subject is changed in the
    %drop down menu
    function changePlot(src, event)
        preprocessSubjectMean(fig, subjectDropDown, displayPanel, displayPanelGrid, A, B, C);
    end
end