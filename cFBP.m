function bp = cFBP(sg, theta)
%FILTEREDBACKPROJECTION Filtered backrpojection
%   Custom function working on a basic principle 
%   Filtered backprojection using ramlak triangular filter
%   Inputs:
%   sg - Sinogram (image converted to radon space)
%   theta - Projection angles (in degrees)
%
%   For example: bp = cFBP(sg, 180);
%
%
%   Copyright © 2020 Marek Sokol


% You can play with steps (deafault 1):
step = 1;

angles = 1:step:theta;
bp = zeros(length(sg));
% tmp = bp;

% You can comment the filter below and use it as simple backprojection
ramlak = abs(linspace(-1, 1, length(sg))');
% ramlak = repmat(ramlak, [1 length(angles)]);

fft_R = fftshift(fft(sg, [], 1), 1);
filtproj = ifftshift(fft_R .* ramlak, 1);
sg = real(ifft(filtproj, [], 1));

for i = 1:length(angles)
    % % Approach 1. using forcycle
    %     for j = 1:length(sg)
    %         tmp(:, j) = sg(:, i);
    %     end
    %     tmp = imrotate(tmp, angles(i), 'bilinear', 'crop');
    %     bp = bp + tmp;
    % % Approach 2. using repmat() or repelem()
    % tmp = repmat(sg(:, i), 1, length(sg));
    tmp = repelem(sg(:, i), 1, length(sg));
    tmp = imrotate(tmp, angles(i), 'bilinear', 'crop');
    bp = bp + tmp;
end

% Crop final image (Optional)
% [h, w] = size(sg);
% bp = imcrop(bp, [(h-w)/2, (h-w)/2, w, w]);

end
