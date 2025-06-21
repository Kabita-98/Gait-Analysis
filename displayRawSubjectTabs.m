% Function to display default tabs content
function displayRawSubjectTabs(subjectWiseTab, subjectList, conditionList, A, B, C)

    % Create grid to include two columnar panels
    rawSubjectGrid = uigridlayout(subjectWiseTab, [2 2]);
    rawSubjectGrid.RowHeight = {'1x', '1x'};
    rawSubjectGrid.ColumnWidth = {'1x', '0.4x'};
    rawSubjectGrid.BackgroundColor = "white";


    % Create panel to display plots and control the plots
    displayPanel = uipanel(rawSubjectGrid, "Title", "Plots");
    controlPanel = uipanel(rawSubjectGrid, "Title", "Control");
    guidePanel = uipanel(rawSubjectGrid, "Title", "Guide");
    
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


    % Create UI components for Display Panel
    displayPanelGrid = uigridlayout(displayPanel, [3, 2]);
    displayPanelGrid.RowSpacing = 20;
    displayPanelGrid.ColumnWidth = {'1x', 22};
    displayPanelGrid.BackgroundColor = "white";
    displayPanelGrid.Padding = [20 50 50 20];


    % Create UI Components for Guide Panel
    guidePanelGrid = uigridlayout(guidePanel, [1, 1]);
    guidePanelGrid.BackgroundColor = "white";
    guidePanelGrid.RowHeight = {'1x'};
    guidePanelGrid.ColumnWidth = {'1x'};

    guideData = uilabel(guidePanelGrid);
    guideData.WordWrap = "on";
    guideData.VerticalAlignment = "top";
    guideData.Text = "To display the plots for a specific subject, please use the drop-down menu in the control panel to select the desired subject.";

    % Default subject 1 plots
    displaySubjectWise(1);


    % Create function to change plot when subject is changed in the
    %drop down menu
    function changePlot(src, ~)
        displaySubjectWise(src.Value);
    end


    % Create function to display plots subjectwise 
    function displaySubjectWise(subjectId)      
        % delete previous displayPanelGrid
        delete(displayPanelGrid)


        % create new displayPanelGrid
        displayPanelGrid = uigridlayout(displayPanel, [3, 2]);
        displayPanelGrid.RowSpacing = 20;
        displayPanelGrid.ColumnWidth = {'1x', 22};
        displayPanelGrid.BackgroundColor = "white";
        displayPanelGrid.Padding = [50 50 50 50];


        % Load and plot condition A data for subject Id
        cond_A_data = load(A(subjectId));
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 1; 
        ax.Layout.Column = 1; 
        plot(ax, cond_A_data.y')
        titleName = sprintf('Raw data of Subject %.f - Condition A for 30 trials', subjectId);
        title(ax, titleName);
        xlabel(ax, 'Data Points');
        ylabel(ax, 'Knee Angle (degree)');

        % Load and plot condition B data for subject Id
        cond_B_data = load(B(subjectId));
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 2;
        ax.Layout.Column = 1; 
        plot(ax, cond_B_data.y')
        titleName = sprintf('Raw data of Subject %.f - Condition B for 30 trials', subjectId);
        title(ax, titleName);
        xlabel(ax, 'Data Points');
        ylabel(ax, 'Knee Angle (degree)');

        % Load and plot condition C data for subject Id
        cond_C_data = load(C(subjectId));
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 3;
        ax.Layout.Column = 1;
        plot(ax, cond_C_data.y')
        titleName = sprintf('Raw data of Subject %.f - Condition C for 30 trials', subjectId);
        title(ax, titleName);
        xlabel(ax, 'Data Points');
        ylabel(ax, 'Knee Angle (degree)');
    end
end