function checkedBoxes = displayPreprocessedSubjectTabs(fig, subjectWiseTab, subjectList, conditionList, A, B, C)
    
    % Create grid to include two columnar panels
    preprocessedSubjectGrid = uigridlayout(subjectWiseTab, [2 2]);
    preprocessedSubjectGrid.RowHeight = {'1x', '1x'};
    preprocessedSubjectGrid.ColumnWidth = {'1x', '0.4x'};
    preprocessedSubjectGrid.BackgroundColor = "white";


    % Create panel to display plots and control the plots
    displayPanel = uipanel(preprocessedSubjectGrid, "Title", "Plots");
    controlPanel = uipanel(preprocessedSubjectGrid, "Title", "Control");
    guidePanel = uipanel(preprocessedSubjectGrid, "Title", "Guide");

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
    guideText = sprintf("To display the plots for a specific subject, please use the drop-down menu in the control panel to select the desired subject.\n" + ...
        "\nTo observe the effect on the data, please select or deselect a preprocessing step.\n" + ...
        "\nLabels for Detection of Events:\n" + ...
        "LR: Loading Response Time\n" + ...
        "Mst: Mid-Stance\n" + ...
        "Tst: Terminal-Stance\n" + ...
        "PS: Pre-Swing\n" + ...
        "IS: Initial Swing\n" + ...
        "MS: Mid-Swing\n" + ...
        "TS: Terminal-Swing\n");
    guideData.Text = guideText;

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

    dataRectificationCheckBox = uicheckbox(preprocessingParametersGrid, "Text", "Data Rectification");
    dataRectificationCheckBox.FontWeight = "bold";
    
    dataSmoothingCheckBox = uicheckbox(preprocessingParametersGrid, "Text", "Data Smoothing");
    dataSmoothingCheckBox.FontWeight = "bold";

    temporalNormalizationCheckBox = uicheckbox(preprocessingParametersGrid, "Text", "Temporal Normalization");
    temporalNormalizationCheckBox.FontWeight = "bold";

    dataSynchronizationCheckBox = uicheckbox(preprocessingParametersGrid, "Text", "Data Synchronization");
    dataSynchronizationCheckBox.FontWeight = "bold";

    detectionEventsCheckBox = uicheckbox(preprocessingParametersGrid, "Text", "Detection of Events");
    detectionEventsCheckBox.FontWeight = "bold";

    
    
    % Subject drop down behavior
    subjectDropDown.ValueChangedFcn = @(src, event)changePlot(src, event, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox);


    % Checkbox behavior
    dataRectificationCheckBox.ValueChangedFcn = @(src,event) preproceesingcheckBoxChanged(subjectDropDown, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox);
    
    dataSmoothingCheckBox.ValueChangedFcn = @(src,event) preproceesingcheckBoxChanged(subjectDropDown, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox);
    
    temporalNormalizationCheckBox.ValueChangedFcn = @(src,event) preproceesingcheckBoxChanged(subjectDropDown, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox);
    
    dataSynchronizationCheckBox.ValueChangedFcn = @(src,event) preproceesingcheckBoxChanged(subjectDropDown, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox);

    detectionEventsCheckBox.ValueChangedFcn = @(src,event) preproceesingcheckBoxChanged(subjectDropDown, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox);
    
    

    % Create UI components for Display Panel
    displayPanelGrid = uigridlayout(displayPanel, [3, 2]);
    displayPanelGrid.RowSpacing = 20;
    displayPanelGrid.ColumnWidth = {'1x', 22};
    displayPanelGrid.BackgroundColor = "white";
    displayPanelGrid.Padding = [20 50 50 20];

    % Default Behavior
    checkedBoxes = [1, 1, 1, 1, 0];
    dataRectificationCheckBox.Value = 1;
    dataSmoothingCheckBox.Value = 1;
    temporalNormalizationCheckBox.Value = 1;
    dataSynchronizationCheckBox.Value = 1;
    detectionEventsCheckBox.Value = 0;

    preprocessSubject(fig, checkedBoxes, subjectDropDown, displayPanel, displayPanelGrid, A, B, C, dataSynchronizationCheckBox);

    function preproceesingcheckBoxChanged(subjectDropDown, dataRectificationCheckBox, ...
        dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox)
        
        checkedBoxes = [dataRectificationCheckBox.Value, dataSmoothingCheckBox.Value, temporalNormalizationCheckBox.Value, dataSynchronizationCheckBox.Value, detectionEventsCheckBox.Value];
        preprocessSubject(fig, checkedBoxes, subjectDropDown, displayPanel, displayPanelGrid, A, B, C, dataSynchronizationCheckBox);
    end

    % Create function to change plot when subject is changed in the
    %drop down menu
    function changePlot(src, event, dataRectificationCheckBox, ...
            dataSmoothingCheckBox, temporalNormalizationCheckBox, dataSynchronizationCheckBox, detectionEventsCheckBox)
        
        checkedBoxes = [dataRectificationCheckBox.Value, dataSmoothingCheckBox.Value, temporalNormalizationCheckBox.Value, dataSynchronizationCheckBox.Value, detectionEventsCheckBox.Value];
        preprocessSubject(fig, checkedBoxes, src, displayPanel, displayPanelGrid, A, B, C, dataSynchronizationCheckBox);
    end
end
