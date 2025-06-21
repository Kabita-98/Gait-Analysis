function displayPage(fig, selectedZipFile)
    % Set delimiter
    delim = "/";
    
    % Get ScreenSize
    screenSize = get(groot, 'ScreenSize');

    % Define app size (Width, Height)
    appWidth = 1200;
    appHeight = 700;

    % Calculate position to center the app on the screen
    appX = (screenSize(3) - appWidth) / 2;
    appY = (screenSize(4) - appHeight) / 2;

    % Increase the fig Position
    fig.Position = [appX, appY, appWidth, appHeight];

    % Create display page grid layout
    displayPageGrid = uigridlayout(fig, [1 1]);
    displayPageGrid.Padding = [0 0 0 0];
    displayPageGrid.RowHeight = {'1x'};
    displayPageGrid.BackgroundColor = "white";
    
    % Create main tab group
    mainTabGroup = uitabgroup(displayPageGrid);
    
    % Create Tab 1: Raw Data
    rawDataTab = uitab(mainTabGroup, "Title", "Raw Data");

    % Create raw data display page grid layout
    rawDataDisplayPageGrid = uigridlayout(rawDataTab, [1 1]);
    rawDataDisplayPageGrid.Padding = [0 0 0 0];
    rawDataDisplayPageGrid.RowHeight = {'1x'};
    rawDataDisplayPageGrid.BackgroundColor = "white";

    % Create Tab1 sub tabs group
    rawDataSubTabsGroup = uitabgroup(rawDataDisplayPageGrid);

    % Create subtabs for Tab1
    rawDataSubjectTab = uitab(rawDataSubTabsGroup, "Title", "Subject");
    rawDataSubjectMeanTab = uitab(rawDataSubTabsGroup, "Title", "Subject Mean");
    rawDataConditionMeanTab = uitab(rawDataSubTabsGroup,"Title", "Condition Mean");


    % Create Tab 2: Preprocessing
    preprocessingTab = uitab(mainTabGroup, "Title", "Preprocessing");

    % Create raw data display page grid layout
    preprocessingDisplayPageGrid = uigridlayout(preprocessingTab, [1 1]);
    preprocessingDisplayPageGrid.Padding = [0 0 0 0];
    preprocessingDisplayPageGrid.RowHeight = {'1x'};
    preprocessingDisplayPageGrid.BackgroundColor = "white";

    % Create Tab2 sub tabs group
    preprocessingSubTabsGroup = uitabgroup(preprocessingDisplayPageGrid);

    % Create subtabs for Tab2
    preprocessingSubjectTab = uitab(preprocessingSubTabsGroup, "Title", "Subject");
    preprocessingSubjectMeanTab = uitab(preprocessingSubTabsGroup, "Title", "Subject Mean");
    preprocessingConditionMeanTab = uitab(preprocessingSubTabsGroup,"Title", "Condition Mean");


    % Create Tab 3: Data Analysis
    dataAnalysisTab = uitab(mainTabGroup, "Title", "Data Analysis");
    

    % Make fig visible after all UI components are initialized
    fig.Visible = "on";
    fig.Resize = "on";

    % Behavior for clicking tabs
    mainTabGroup.SelectionChangedFcn = @(src, event) displayMainTab;
    rawDataSubTabsGroup.SelectionChangedFcn = @(src, event) displayRawDataTabs;
    preprocessingSubTabsGroup.SelectionChangedFcn = @(src, event) displayPreprocessingTabs;
    
    % Create subject and condition list
    subjectList = strings(1, 20);
    conditionList = ["Condition A", "Condition B", "Condition C"];
    for i = 1:20
        subjectList(i) = strcat("Subject ", string(i));
    end
    
    % Calling the Load file paths 
    [A, B, C] = loadFilePaths;

    % Function to load all the file paths
    function [A, B, C] = loadFilePaths
        % Unzip the zipped file
        files = unzip(selectedZipFile);

        % Extract absolute file path
        splittedFile = split(selectedZipFile, delim);
        absoluteFilePath = join(splittedFile(1:end-1,1), delim);

        % Create variables to store file paths respetively for all
        % three conditions
        A = strings(1, 20);
        B = strings(1, 20);
        C = strings(1, 20);

        % Load file paths into respective vectors
        for i = 1:length(files)
            dissectDir = split(files(i), delim);
            dissectFile = split(dissectDir(end), '_');
            condition = dissectFile(1); % extracting condition from the file path
            dissectIdx = split(dissectFile(3), '.');
            subjectID = str2num(string(dissectIdx(1))); % extracting subjectid from the file path

            fullpath = strcat(absoluteFilePath, delim, files(i));

            if isequal(condition, {'A'})
                A(subjectID) = string(fullpath); 
            elseif isequal(condition, {'B'})
                B(subjectID) = string(fullpath); 
            else
                C(subjectID) = string(fullpath); 
            end
        end
    end
    
    % display default tabs (raw data - subject)
    displayRawSubjectTabs(rawDataSubjectTab, subjectList, conditionList, A, B, C);

    function displayMainTab
        if strcmp(mainTabGroup.SelectedTab.Title, 'Raw Data')
            switch rawDataSubTabsGroup.SelectedTab.Title
                case "Subject"
                    displayRawSubjectTabs(rawDataSubjectTab, subjectList, conditionList, A, B, C);
                case "Subject Mean"
                    displayRawSubjectMeanTabs(rawDataSubjectMeanTab, subjectList, conditionList, A, B, C);
                otherwise
                    displayRawConditionMeanTabs(rawDataConditionMeanTab, subjectList, conditionList, A, B, C);
            end
        elseif strcmp(mainTabGroup.SelectedTab.Title, 'Preprocessing')
            switch preprocessingSubTabsGroup.SelectedTab.Title
                case "Subject"
                    displayPreprocessedSubjectTabs(fig, preprocessingSubjectTab, subjectList, conditionList, A, B, C);
                case "Subject Mean"
                    displayPreprocessedSubjectMeanTabs(fig, preprocessingSubjectMeanTab, subjectList, conditionList, A, B, C);
                otherwise
                    displayPreprocessedConditionMeanTabs(preprocessingConditionMeanTab, subjectList, conditionList, A, B, C);
            end
        else
            displayDataAnalysis(dataAnalysisTab, subjectList, conditionList, A, B, C);
        end
    end

    function displayRawDataTabs
        switch rawDataSubTabsGroup.SelectedTab.Title
            case "Subject"
                displayRawSubjectTabs(rawDataSubjectTab, subjectList, conditionList, A, B, C);
            case "Subject Mean"
                displayRawSubjectMeanTabs(rawDataSubjectMeanTab, subjectList, conditionList, A, B, C);
            otherwise
                displayRawConditionMeanTabs(rawDataConditionMeanTab, subjectList, conditionList, A, B, C);
        end
    end

    function displayPreprocessingTabs
       switch preprocessingSubTabsGroup.SelectedTab.Title
            case "Subject"
                displayPreprocessedSubjectTabs(fig, preprocessingSubjectTab, subjectList, conditionList, A, B, C);
            case "Subject Mean"
                displayPreprocessedSubjectMeanTabs(fig, preprocessingSubjectMeanTab, subjectList, conditionList, A, B, C);
            otherwise
                displayPreprocessedConditionMeanTabs(preprocessingConditionMeanTab, subjectList, conditionList, A, B, C);
        end 
    end
end