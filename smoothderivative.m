function smoothderivative(dR, sigma)

size(dR);

G = fspecial('gaussian', [1 5], sigma);

blurred_dR = dR.*G;

size(blurred_dR);

max(max(max(blurred_dR)))
