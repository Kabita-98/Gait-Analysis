function loadDataPage(fig)

    % Create loadDataPage grid to contains all UI components of
    % loadDataPage
    loadDataPageGrid = uigridlayout(fig, [3 1]);
    loadDataPageGrid.BackgroundColor = "white";
    loadDataPageGrid.RowHeight = {'1x', 100, 150};


    % create label that display the title of the loadDataPage
    title = uilabel(loadDataPageGrid);
    title.Layout.Row = 1; 
    title.Layout.Column = 1; 
    title.HorizontalAlignment = "center";
    title.VerticalAlignment = "bottom";
    title.Text = "Movemento";
    title.FontName = "Snell Roundhand"; %"San Francisco";
    title.FontSize = 54;
    title.FontWeight = "bold";
    

    % create label that displays the app information
    info = uilabel(loadDataPageGrid);
    info.Layout.Row = 2; 
    info.Layout.Column = 1; 
    info.HorizontalAlignment = "center";
    info.VerticalAlignment = "top";
    info.Text = "An app to visualise and analyse complex gait cycle datasets.";
    info.FontName = "San Francisco";
    info.FontSize = 16;
   

    % create button grid to place button properly
    buttonGrid = uigridlayout(loadDataPageGrid, [2 3]);
    buttonGrid.RowHeight = {'0.4x','0.6x'};
    buttonGrid.ColumnWidth = {'1x', 200, '1x'};
    buttonGrid.BackgroundColor = "white";
    buttonGrid.Layout.Row = 3; 
    buttonGrid.Layout.Column = 1; 


    % Create button to select and load files
    loadButton = uibutton(buttonGrid); %buttonGrid
    loadButton.Layout.Row = 1; 
    loadButton.Layout.Column = 2; 
    loadButton.HorizontalAlignment = "center";
    loadButton.Text = "Load Data";
    loadButton.FontName = "San Francisco";
    loadButton.FontSize = 16;
    loadButton.FontWeight = "bold";
    loadButton.BackgroundColor = "black";
    loadButton.FontColor = "white";
    loadButton.ButtonPushedFcn = @(src, event)selectFile(src, event);
    

    % variable to store zip file path containing the datasets
    selectedZipFile = ""; 


    % function to select the zip file and the user click on loadButton
    function selectFile(src, event)
        % making figure visibility off to bring the uiget dialog box in
        % front
        fig.Visible = "off";
        [file, path] = uigetfile('*.zip', 'Select a zip file');
       
        
        if isequal(file, 0)
            selectedZipFile = "";
            % making figure visible as the user did not select any file
            fig.Visible = "on";
        else
            % Delete loadPageGrid
            delete(loadDataPageGrid);
            
            selectedZipFile = fullfile(path, file);
            
            % call displayPage for displaying the data 
            displayPage(fig, selectedZipFile);
        end
    end
end
