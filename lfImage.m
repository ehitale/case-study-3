load("lightField.mat") % rays is in meters

figure;
histogram(rays(1, :));
title "x"

brookings = rays(:, (rays(1, :) <= 0.01) & rays(1, :) >= -0.049);
% brookings(1, :) = brookings(1, :) + 83;
avocado = rays(:, (rays(1, :) <= 0.01 & rays(1, :) >= -0.01));
logo = rays(:, (rays(1, :) >= 0.03));

% 'brookings', 'avocado', and 'logo' are all logically indexed portions
% of rays. 

figure;
[img_initial, ~, ~] = rays2img(logo(1, :), logo(3, :), .25, 1000);
% A 'sharper' image cannot be obtained by changing the sensor width, or the amount of pixels alone.   
% Do something to img_initial so that you just have the lit up values for 

rowCount = 0;
rowIndices = zeros(1, size(img_initial, 1));
columnCount = 0;

for i = 1:size(img_initial, 1)
    if (sum(img_initial(i, :) ~= 0))
        if (rowCount < sum(img_initial(i, :) ~= 0))
            rowCount = sum(img_initial(i, :) ~= 0);
        end
    end
end

for j = 1:size(img_initial, 2) 
    if (sum(img_initial(:, j) ~= 0))
        if (columnCount < sum(img_initial(:, j) ~= 0))
            columnCount = sum(img_initial(:, j) ~= 0);
        end
    end
end

fittedImage = zeros(rowCount, columnCount);

for i = 1:rowCount
    for j = 1:size(img_initial, 1)
        if (sum(img_initial(j, :) ~= 0))
            fittedImage(1, :) = img_initial(j, :)
        end
    end
end

% The code above is supposed to index the initial image with the parameters
% defined by the fitted image. 

imshow(img_initial);
title("initial");
hold off;

% I can't really make out what's this is supposed to be a picture of. I see black and white splotches, but other than that it's unclear. 

% prop_2 = [ 
%     1, d_1, 0, 0;
%     0, 1, 0, 0;
%     0, 0, 1, d_1;
%     0, 0, 0, 1
%     ]; % 'd' is that of rayTracing.m

% figure;
% propogatedRays = prop_2 * rays;
% 
% [propImg, propX, propY] = rays2img(propogatedRays(1, :), propogatedRays(3, :), .005, 200);
% 
% imshow(propImg)
% title("propImg")

% There doens't appear to be a value of d that generates a clear image. 

% It may not be possible to create a clear image by changing the
% propogation matrix because we aren't focusing the rays with a lens. I
% think the splotchy nature of the image is due to various rays just being
% not being represented in the image because they escaped the sensor. 

%% Image System
% d_1_var = 5; % 10 millimeters, 1 cm.
% d_2_var = 0.01; % 10 millimeters, 1 cm.

% Example matrices, not currently in use.
% m_prop_1 = [ 
%     1, d_1_var, 0, 0;
%     0, 1, 0, 0;
%     0, 0, 1, d_1_var;
%     0, 0, 0, 1
%     ];
% 
% lens = [
%     1, 0, 0, 0;
%     -1/f_var, 1, 0, 0;
%     0, 0, 1, 0;
%     0, 0, -1/f_var, 1
%     ];
% 
% m_prop_2 = [
%     1, d_2_var, 0, 0;
%     0, 1, 0, 0;
%     0, 0, 1, d_2_var;
%     0, 0, 0, 1
%     ];

% figure;
% % for d_1_var = 0.02:0.01:10
%     for d_2_var = 0.02:0.01:10
% 
%         m_prop_1 = [
%             1, d_1_var, 0, 0;
%             0, 1, 0, 0;
%             0, 0, 1, d_1_var;
%             0, 0, 0, 1
%         ];
% 
%         f_var = (1/(d_1_var) + 1/(d_2_var))^(-1);
% 
%         lens = [
%             1, 0, 0, 0;
%             -1/f_var, 1, 0, 0;
%             0, 0, 1, 0;
%             0, 0, -1/f_var, 1
%         ];
% 
%         m_prop_2 = [
%             1, d_2_var, 0, 0;
%             0, 1, 0, 0;
%             0, 0, 1, d_2_var;
%             0, 0, 0, 1
%         ];
% 
%         imageSystem = m_prop_2 * (lens * m_prop_1);  
% 
%         image = imageSystem * rays;
% 
%         [img, x, y] = rays2img(image(1, :), image(3, :), .005, 800);
%         imshow(img)
%         title("img");
%         hold off;
% 
%     end
% % end

