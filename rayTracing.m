numberOfAngles = 8;

angles = [linspace(-pi/20, pi/20, numberOfAngles)];

angled_0mm = zeros(4, numberOfAngles);
angled_10mm = zeros(4, numberOfAngles);

angled_0mm(2, :) = angles; % x1 = 0, theta_x_1 = -pi/20 to pi/20, y1 = 0, theta_y_1 = 0;
angled_10mm(2, :) = angles;

angled_10mm(1, :) = 10;

ray_0mm = zeros(4, 100);
ray_10mm = zeros(4, 100);

d = 0.1; % millimeters

propogation = [
    1, d, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, d;
    0, 0, 0, 1
    ]; % d represents the distance propogated. 

figure;

for numberOfAngles = 1:numberOfAngles
    for numberOfProps = 1:100
        ray_0mm(:, numberOfProps) = (propogation^numberOfProps) * angled_0mm(:, numberOfAngles);
    end
    plot(linspace(0, d, 100), ray_0mm(1, :), "r");
    hold on;
end

for numberOfAngles = 1:numberOfAngles
    for numberOfProps = 1:100
        ray_10mm(:, numberOfProps) = (propogation^numberOfProps) * angled_10mm(:, numberOfAngles);
    end
    plot(linspace(0, d, 100), ray_10mm(1, :), "b");
    hold on;
end

hold off; 