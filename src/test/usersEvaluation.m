%> This function returns the users' FRR and FAR.
%>
%> @param scoresGenuine1 scores of the genuine tests for first fold of cross-validation
%> @param scoresGenuine2 scores of the genuine tests for second fold of cross-validation
%> @param scoresForgery1 scores of the forgery tests for first fold of cross-validation
%> @param scoresForgery2 scores of the forgery tests for second fold of cross-validation
%> @param thresholds1    thresholds for all users for first fold of cross-validation
%> @param thresholds2    thresholds for all users for second fold of cross-validation
%>
%> @retval usersFRR      all users' FRR
%> @retval usersFAR      all users' FAR
%>
%> @author Andrea Sergas Donato Meoli
function [usersFRR, usersFAR] = usersEvaluation(scoresGenuine1, scoresGenuine2, scoresForgery1, scoresForgery2, ...
                                                thresholds1, thresholds2)

sizeScores = size(scoresGenuine1);
usersNumber = sizeScores(1);
signaturesNumber = sizeScores(2);

usersFRR = zeros(1, usersNumber);
usersFAR = zeros(1, usersNumber);

for i = 1 : usersNumber
    FRRCounter = 0;
    FARCounter = 0;
    threshold1 = thresholds1(i);
    threshold2 = thresholds2(i);
    
    for j = 1 : signaturesNumber
        if (scoresGenuine1(i, j) < threshold1)
            FRRCounter = FRRCounter + 1;
        end
        
        if (scoresGenuine2(i, j) < threshold2)
            FRRCounter = FRRCounter + 1;
        end
        
        if (scoresForgery1(i, j) >= threshold1)
            FARCounter = FARCounter + 1;
        end
        
        if (scoresForgery2(i, j) >= threshold2)
            FARCounter = FARCounter + 1;
        end
    end
    
    usersFRR(i) = FRRCounter / (signaturesNumber * 2);
    usersFAR(i) = FARCounter / (signaturesNumber * 2);
end

end
