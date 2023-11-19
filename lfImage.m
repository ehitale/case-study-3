load("lightField.mat")

figure;
[img, x, y] = rays2img(rays(1, :), rays(3, :), .005, 200);
% A 'sharper' image cannot be obtained by changing the sensor width, or the amount of pixels alone.   

imshow(img);
% I can't really make out what's this is supposed to be a picture of. I see black and white splotches, but other than that it's unclear. 

prop_2 = [ 
    1, d, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, d;
    0, 0, 0, 1
    ]; % 'd' is that of rayTracing.m

figure;
propogatedRays = prop_2 * rays;

[propImg, propX, propY] = rays2img(propogatedRays(1, :), propogatedRays(3, :), .005, 200);

imshow(propImg)
% There doens't appear to be a value of d that generates a clear image. 

% It may not be possible to create a clear image by changing the
% propogation matrix because we aren't focusing the rays with a lens. I
% think the splotchy nature of the image is due to various rays just being
% not being represented in the image because they escaped the sensor. 

%% Image System
