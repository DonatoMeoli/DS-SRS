%> This function returns the SVM classifier and the threshold array for a user.
%>
%> @param userFeatures user's signatures' features table
%>
%> @retval SVM         SVM classifier
%> @retval threshold   user's threshold
%>
%> @author Andrea Sergas Donato Meoli
function [SVM, threshold] = userSVM(userFeatures)

sizeUserFeatures = size(userFeatures);
sizeUserFeatures = sizeUserFeatures(1);
startRange = 1;
endRange = startRange + floor((sizeUserFeatures - 1) / 2) * 1e-1;

range = linspace(startRange, endRange, sizeUserFeatures - 1);
genFeatures = genuineFeatures(userFeatures, range);
forgFeatures = forgeryFeatures(genFeatures);
sizeGenuine = size(genFeatures);
class = ones(sizeGenuine(1), 1);

SVM = fitcsvm(genFeatures, class, 'KernelScale', 'auto', 'Standardize', true);
[~, scoresForgery] = predict(SVM, forgFeatures);
threshold = max(scoresForgery) + 1e-7;
SVM = compact(SVM);

end
