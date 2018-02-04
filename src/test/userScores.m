%> This function returns the genuine and forgery scores for a user's SVM test.
%>
%> @param SVM             SVM classifier
%> @param genuineFeatures genuine signatures' testing features for the user
%> @param forgeryFeatures forgery signatures' testing features for the user
%>
%> @retval scoreGenuine   score of the genuine test
%> @retval scoreForgery   score of the forgery test
%>
%> @author Andrea Sergas Donato Meoli
function [scoreGenuine, scoreForgery] = userScores(SVM, genuineFeatures, forgeryFeatures)

[~, scoreGenuine] = predict(SVM, genuineFeatures);
[~, scoreForgery] = predict(SVM, forgeryFeatures);

end