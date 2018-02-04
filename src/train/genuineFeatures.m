%> This function returns a genuine signature's features auto-generated array.
%>
%> @param userFeatures   user's signatures' features table
%> @param range          multipliers array
%>
%> @retval trainFeatures geunine signature's features auto-generated array
%>
%> @author Andrea Sergas Donato Meoli
function [trainFeatures] = genuineFeatures(userFeatures, range)

sizeFeatures = size(userFeatures);
rowsFeatures = sizeFeatures(1);
featuresNumber = sizeFeatures(2);
sizeRange = size(range);
sizeRange = sizeRange(2);

trainFeatures = zeros(rowsFeatures * sizeRange, featuresNumber);

for i = 1 : sizeRange
    trainFeatures((i-1) * rowsFeatures + 1 : i * rowsFeatures, 1 : 14) = userFeatures(:, 1 : 14) * range(i);
    trainFeatures((i-1) * rowsFeatures + 1 : i * rowsFeatures, 15 : 16) = userFeatures(:, 15 : 16);
end

end