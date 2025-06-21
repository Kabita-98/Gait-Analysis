function app
    clc

    % Get ScreenSize
    screenSize = get(groot, 'ScreenSize');

    % Define app size (Width, Height)
    appWidth = 550;
    appHeight = 500;

    % Calculate position to center the app on the screen
    appX = (screenSize(3) - appWidth) / 2;
    appY = (screenSize(4) - appHeight) / 2;

    % Create the main figure and assign name-value arguments
    fig = uifigure("Name","Movemento");
    fig.Color = "white";
    fig.Position = [appX appY appWidth appHeight];
    fig.Resize = "off"; % Restricting figure size

    % calling loadDataPage to load the first page.
    loadDataPage(fig);
end
