function sg = cRadon(img, theta)
%RADONTRASFORM  returns the Radon transform
%   Input:
%   img - Matrix containing sample image to transform
%   theta - Projection angles (in degrees)
%   
%   For example: sg = cRadon(img, 180);
%
%
%   Copyright © 2020 Marek Sokol


% You can play with steps (deafault 1):
step = 1;

angles = 1:step:theta;
sg = zeros(size(img, 1), length(theta));

for i = 1:length(angles)
    sg(:, i) = sum(imrotate(img, -angles(i), 'bilinear', 'crop'));
end

end

