%> This function returns the genuine and forgery scores for all users.
%>
%> @param sessionNumber    session number for train
%> @param usersNumber      users number
%> @param signaturesNumber signatures number
%>
%> @retval scoresGenuine   scores of the genuine tests
%> @retval scoresForgery   scores of the forgery tests
%> @retval thresholds      all users' thresholds
%> @retval SVMStruct       SVM structure containing all the users' SVM
%>
%> @author Andrea Sergas Donato Meoli
function [scoresGenuine, scoresForgery, thresholds, SVMStruct] = scores(sessionNumber, usersNumber, signaturesNumber)

[SVMStruct, thresholds] = SVMs(true, sessionNumber, usersNumber, signaturesNumber);
actualUsersNumber = size(thresholds);
actualUsersNumber = actualUsersNumber(2);
scoresGenuine = zeros(actualUsersNumber, signaturesNumber);
scoresForgery = zeros(actualUsersNumber, signaturesNumber);
scoresIndex = 1;

if (sessionNumber == 1)
    testSessionNumber = 2;
elseif (sessionNumber == 2)
    testSessionNumber = 1;
end

for i = 1 : usersNumber
    genuineFeatures = userFeatures(true, testSessionNumber, i, signaturesNumber);
    forgeryFeatures = userFeatures(false, 0, i, signaturesNumber);
    
    if (genuineFeatures == -1)
        continue
    end
    
    [currentScoreGenuine, currentScoreForgery] = userScores(SVMStruct(scoresIndex).svm, genuineFeatures, forgeryFeatures);
    scoresGenuine(scoresIndex, 1 : signaturesNumber) = transpose(currentScoreGenuine);
    scoresForgery(scoresIndex, 1 : signaturesNumber) = transpose(currentScoreForgery);
    scoresIndex = scoresIndex + 1;
end

end