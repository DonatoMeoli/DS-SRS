%> This function returns a forgery signature's features auto-generated array.
%>
%> @param userFeatures     user's signatures' features table
%>
%> @retval forgeryFeatures forgery signature's features auto-generated array
%>
%> @author Andrea Sergas Donato Meoli
function [forgeryFeatures] = forgeryFeatures(userFeatures)

sizeUserFeatures = size(userFeatures);
forgeryFeatures = zeros(sizeUserFeatures(1), sizeUserFeatures(2));

for i = 1 : sizeUserFeatures(1)
    for j = 1 : sizeUserFeatures(2)
        forgeryFeatures(i, j) = userFeatures(i, j) + var(userFeatures(i, 1 : 14));
    end
end

end