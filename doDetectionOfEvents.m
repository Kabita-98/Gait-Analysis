function doDetectionOfEvents(ax, subjectId, condition, timeVector, data, color)
    % data = 30 X 250
    meanData = mean(data, 1);
    stdData = std(data, 1);
    upperBound = meanData + stdData;
    lowerBound = meanData - stdData;
    
    if color == "-b"
        patchColor = [0, 0.4470, 0.7410];
    elseif color == "-r"
        patchColor = [0.8500, 0.3250, 0.0980];
    else
        patchColor = [0.4660, 0.6740, 0.1880];
    end

    firstNonNanIdx = sum(isnan(meanData)) + 1;
    totalDuration = timeVector(end) - timeVector(firstNonNanIdx);
    zeroNormalizedTime = linspace(0, totalDuration, length(timeVector)-firstNonNanIdx+1);
    
    stancePhasePerc = 0.6;
    loadingResponsePerc = 0.1;
    midStancePerc = 0.3;
    terminalStancePerc = 0.5;
    initialSwingPerc = 0.73;
    midSwingPerc = 0.87;
    
    stanceTime = totalDuration * stancePhasePerc;
    [~, stanceIdx] = min(abs(zeroNormalizedTime - stanceTime)); 
    
    loadingResponseTime = totalDuration * loadingResponsePerc;
    [~, loadingResponseIdx] = min(abs(zeroNormalizedTime - loadingResponseTime)); 
    
    midStanceTime = totalDuration * midStancePerc;
    [~, midStanceIdx] = min(abs(zeroNormalizedTime - midStanceTime)); 
    
    terminalStanceTime = totalDuration * terminalStancePerc;
    [~, terminalStanceIdx] = min(abs(zeroNormalizedTime - terminalStanceTime)); 
    
    initialSwingTime = totalDuration * initialSwingPerc;
    [~, initialSwingIdx] = min(abs(zeroNormalizedTime - initialSwingTime)); 
    
    midSwingTime = totalDuration * midSwingPerc;
    [~, midSwingIdx] = min(abs(zeroNormalizedTime - midSwingTime)); 
    
    notNanMeanData = meanData(firstNonNanIdx:end);
    notNanUpperBound = upperBound(firstNonNanIdx:end);
    notNanLowerBound = lowerBound(firstNonNanIdx:end);
    
    textHeight = 45;
    if condition == 'A'
        textHeight = 55;
    end
    
    colors = [0, 0.4470, 0.7410; 0.8500, 0.3250, 0.0980; 0.4660, 0.6740, 0.1880];
    ax.ColorOrder = colors;
    plot(ax, zeroNormalizedTime, notNanMeanData, 'LineWidth', 2);
    hold(ax, "on");
    plot(ax, [0, stanceTime], [textHeight+5, textHeight+5], '--k');
    plot(ax, [stanceTime, totalDuration], [textHeight/2, textHeight/2], '--k');

    titleName = sprintf('Preprocessed data of Subject %.f - Condition %s for 30 trials', subjectId, condition);
    title(ax, titleName);
    xlabel(ax, 'Time (s)');
    ylabel(ax, 'Knee Angle (degree)');
    x = [zeroNormalizedTime, fliplr(zeroNormalizedTime)];
    y = [notNanUpperBound fliplr(notNanLowerBound)];
    patch(ax, x, y, patchColor, "Facealpha", 0.3);

    x = [0.3 0.5];
    y = [0.6 0.5];    
    text(ax, stanceTime/2, textHeight+10, "Stance Phase");
    text(ax, (totalDuration-stanceTime)/2 + stanceTime, textHeight/2+10, "Swing Phase");
    text(ax, loadingResponseTime/2, textHeight, "LR");
    text(ax, (midStanceTime-loadingResponseTime)/2 + loadingResponseTime, textHeight, "MSt");
    text(ax, (terminalStanceTime-midStanceTime)/2 + midStanceTime, textHeight, "TSt");
    text(ax, (stanceTime-terminalStanceTime)/2 + terminalStanceTime, textHeight, "PS");
    text(ax, (initialSwingTime-stanceTime)/2 + stanceTime, textHeight, "IS");
    text(ax, (midSwingTime-initialSwingTime)/2 + initialSwingTime, textHeight, "MS");
    text(ax, (totalDuration-midSwingTime)/2 + midSwingTime, textHeight, "TS");
    
    xline(ax, zeroNormalizedTime(stanceIdx), 'LineWidth',2);
    xline(ax, zeroNormalizedTime(loadingResponseIdx));
    xline(ax, zeroNormalizedTime(midStanceIdx));
    xline(ax, zeroNormalizedTime(terminalStanceIdx));
    xline(ax, zeroNormalizedTime(initialSwingIdx));
    xline(ax, zeroNormalizedTime(midSwingIdx));
    
end