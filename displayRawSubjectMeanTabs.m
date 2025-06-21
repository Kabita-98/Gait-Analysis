% Function to display content when clicked rawdata-subject-mean
function displayRawSubjectMeanTabs(subjectMeanWiseTab, subjectList, conditionList, A, B, C)
    
    % Create grid to include two columnar panels
    rawSubjectMeanGrid = uigridlayout(subjectMeanWiseTab, [2 2]);
    rawSubjectMeanGrid.RowHeight = {'1x', '1x'};
    rawSubjectMeanGrid.ColumnWidth = {'1x', '0.4x'};
    rawSubjectMeanGrid.BackgroundColor = "white";


    % Create panel to display plots and control the plots
    displayPanel = uipanel(rawSubjectMeanGrid, "Title", "Plots");
    controlPanel = uipanel(rawSubjectMeanGrid, "Title", "Control");
    guidePanel = uipanel(rawSubjectMeanGrid, "Title", "Guide");

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
    controlPanelGrid = uigridlayout(controlPanel, [2,2]);

    controlPanelGrid.BackgroundColor = "white";
    controlPanelGrid.RowHeight = {44, '1x'};
    controlPanelGrid.ColumnWidth = {80, '1x'};

    subjectDropDownLabel = uilabel(controlPanelGrid, "Text", "Subject:");
    subjectDropDownLabel.FontWeight = "bold";

    subjectDropDown = uidropdown(controlPanelGrid);
    subjectDropDown.Items = subjectList;
    subjectDropDown.ItemsData = 1:20;
    subjectDropDown.BackgroundColor = "white";

    subjectDropDown.ValueChangedFcn = @(src, event)changePlot(src, event);
    
    % Create UI Components for Guide Panel
    guidePanelGrid = uigridlayout(guidePanel, [1, 1]);
    guidePanelGrid.BackgroundColor = "white";
    guidePanelGrid.RowHeight = {'1x'};
    guidePanelGrid.ColumnWidth = {'1x'};

    guideData = uilabel(guidePanelGrid);
    guideData.WordWrap = "on";
    guideData.VerticalAlignment = "top";
    guideData.Text = "To display the plots for a specific subject, please use the drop-down menu in the control panel to select the desired subject.";

    % Create UI components for Display Panel
    displayPanelGrid = uigridlayout(displayPanel, [1, 2]);
    displayPanelGrid.RowSpacing = 20;
    displayPanelGrid.ColumnWidth = {'1x', 22};
    displayPanelGrid.BackgroundColor = "white";
    displayPanelGrid.Padding = [20 50 50 20];

    % Default subject 1 plots
    displaySubjectWiseMean(1);


    % Create function to change plot when subject is changed in the
    %drop down menu
    function changePlot(src, ~)
        displaySubjectWiseMean(src.Value);
    end

    function displaySubjectWiseMean(subjectId)
        % delete previous displayPanelGrid
        delete(displayPanelGrid)


        % create new displayPanelGrid
        displayPanelGrid = uigridlayout(displayPanel, [1, 2]);
        displayPanelGrid.RowSpacing = 20;
        displayPanelGrid.ColumnWidth = {'1x', 22};
        displayPanelGrid.BackgroundColor = "white";
        displayPanelGrid.Padding = [50 50 50 50];

        % Load data
        dataConditionA = load(A(subjectId));
        dataConditionB = load(B(subjectId));
        dataConditionC = load(C(subjectId));

        meanAllCondition = [mean(dataConditionA.y,1);mean(dataConditionB.y,1);mean(dataConditionC.y,1)];

        % Plot for condition A
        colors = [0, 0.4470, 0.7410; 0.8500, 0.3250, 0.0980; 0.4660, 0.6740, 0.1880];
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 1; 
        ax.Layout.Column = 1; 
        ax.ColorOrder = colors;
        plot(ax, meanAllCondition', LineWidth=2);
        titleName = sprintf("Mean of raw data of 30 Trials for Subject %.f Across 3 Conditions", subjectId);
        title(ax, titleName);
        xlabel(ax, 'Data Points');
        ylabel(ax, 'Knee Angle (degree)');
        legend(ax, 'Condition A', 'Condition B', 'Condition C');
    end
end