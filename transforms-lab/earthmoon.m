close all;
clear all;

% 2D polygon for Earth: square of 2 by 2 units, in homogeneous coordinates.
earth = [-1 1 1 -1 -1; -1 -1 1 1 -1; 1 1 1 1 1];

% Another 2D polygon for the Moon, made by scaling the earth to 1/4 size
S = [0.25 0 0; 0 0.25 0; 0 0 1];
J = [0.25 0 0; 0 0.25 0; 0 0 1];
K = [0.25 0 0; 0 0.25 0; 0 0 1];
moon = S * earth;
secondMoon = J * earth;
thirdMoon = K * earth;

% Set up axes for plotting our animation.
figure;
hold on;
axis equal;
axis([-8 8 -8 8]);


for a = 0:0.01:2 * pi

	% Moon will spin 5 times as fast as the Earth.
	a_moon = 5 * a;
    a_secondMoon = 5 * a;
    a_thirdMoon = 2 * a_secondMoon;

	% Rotation matrix for Earth.
	R_earth = [cos(a) -sin(a) 0; sin(a) cos(a) 0; 0 0 1];

	% Rotation matrix for the Moon.
	R_moon = [cos(a_moon) -sin(a_moon) 0; sin(a_moon) cos(a_moon) 0; 0 0 1];
    R_secondMoon = [cos(a_secondMoon) -sin(a_secondMoon) 0; sin(a_secondMoon) cos(a_secondMoon) 0; 0 0 1];
    R_thirdMoon = [cos(a_thirdMoon) -sin(a_thirdMoon) 0; sin(a_thirdMoon) cos(a_thirdMoon) 0; 0 0 -1];

	% Translation matrix to move the Moon away from Earth
    % (it orbits at a distance of 5 units).
	T_moon = [1 0 5; 0 1 0; 0 0 1];
    T_secondMoon = [1 0 -5; 0 1 0; 0 0 1];
    T_thirdMoon = [1 0 1; 0 1 0; 0 0 1];

	% Rotate the Earth.
	p_earth = R_earth * earth;

	% Rotate the moon, then move it 5 units away from the origin.
	p_moon = T_moon * R_moon * moon;
    p_secondMoon = T_secondMoon * R_secondMoon * secondMoon;
    p_thirdMoon = T_thirdMoon * R_thirdMoon * thirdMoon;

	% Place the moon in the Earth's reference frame (which is R).
	p_moon = R_earth * p_moon;
    p_secondMoon = R_earth * p_secondMoon;
    p_thirdMoon = R_earth * T_secondMoon * R_thirdMoon * T_thirdMoon * p_thirdMoon;

	% Draw the earth in blue and the moon in black.
	cla;
	plot(p_earth(1,:), p_earth(2,:), 'b', 'LineWidth', 2);
	plot(p_moon(1,:),  p_moon(2,:),  'k', 'LineWidth', 2);
    plot(p_secondMoon(1, :), p_secondMoon(2,:),  'k', 'LineWidth', 2);
    plot(p_thirdMoon(1, :), p_thirdMoon(2,:),  'k', 'LineWidth', 2);
	drawnow;
end