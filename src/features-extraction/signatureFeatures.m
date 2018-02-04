%> This function returns the signature's features.
%>
%> @param x            scaled cursor position along the x-axis
%> @param y            scaled cursor position along the y-axis
%> @param timestamp    system time at which the event was posted
%> @param pressure     adjusted state of the normal pressure in milliseconds
%>
%> @retval sigFeatures signature's features array
%>
%> @author Andrea Sergas Donato Meoli
function [sigFeatures] = signatureFeatures(x, y, timestamp, pressure)

sizeFeatures = size(x);
sizeFeatures = sizeFeatures(2);

displacement = zeros(1, sizeFeatures);
velocity = zeros(1, sizeFeatures);
acceleration = zeros(1, sizeFeatures);
angles = zeros(1, sizeFeatures);
pressureVariations = zeros(1, sizeFeatures);
timeVariations = zeros(1, sizeFeatures);
originAngles = zeros(1, sizeFeatures);
pathLength = 0;

for i = 1 : sizeFeatures - 1
    displacement(i) = sqrt((y(i+1) - y(i))^2 + (x(i+1) - x(i))^2);
    velocity(i) = displacement(i) / (timestamp(i+1) - timestamp(i));
    acceleration(i) = velocity(i) / (timestamp(i+1) - timestamp(i));
    angles(i) = atan2(y(i+1) - y(i), x(i+1) - x(i));
    pressureVariations(i) = pressure(i+1) - pressure(i);
    timeVariations(i) = timestamp(i+1) - timestamp(i);
    originAngles(i) = atan2(y(i) - 0, x(i) - 0);
    pathLength = pathLength + displacement(i);
end

displacement(i) = displacement(i-1);
velocity(i) = velocity(i-1);
acceleration(i) = acceleration(i-1);
angles(i) = angles(i-1);
pressureVariations(i) = pressureVariations(i-1);
timeVariations(i) = timeVariations(i-1);
originAngles(i) = atan2(y(i) - 0, x(i) - 0);
totalTime = timestamp(sizeFeatures) - timestamp(1);

sigFeatures = [mean(displacement), mean(velocity), mean(acceleration), mean(angles), mean(pressureVariations), ...
               mean(timeVariations), mean(originAngles), std(displacement), std(velocity), std(acceleration), ...
               std(angles), std(pressureVariations), std(timeVariations), std(originAngles), pathLength, totalTime];


end
