%> This function returns the SVM and the threshold for every user.
%>
%> @param isGenuine        true if the signature is GENUINE, false if it is FORGERY
%> @param sessionNumber    if the signature is GENUINE the session can be 1 or 2
%> @param usersNumber      user number
%> @param signaturesNumber signatures number
%>
%> @retval SVMStruct       structure containing all the users' SVMs
%> @retval thresholds      array containing all the users' thresholds
%>
%> @author Andrea Sergas Donato Meoli
function [SVMStruct, thresholds] = SVMs(isGenuine, sessionNumber, usersNumber, signaturesNumber)

emptyStruct = struct();
SVMTempStruct = repmat(emptyStruct, 1, usersNumber);
thresholds = zeros(1, usersNumber);
currentIndex = 1;

for i = 1 : usersNumber
    currentUserFeatures = userFeatures(isGenuine, sessionNumber, i, signaturesNumber);
    
    if (currentUserFeatures == -1)
        continue
    end
    
    [currentUserSVM, currentThreshold] = userSVM(currentUserFeatures);
    SVMTempStruct(currentIndex).svm = currentUserSVM;
    thresholds(currentIndex) = currentThreshold;
    currentIndex = currentIndex + 1;
end

SVMStruct = repmat(emptyStruct, 1, currentIndex - 1);

for i = 1 : currentIndex - 1
    SVMStruct(i).svm = SVMTempStruct(i).svm;
end

thresholds = thresholds(thresholds ~= 0);

end