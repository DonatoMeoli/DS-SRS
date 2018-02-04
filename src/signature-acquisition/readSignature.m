%> This function returns all the basic signature features given a specified path.
%>
%> @param               signaturePath signature path
%>
%> @retval x            scaled cursor position along the x-axis
%> @retval y            scaled cursor position along the y-axis
%> @retval timestamp    system time at which the event was posted
%> @retval pressure     adjusted state of the normal pressure in milliseconds
%>
%> @author Andrea Sergas Donato Meoli
function [x, y, timestamp, pressure] = readSignature(signaturePath)

FID = fopen(signaturePath, 'r');

if (FID == -1)
    error(strcat('Could not open signature file: ', signaturePath));
else
    fgets(FID);
    fgets(FID, 10);
    pointsNumber = fscanf(FID, '%d', 1);
    signatureData = fscanf(FID, '%d%d%d%d%d', pointsNumber * 5);
    i = 5 * (0 : pointsNumber - 1);
    x = signatureData(1 + i);
    y = signatureData(2 + i);
    timestamp = signatureData(3 + i);
    pressure = signatureData(4 + i);
end

x = transpose(x);
y = transpose(y);
timestamp = transpose(timestamp);
pressure = transpose(pressure);
fclose(FID);

end
