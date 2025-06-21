function analyseMaxKneeAngle(analysisPanel, subjectList, conditionList, A, B, C, type)

    % Create grid for analysis
    analysisGrid = uigridlayout(analysisPanel, [2 1]);
    analysisGrid.BackgroundColor = "white";
    analysisGrid.RowHeight = {'1x', '1x'};

    % Create two panels for ttest and anova analysis
    ttestPanel = uipanel(analysisGrid, "Title", "T-test");
    ttestPanel.Layout.Row = 1;
    ttestPanel.BackgroundColor = "white";
    ttestPanel.TitlePosition = "centertop";
    ttestPanel.BorderType = "none";
    ttestPanel.FontSize = 16;

    anovaPanel = uipanel(analysisGrid, "Title", "Analysis of Variance (ANOVA)");
    anovaPanel.Layout.Row = 2;
    anovaPanel.BackgroundColor = "white";
    anovaPanel.TitlePosition = "centertop";
    anovaPanel.BorderType = "none";
    anovaPanel.FontSize = 16;

    % Create grid layout for ttestPanel
    ttestPanelGrid = uigridlayout(ttestPanel, [1 2]);
    ttestPanelGrid.ColumnWidth = {'1.2x', '0.8x'};
    ttestPanelGrid.BackgroundColor = "white";
    
    % Create grid layout for ttest results
    ttestResultGrid = uigridlayout(ttestPanelGrid, [5, 2]);
    ttestResultGrid.Layout.Row = 1;
    ttestResultGrid.Layout.Column = 2;
    ttestResultGrid.RowHeight = {50, 50, 20, 20, '1x'};
    ttestResultGrid.ColumnWidth = {80, '1x'};
    ttestResultGrid.Padding = [0 0 0 0];
    ttestResultGrid.BackgroundColor = "white";

    % Create grid layout for ttestPlot
    ttestPlotGrid = uigridlayout(ttestPanelGrid, [2 5]);
    ttestPlotGrid.Layout.Row = 1;
    ttestPlotGrid.Layout.Column = 1;
    ttestPlotGrid.Padding = [0 0 0 0];
    ttestPlotGrid.RowHeight = {'1x', 30};
    ttestPlotGrid.ColumnWidth = {80, 100 , '1x', 80, 100};
    ttestPlotGrid.BackgroundColor = "white";

    % Create UI components for ttestPlot
    ttestAxes = uiaxes(ttestPlotGrid);
    ttestAxes.Layout.Row = 1;
    ttestAxes.Layout.Column = [1 5];

    ttestConditionDropDownLabel1 = uilabel(ttestPlotGrid, 'Text', "Condition 1:");
    ttestConditionDropDownLabel1.Layout.Row = 2;
    ttestConditionDropDownLabel1.Layout.Column = 1;
    ttestConditionDropDownLabel1.FontWeight = "bold";

    ttestConditionDropDown1 = uidropdown(ttestPlotGrid);
    ttestConditionDropDown1.Items = conditionList;
    ttestConditionDropDown1.ItemsData = 1:3;
    ttestConditionDropDown1.BackgroundColor = "white";

    ttestConditionDropDownLabel2 = uilabel(ttestPlotGrid, 'Text', "Condition 2:");
    ttestConditionDropDownLabel2.Layout.Row = 2;
    ttestConditionDropDownLabel2.Layout.Column = 4;
    ttestConditionDropDownLabel2.FontWeight = "bold";

    ttestConditionDropDown2 = uidropdown(ttestPlotGrid);
    ttestConditionDropDown2.Items = conditionList;
    ttestConditionDropDown2.ItemsData = 1:3;
    ttestConditionDropDown2.BackgroundColor = "white";
    

    % Behavior for changing drop down
    ttestConditionDropDown1.ValueChangedFcn = @(src, event)changeAnalysis(src, event, ttestConditionDropDown1, ttestConditionDropDown2);
    ttestConditionDropDown2.ValueChangedFcn = @(src, event)changeAnalysis(src, event, ttestConditionDropDown1, ttestConditionDropDown2);



     % Create grid layout for anovaPanel
    anovaPanelGrid = uigridlayout(anovaPanel, [1 2]);
    anovaPanelGrid.ColumnWidth = {'1.2x', '0.8x'};
    anovaPanelGrid.BackgroundColor = "white";

    % Create grid layout for anova results
    anovaResultGrid = uigridlayout(anovaPanelGrid, [7, 2]);
    anovaResultGrid.Layout.Row = 1;
    anovaResultGrid.Layout.Column = 2;
    anovaResultGrid.RowHeight = {32, 32, 28, 28, 16, 16, '1x'};
    anovaResultGrid.ColumnWidth = {80, '1x'};
    anovaResultGrid.Padding = [0 0 0 0];
    anovaResultGrid.BackgroundColor = "white";

    % Create UI components for anovaPlot
    anovaAxes = uiaxes(anovaPanelGrid);
    anovaAxes.Layout.Row = 1;
    anovaAxes.Layout.Column = 1;


    % Default Behavior
    ttestConditionDropDown2.Value = 2;
    condition1 = 1;
    condition2 = 2;
    
    if type == 'maxKneeAngle'
        [tmaxKneeAngleData, th, tp, tt] = doMaxKneeTtest(condition1, condition2, A, B, C);
        [amaxKneeAngleData, ap, af, explainedVar, unexplainedVar] = doMaxKneeAnova(A, B, C);
        plotTtestResults(ttestAxes, ttestPanelGrid, tmaxKneeAngleData, th, tp, tt, condition1, condition2);
        plotAnovaResults(anovaAxes, anovaPanelGrid, amaxKneeAngleData, ap, af, explainedVar, unexplainedVar);
    elseif type == 'swingPhase'
        [tswingPhaseData, th, tp, tt] = doSwingTtest(condition1, condition2, A, B, C);
        [aswingPhaseData, ap, af, explainedVar, unexplainedVar] = doSwingPhaseAnova(A, B, C);
        plotTtestResults(ttestAxes, ttestPanelGrid, tswingPhaseData, th, tp, tt, condition1, condition2);
        plotAnovaResults(anovaAxes, anovaPanelGrid, aswingPhaseData, ap, af, explainedVar, unexplainedVar);
    end

    


    % Create function for changing ttestanalysis
    function changeAnalysis(src, event, ttestConditionDropDown1, ttestConditionDropDown2)
        condition1 = ttestConditionDropDown1.Value;
        condition2 = ttestConditionDropDown2.Value;

        if type == 'maxKneeAngle'
            [tmaxKneeAngleData, th, tp, tt] = doMaxKneeTtest(condition1, condition2, A, B, C);
            [amaxKneeAngleData, ap, af, explainedVar, unexplainedVar] = doMaxKneeAnova(A, B, C);
            plotTtestResults(ttestAxes, ttestPanelGrid, tmaxKneeAngleData, th, tp, tt, condition1, condition2);
            plotAnovaResults(anovaAxes, anovaPanelGrid, amaxKneeAngleData, ap, af, explainedVar, unexplainedVar);
        elseif type == 'swingPhase'
            [tswingPhaseData, th, tp, tt] = doSwingTtest(condition1, condition2, A, B, C);
            [aswingPhaseData, ap, af, explainedVar, unexplainedVar] = doSwingPhaseAnova(A, B, C);
            plotTtestResults(ttestAxes, ttestPanelGrid, tswingPhaseData, th, tp, tt, condition1, condition2);
            plotAnovaResults(anovaAxes, anovaPanelGrid, aswingPhaseData, ap, af, explainedVar, unexplainedVar);
        end
    end

    function plotTtestResults(ax, panelGrid, data, h, p, t, condition1, condition2)
        boxchart(ax, data);
        title(ax, "Comparative box chart for two different condition");
        xlabel(ax, "Conditions");
        ylabel(ax, "Knee Angle (Degree)");
        
        if condition1 == 1 && condition2 == 1
            conditionNames = {'A', 'A'};
        elseif condition1 == 1 && condition2 == 2
            conditionNames = {'A', 'B'};
        elseif condition1 ==1 && condition2 == 3
            conditionNames = {'A', 'C'};
        elseif condition1 == 2 && condition2 == 1
            conditionNames = {'B', 'A'};
        elseif condition1 == 2 && condition2 == 2
            conditionNames = {'B', 'B'};
        elseif condition1 == 2 && condition2 ==3
            conditionNames = {'B' , "C"};
        elseif condition1 == 3 && condition2 == 1
            conditionNames = {'C', 'A'};
        elseif condition1 == 3 && condition2 == 2
            conditionNames = {'C', 'B'};
        elseif condition1 == 3 && condition2 == 3
            conditionNames = {'C', 'C'};
        end
        xticklabels(ax, conditionNames);

        if h == 1
            resultText = "NULL HYPOTHESIS REJECTED";
        else
            resultText = "NULL HYPOTHESIS ACCEPTED";
        end

        % Create grid layout for ttest results
        resGrid = uigridlayout(panelGrid, [5, 2]);
        resGrid.Layout.Row = 1;
        resGrid.Layout.Column = 2;
        resGrid.RowHeight = {50, 50, 20, 20, '1x'};
        resGrid.ColumnWidth = {80, '1x'};
        resGrid.Padding = [0 0 0 0];
        resGrid.BackgroundColor = "white";
        
        nullHypothesisTitleLabel = uilabel(resGrid, "Text", "Null Hypothesis:");
        nullHypothesisTitleLabel.WordWrap = "on";
        nullHypothesisTitleLabel.Layout.Row = 1;
        nullHypothesisTitleLabel.Layout.Column = 1;
        nullHypothesisTitleLabel.FontWeight = "bold";

        nullHypothesisLabel = uilabel(resGrid);
        nullHypothesisLabel.Text = "Both conditions have equal mean and variances";
        nullHypothesisLabel.WordWrap = "on";
        nullHypothesisLabel.Layout.Row = 1;
        nullHypothesisLabel.Layout.Column = 2;


        alternativeHypothesisTitleLabel = uilabel(resGrid, "Text", "Alternative Hypothesis:");
        alternativeHypothesisTitleLabel.WordWrap = "on";
        alternativeHypothesisTitleLabel.Layout.Row = 2;
        alternativeHypothesisTitleLabel.Layout.Column = 1;
        alternativeHypothesisTitleLabel.FontWeight = "bold";

        alternativeHypothesisLabel = uilabel(resGrid);
        alternativeHypothesisLabel.Text = "Both conditions have unequal mean and variances";
        alternativeHypothesisLabel.WordWrap = "on";
        alternativeHypothesisLabel.Layout.Row = 2;
        alternativeHypothesisLabel.Layout.Column = 2;

        tValueTitleLabel = uilabel(resGrid, "Text", "T value:");
        tValueTitleLabel.WordWrap = "on";
        tValueTitleLabel.Layout.Row = 3;
        tValueTitleLabel.Layout.Column = 1;
        tValueTitleLabel.FontWeight = "bold";

        tValueLabel = uilabel(resGrid);
        tValueLabel.Text = string(t);
        tValueLabel.Layout.Row = 3;
        tValueLabel.Layout.Column = 2;

        pValueTitleLabel = uilabel(resGrid, "Text", "P value: ");
        pValueTitleLabel.WordWrap = "on";
        pValueTitleLabel.Layout.Row = 4;
        pValueTitleLabel.Layout.Column = 1;
        pValueTitleLabel.FontWeight = "bold";

        pValueLabel = uilabel(resGrid);
        pValueLabel.Text = string(p);
        pValueLabel.Layout.Row = 4;
        pValueLabel.Layout.Column = 2;

        resultTitleLabel = uilabel(resGrid, "Text", "Result(Significance Level = 5%)");
        resultTitleLabel.WordWrap = "on";
        resultTitleLabel.Layout.Row = 5;
        resultTitleLabel.Layout.Column = 1;
        resultTitleLabel.FontWeight = "bold";

        resultLabel = uilabel(resGrid);
        resultLabel.Text = resultText;
        resultLabel.Layout.Row = 5;
        resultLabel.Layout.Column = 2;

    end

    function plotAnovaResults(ax, panelGrid, data, p, f, explainedVar, unexplainedVar)
        boxchart(ax, data);
        title(ax, "Comparative box chart for all condition");
        xlabel(ax, "Conditions");
        ylabel(ax, "Knee Angle (Degree)");

        xticklabels(ax, {'A', 'B', 'C'});
        if p < 0.05
            resultText = "NULL HYPOTHESIS REJECTED";
        else
            resultText = "NULL HYPOTHESIS ACCEPTED";
        end
        
        % Create grid layout for anova results
        resGrid = uigridlayout(panelGrid, [7, 2]);
        resGrid.Layout.Row = 1;
        resGrid.Layout.Column = 2;
        resGrid.RowHeight = {32, 32, 28, 28, 16, 16, '1x'};
        resGrid.ColumnWidth = {80, '1x'};
        resGrid.Padding = [0 0 0 0];
        resGrid.BackgroundColor = "white";

        nullHypothesisTitleLabel = uilabel(resGrid, "Text", "Null Hypothesis:");
        nullHypothesisTitleLabel.WordWrap = "on";
        nullHypothesisTitleLabel.Layout.Row = 1;
        nullHypothesisTitleLabel.Layout.Column = 1;
        nullHypothesisTitleLabel.FontWeight = "bold";

        nullHypothesisLabel = uilabel(resGrid);
        nullHypothesisLabel.Text = "Both conditions have equal mean and variances";
        nullHypothesisLabel.WordWrap = "on";
        nullHypothesisLabel.Layout.Row = 1;
        nullHypothesisLabel.Layout.Column = 2;


        alternativeHypothesisTitleLabel = uilabel(resGrid, "Text", "Alternative Hypothesis:");
        alternativeHypothesisTitleLabel.WordWrap = "on";
        alternativeHypothesisTitleLabel.Layout.Row = 2;
        alternativeHypothesisTitleLabel.Layout.Column = 1;
        alternativeHypothesisTitleLabel.FontWeight = "bold";

        alternativeHypothesisLabel = uilabel(resGrid);
        alternativeHypothesisLabel.Text = "Both conditions have unequal mean and variances";
        alternativeHypothesisLabel.WordWrap = "on";
        alternativeHypothesisLabel.Layout.Row = 2;
        alternativeHypothesisLabel.Layout.Column = 2;

        explainedVarTitleLabel = uilabel(resGrid, "Text", "Explained Variance:");
        explainedVarTitleLabel.WordWrap = "on";
        explainedVarTitleLabel.Layout.Row = 3;
        explainedVarTitleLabel.Layout.Column = 1;
        explainedVarTitleLabel.FontWeight = "bold";

        explainedVarLabel = uilabel(resGrid);
        explainedVarLabel.Text = string(explainedVar);
        explainedVarLabel.Layout.Row = 3;
        explainedVarLabel.Layout.Column = 2;

        unExplainedVarTitleLabel = uilabel(resGrid, "Text", "Unexplained Variance:");
        unExplainedVarTitleLabel.WordWrap = "on";
        unExplainedVarTitleLabel.Layout.Row = 4;
        unExplainedVarTitleLabel.Layout.Column = 1;
        unExplainedVarTitleLabel.FontWeight = "bold";

        unExplainedVarLabel = uilabel(resGrid);
        unExplainedVarLabel.Text = string(unexplainedVar);
        unExplainedVarLabel.Layout.Row = 4;
        unExplainedVarLabel.Layout.Column = 2;

        fValueTitleLabel = uilabel(resGrid, "Text", "F Value:");
        fValueTitleLabel.WordWrap = "on";
        fValueTitleLabel.Layout.Row = 5;
        fValueTitleLabel.Layout.Column = 1;
        fValueTitleLabel.FontWeight = "bold";

        fValueLabel = uilabel(resGrid);
        fValueLabel.Text = string(f);
        fValueLabel.Layout.Row = 5;
        fValueLabel.Layout.Column = 2;

        pValueTitleLabel = uilabel(resGrid, "Text", "P Value:");
        pValueTitleLabel.WordWrap = "on";
        pValueTitleLabel.Layout.Row = 6;
        pValueTitleLabel.Layout.Column = 1;
        pValueTitleLabel.FontWeight = "bold";

        pValueLabel = uilabel(resGrid);
        pValueLabel.Text = string(p);
        pValueLabel.Layout.Row = 6;
        pValueLabel.Layout.Column = 2;

        resultTitleLabel = uilabel(resGrid, "Text", "Result(Significance Level = 5%)");
        resultTitleLabel.WordWrap = "on";
        resultTitleLabel.Layout.Row = 7;
        resultTitleLabel.Layout.Column = 1;
        resultTitleLabel.FontWeight = "bold";

        resultLabel = uilabel(resGrid);
        resultLabel.Text = resultText;
        resultLabel.Layout.Row = 7;
        resultLabel.Layout.Column = 2;
    end
end