function p = cPhantom(n)
%PHANTOMGENERATION Generates phantom using polymask
%   Custom function for phantom generation
%   Input:
%   n - Initial matrix dimension
%   
%   For example: p = cPhantom(256);
%
%
%   Copyright © 2020 Marek Sokol


% Calloc.
p = zeros(n);

% Shepp-logan model
% GrayLevel / MajorAxis / MinorAxis / x0 / y0 / Theta
shep = [  1   .69   .92    0     0     0
    -.8  .6624 .8740   0  -.0184   0
    -.2  .1100 .3100  .22    0    -18
    -.2  .1600 .4100 -.22    0     18
    .1  .2100 .2500   0    .35    0
    .1  .0460 .0460   0    .1     0
    .1  .0460 .0460   0   -.1     0
    .1  .0460 .0230 -.08  -.605   0
    .1  .0230 .0230   0   -.606   0
    .1  .0230 .0460  .06  -.605   0];

% Scale factor
s = length(p)/2;

for i = 1:length(shep)
    xCenter = shep(i, 4)*s + s;
    yCenter = shep(i, 5)*s + s;
    xRadius = shep(i, 2) * s;
    yRadius = shep(i, 3) * s;
    theta = 0:0.01:2*pi;
    x = xRadius * cos(theta) + xCenter;
    y = yRadius * sin(theta) + yCenter;
    tmp = fliplr(rot90(poly2mask(x, y, s*2, s*2), 90));
    tmp = imrotate(tmp, shep(i, 6), 'crop');
    indices = find(tmp >= 1);
    p(indices) = p(indices) + shep(i, 1);
end

end