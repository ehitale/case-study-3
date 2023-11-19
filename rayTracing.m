numberOfAngles = 8;

angles = [linspace(-pi/20, pi/20, numberOfAngles)];

start_0mm = zeros(4, numberOfAngles);
start_10mm = zeros(4, numberOfAngles);

start_0mm(2, :) = angles; % x1 = 0, theta_x_1 = -pi/20 to pi/20, y1 = 0, theta_y_1 = 0;
start_10mm(2, :) = angles;

start_10mm(1, :) = .010;
% matrix of angles

d_1 = 0.2; % millimeters

f = .150; % millimeters

free_space_1 = [
    1, d_1, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, d_1;
    0, 0, 0, 1
    ]; % d_1 represents the distance the rays propogated before the lens. 

lens = [
    1, 0, 0, 0;
    -1/f, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, -1/f, 1
    ]; % lens represents the distance propogated through the lens. 

d_2 = ((1/f) - (1/d_1))^(-1); % millimeters

free_space_2 = [ % solve for the new d
    1, d_2, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, d_2;
    0, 0, 0, 1
    ]; % d_1 represents the distance the rays propogated after the lens. 

figure;

middle_0mm = free_space_1 * start_0mm;
middle_10mm = free_space_1 * start_10mm;

plot([zeros(1, 8); d_1*ones(1, 8)], [start_0mm(1, :); middle_0mm(1, :)], "r");
hold on;

plot([zeros(1, 8); d_1*ones(1, 8)], [start_10mm(1, :); middle_10mm(1, :)], "b");
hold on;

end_0mm = (free_space_2 * lens) * middle_0mm;
end_10mm = (free_space_2 * lens) * middle_10mm;

plot([d_1*ones(1, 8); (d_1 + 0.5)*ones(1, 8)], [middle_0mm(1, :); end_0mm(1, :)], "g");
hold on;

plot([d_1*ones(1, 8); (d_1 + 0.5)*ones(1, 8)], [middle_10mm(1, :); end_10mm(1, :)], "y");
hold on;

xlabel("z (m)");
ylabel("x (m)");
title("Image System");

% figure;
% 
% for numberOfAngles = 1:numberOfAngles
%     for numberOfProps = 1:100
%         ray_0mm(:, numberOfProps) = (propogation^numberOfProps) * angled_0mm(:, numberOfAngles);
%     end
%     plot(linspace(0, d, 100), ray_0mm(1, :), "r");
%     hold on;
% end
% 
% for numberOfAngles = 1:numberOfAngles
%     for numberOfProps = 1:100
%         ray_10mm(:, numberOfProps) = (propogation^numberOfProps) * angled_10mm(:, numberOfAngles);
%     end
%     plot(linspace(0, d, 100), ray_10mm(1, :), "b");
%     hold on;
% end
% 
hold off; 