% The code above will iterate through of d1 and d2 at a rate of 0.01
% meters. It has been commented out for brevity, as it would constitute
% multiple pages on its own. 
figure;

final_prop_1 = [
        1, 5, 0, 0;
        0, 1, 0, 0;
        0, 0, 1, 5;
        0, 0, 0, 1
    ];

f_final = (1/1 + 1/5)^(-1);

final_lens = [
        1, 0, 0, 0;
        -1/f_final, 1, 0, 0;
        0, 0, 1, 0;
        0, 0, -1/f_final, 1
    ];

final_prop_2 = [
        1, 1, 0, 0;
        0, 1, 0, 0;
        0, 0, 1, 1;
        0, 0, 0, 1
    ];

% d_2 = 1 meters, f = 5/6 meters, assuming that d_1 is 5 meters.

imageSystem = final_prop_2 * (final_lens * final_prop_1);
image = 2 * imageSystem * rays;
[img, x, y] = rays2img(image(1, :), image(3, :), .005, 800);
imshow(img);
hold off;

% The image above appears to be depicting an avocado reclining in a chair,
% perhaps speaking to a therapist.

%% Locating three images - Competition
% figure;
% 
% avo_prop_1 = [
%         1, 5, 0, 0;
%         0, 1, 0, 0;
%         0, 0, 1, 5;
%         0, 0, 0, 1
%     ];
% 
% f_final = (1/1 + 1/5)^(-1);
% 
% avo_lens = [
%         1, 0, 0, 0;
%         -1/f_final, 1, 0, 0;
%         0, 0, 1, 0;
%         0, 0, -1/f_final, 1
%     ];
% 
% avo_prop_2 = [
%         1, 1, 0, 0;
%         0, 1, 0, 0;
%         0, 0, 1, 1;
%         0, 0, 0, 1
%     ];
% 
% compImageSystem = comp_prop_2 * (comp_lens * comp_prop_1);
% compImage = compImageSystem * rays;
% 
% [img, x, y] = rays2img(compImage(1, :), compImage(3, :), .04, 1500);
% imshow(img(floor(end/3):floor(2*end/3), (1:floor(end/3))));
% figure;
% 
% brook_prop_1 = [
%         1, 5, 0, 0;
%         0, 1, 0, 0;
%         0, 0, 1, 5;
%         0, 0, 0, 1
%     ];
% 
% f_final = (1/1 + 1/5)^(-1);
% 
% brook_lens = [
%         1, 0, 0, 0;
%         -1/f_final, 1, 0, 0;
%         0, 0, 1, 0;
%         0, 0, -1/f_final, 1
%     ];
% 
% brook_prop_2 = [
%         1, 1, 0, 0;
%         0, 1, 0, 0;
%         0, 0, 1, 1;
%         0, 0, 0, 1
%     ];
% 
% compImageSystem = comp_prop_2 * (comp_lens * comp_prop_1);
% compImage = compImageSystem * rays;
% 
% [img, x, y] = rays2img(compImage(1, :), compImage(3, :), .04, 1500);
% imshow(img(floor(end/3):floor(2*end/3), (1:floor(end/3))));
% figure;
% 
% washu_prop_1 = [
%         1, 5, 0, 0;
%         0, 1, 0, 0;
%         0, 0, 1, 5;
%         0, 0, 0, 1
%     ];
% 
% f_final = (1/1 + 1/5)^(-1);
% 
% washu_lens = [
%         1, 0, 0, 0;
%         -1/f_final, 1, 0, 0;
%         0, 0, 1, 0;
%         0, 0, -1/f_final, 1
%     ];
% 
% washu_prop_2 = [
%         1, 1, 0, 0;
%         0, 1, 0, 0;
%         0, 0, 1, 1;
%         0, 0, 0, 1
%     ];
% 
% compImageSystem = comp_prop_2 * (comp_lens * comp_prop_1);
% compImage = compImageSystem * rays;
% 
% [img, x, y] = rays2img(compImage(1, :), compImage(3, :), .04, 1500);
% imshow(img(floor(end/3):floor(2*end/3), (1:floor(end/3))));