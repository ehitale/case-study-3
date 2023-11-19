load("lightField.mat")

figure;
[img, x, y] = rays2img(rays(1, :), rays(3, :), .005, 200);
% A 'sharper' image cannot be obtained by changing the sensor width, or the amount of pixels alone.   

imshow(img);

prop_2 = [ 
    1, .7, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, .7;
    0, 0, 0, 1
    ];

figure;
propogatedRays = prop_2 * rays; % free_space_1 has the same d as rayTracing.

[propImg, propX, propY] = rays2img(propogatedRays(1, :), propogatedRays(3, :), .005, 200);

imshow(propImg)