%> This utility function returns the user's signatures' features table.
%>
%> @param isGenuine        true if the signature is GENUINE, false if it is FORGERY
%> @param sessionNumber    if the signature is GENUINE the session can be 1 or 2
%> @param userNumber       user number
%> @param signaturesNumber signatures number
%>
%> @retval userFeatures    user's signatures' features table
%>
%> @author Andrea Sergas Donato Meoli
function [userFeatures] = userFeatures(isGenuine, sessionNumber, userNumber, signaturesNumber)

featuresNumber = 16;
userFeatures = zeros(signaturesNumber, featuresNumber);

for i = 1 : signaturesNumber
    path = signaturePath(isGenuine, sessionNumber, userNumber, i);
    
    % If the user doesn't exist return -1
    sizeSignature = size(dir(path));
    
    if (sizeSignature(1) == 0)
        userFeatures = -1;
        break
    end
    
    [x, y, timestamp, pressure] = readSignature(path);
    userFeatures(i, :) = signatureFeatures(x, y, timestamp, pressure);
end

end