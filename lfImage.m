load("lightField.mat") % rays is in meters

figure;
[img_avocado, ~, ~] = rays2img(avocado(1, :), avocado(3, :), .005, 800);


% A 'sharper' image cannot be obtained by changing the sensor width, or the amount of pixels alone.   

imshow(img_avocado);
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
% histogram(rays(1, :));
% title "x"
% 
% brookings = rays(:, (rays(1, :) <= 0.01) & rays(1, :) >= -0.049);
% logo = rays(:, (rays(1, :) >= 0.03));
% 
% [img_brookings, ~, ~] = rays2img(brookings(1, :), brookings(3, :), .25, 1000);
% [img_logo, ~, ~] = rays2img(logo(1, :), logo(3, :), .25, 1000);


% 'brookings', 'avocado', and 'logo' are all logically indexed portions
% of rays. 


% rows = size(img_initial, 1);
% 
% for i = 1:rows
%     if (sum(img_(i, :) == 0))
%         img_initial(i, :) = [];
%         rows = size(img_initial, 1);
%     end
% end
% 
% columns = size(img_initial, 2);
% 
% for j = 1:columns
%     if (sum(img_initial(:, j) ~= 0))
%         img_initial(:, j) = [];
%         columns = size(img_inital, 2);
%     end
% end

% I was trying to remove the black bars on either side of either image when
% I ran into trouble. As is, the images are not centered, so the function
% rays2img doesn't work as intended. 