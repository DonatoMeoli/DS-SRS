%> This function returns the specified signature path.
%>
%> @param isGenuine       true if the signature is GENUINE, false if it is FORGERY
%> @param sessionNumber   if the signature is GENUINE the session can be 1 or 2
%> @param userNumber      user number
%> @param signatureNumber signature number
%>
%> @retval signaturePath  full path of the specified signature
%>
%> @author Andrea Sergas Donato Meoli
function [signaturePath] = signaturePath( isGenuine, sessionNumber, userNumber, signatureNumber)

if (strcmp(computer('arch'), 'win64')) 
    slash = '\';
else
    slash = '/';
end

signaturePath = strcat(fileparts(pwd), slash, 'SUSIG');
userString = num2str(userNumber, '%03d');

if (isGenuine && sessionNumber == 1)
    signaturePath = strcat(signaturePath, slash, 'GENUINE', slash, 'SESSION1', slash, userString, '_1_');  
elseif (isGenuine && sessionNumber == 2)
    signaturePath = strcat(signaturePath, slash, 'GENUINE', slash, 'SESSION2', slash, userString, '_2_'); 
else
    signaturePath = strcat(signaturePath, slash, 'FORGERY', slash, userString, '_f_');
end

signaturePath = strcat(signaturePath, num2str(signatureNumber), '.sig');

end
