function ir = cART(sg, theta, niter)
%ITERATIVERECONSTRUCTION Iterative reconstruction
%   Custom function working on a basic principle
%   Inputs:
%   sg - Sinogram (image converted to radon space)
%   theta - Projection angles (in degrees)
%   niter - Number of iterations
%
%   For example: ir = cART(sg, 180, 50);
%
%
%   Copyright © 2020 Marek Sokol


% You can play with steps (deafault 1):
step = 1;

angles = 1:step:theta;
[ir, tdiff] = deal(zeros(length(sg)));

for i = 1:niter
    for j = 1:length(angles)
        tmp = sum(repelem(sg(:, j), 1, length(ir)), 2);
        diff = (tmp - sum(ir, 2)) / length(ir);
        for k = 1:length(ir)
            tdiff(:, k) = diff;
        end
        ir = ir + tdiff;
        ir = imrotate(ir, step, 'bicubic', 'crop');
    end
end

% Crop final image (Optional)
% [h, w] = size(sg);
% ir = imcrop(ir, [(h-w)/2, (h-w)/2, w, w]);

end

