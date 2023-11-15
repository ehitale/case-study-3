angles = [linspace(-pi/20, pi/20, 20)];

angled_0mm = zeros(4, 20);
angled_10mm = cat(2, [10; 0; 0; 0], zeros(4, 19));

angled_0mm(2, :) = angles; % x1 = 0, theta_x_1 = -pi/20 to pi/20, y1 = 0, theta_y_1 = 0;
angled_10mm(2, :) = angles;

ray_1 = zeros(4, 100);
ray_2 = zeros(4, 100);

d = 0.2; % millimeters

propogation = [
    1, d, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, d;
    0, 0, 0, 1
    ]; % d represents the distance propogated. 

for numberOfAngles = 1:20
    for numberOfProps = 1:100
        ray_1(:, c) = (propogation^numberOfProps) * angled_0mm(:, numberOfAngles);
    end
    % plot something, and move on to the next angle.
end

% for c = 1:100
%     ray_2(:, c) = (propogation^c) * ;
% end

% plot(linspace(0, d, 100), ray_1);
% plot(linspace(0, d, 100), ray_2);