clear all
clc

% Sample script & usage of fces.

% Sample image creation
img = zeros(256);
img(100:156, 100:156) = 255;

% Convert img to radon space
r_img = cRadon(img, 180);

% Reconstruction of the original image 
bp_img = cFBP(r_img, 180);
ir_img = cART(r_img, 180, 1);

% Visualization
tiledlayout(1, 4)
nexttile
imshow(img)
title('Original image')

nexttile
imshow(r_img, [])
title('Converted to radon space')

nexttile
imshow(bp_img, [])
title('Filtered backprojection')

nexttile
imshow(ir_img, [])
title('Iterative reconstruction (1 iter.)')