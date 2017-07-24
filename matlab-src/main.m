if (strcmp(computer('arch'), 'win64')) 
    slash = '\';
else
    slash = '/';
end

addpath(strcat(pwd, slash, 'features-extraction'));
addpath(strcat(pwd, slash, 'signature-acquisition'));
addpath(strcat(pwd, slash, 'test'));
addpath(strcat(pwd, slash, 'train'));
addpath(strcat(pwd, slash, 'utility'));

% 2-fold cross-validation
[scoresGenuine1, scoresForgery1, thresholds, SVMStruct1] = scores(1, 115, 10);
thresholds1 = transpose(thresholds);
[scoresGenuine2, scoresForgery2, thresholds, SVMStruct2] = scores(2, 115, 10);
thresholds2 = transpose(thresholds);

% Calculating FRR and FAR
[usersFRR, usersFAR] = usersEvaluation(scoresGenuine1, scoresGenuine2, scoresForgery1, scoresForgery2, thresholds1, thresholds2);

% Print FRR and FAR
fprintf('Total FRR: %.2f%%.\n', mean(usersFRR) * 100);
fprintf('Total FAR: %.2f%%.\n\n', mean(usersFAR) * 100);
