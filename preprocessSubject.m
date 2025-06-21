function preprocessSubject(fig, checkedBoxes, subjectDropDown, displayPanel, displayPanelGrid, A, B, C, dataSynchronizationCheckBox)
    
    subjectId = subjectDropDown.Value;
    
    % Load data --> make it global later on
    subjectData.A = load(A(subjectId)).y;
    subjectData.B = load(B(subjectId)).y;
    subjectData.C = load(C(subjectId)).y;
    samplingFreq = 250;
    timeVector = linspace(0, 1, samplingFreq); % 1sec = 250 points | also equivalent to normalized time

    if checkedBoxes(1) == 1
        % Data Rectification checkedbox is ticked
        subjectData = doDataRectification(subjectData);
    end

    if checkedBoxes(2) == 1
        % Data Fitlering checkbox is ticked
        % windowSize for the moving average
        % freq = 250Hz, 4 ms --> 1 data point
        % desired window size for walk gait cycle = 50-100 ms
        % we took 80 ms --> 80/4 = 20 data points
        windowSize = 20;

        subjectData = doDataSmoothing(windowSize, subjectData);
    end
    
    if checkedBoxes(3) == 1
        % Temporal Normalization checkbox is ticked
        subjectData = doTemporalNormalization(samplingFreq, subjectData);
    end

    if checkedBoxes(4) == 1
        % Data Synchronisation checkbox is ticked

        % Check if temporal Normalisation checkbox is ticked
        if checkedBoxes(3) == 1
            % Do data synchronisation
            subjectData = doDataSynchronisation(samplingFreq, subjectData);
        else
            % Throw error
            uialert(fig,"Selection of Temporal Normalisaton is needed for data syncrhonisation.","Invalid Parameter Selection");
            dataSynchronizationCheckBox.Value = 0;
            checkedBoxes(4) = 0;
        end
    end

    displayTabs(subjectId, subjectData, timeVector);

    function displayTabs(subjectId, subjectData, timeVector)
        % delete previous displayPanelGrid
        delete(displayPanelGrid);

        % create new displayPanelGrid
        displayPanelGrid = uigridlayout(displayPanel, [3, 1]);
        displayPanelGrid.RowSpacing = 20;
        displayPanelGrid.ColumnWidth = {'1x', 22};
        displayPanelGrid.BackgroundColor = "white";
        displayPanelGrid.Padding = [50 50 50 50];

        % plot for A
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 1; 
        ax.Layout.Column = 1; 
        if checkedBoxes(5) == 1
            doDetectionOfEvents(ax, subjectId, 'A', timeVector, subjectData.A, '-b');
        else
            plot(ax, timeVector, subjectData.A)
            titleName = sprintf('Preprocessed data of Subject %.f - Condition A for 30 trials', subjectId);
            title(ax, titleName);
            xlabel(ax, 'Time (s)');
            ylabel(ax, 'Knee Angle (degree)');
        end

        % plot for B
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 2; 
        ax.Layout.Column = 1; 
        if checkedBoxes(5) == 1
            doDetectionOfEvents(ax, subjectId, 'B', timeVector, subjectData.B, '-r');
        else
            plot(ax, timeVector, subjectData.B)
            titleName = sprintf('Preprocessed data of Subject %.f - Condition B for 30 trials', subjectId);
            title(ax, titleName);
            xlabel(ax, 'Time (s)');
            ylabel(ax, 'Knee Angle (degree)');
        end

        % plot for C
        ax = uiaxes(displayPanelGrid);
        ax.Layout.Row = 3; 
        ax.Layout.Column = 1; 
        if checkedBoxes(5) == 1
            doDetectionOfEvents(ax, subjectId, 'C', timeVector, subjectData.C, '-g');
        else
            plot(ax, timeVector, subjectData.C)
            titleName = sprintf('Preprocessed data of Subject %.f - Condition C for 30 trials', subjectId);
            title(ax, titleName);
            xlabel(ax, 'Time (s)');
            ylabel(ax, 'Knee Angle (degree)');
        end
    end
end
