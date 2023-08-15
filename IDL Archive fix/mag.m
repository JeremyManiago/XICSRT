function [] = mag(alpha)
clc
figure;
conv2  = pi()/180e0;
brg1 = [44.0178 ,68.4532]; % si533_si422
brg2 = [13.2774 ,68.4532]; % si533_HOPG
brg3 = [44.0178 ,66.7317]; % 4thHOPG_si422

% step = 0.1
step = 1;
alp = zeros(1,180*step);
mags1 = zeros(1,180*step);
mags2 = zeros(1,180*step);
mags3 = zeros(1,180*step);
grid on
hold on
j = 1;
for i = alpha : step : 180 
    alp(1, j) = i;

    z1 = - (cos( 2.0*(brg1(1,2)*conv2) - i*conv2 ) / cos( 2.0*(brg1(1,1)*conv2) + i*conv2));
    mags1(1,j) = z1;

    z2 = - (cos( 2.0*(brg2(1,2)*conv2) - i*conv2 ) / cos( 2.0*(brg2(1,1)*conv2) + i*conv2));
    mags2(1,j) = z2;

    z3 = - (cos( 2.0*(brg3(1,2)*conv2) - i*conv2 ) / cos( 2.0*(brg3(1,1)*conv2) + i*conv2));
    mags3(1,j) = z3;

    j = j + 1;
end    

title("Magnifications vs alpha angle ",'FontSize', 14);
xlabel('alpha (^o)', 'FontSize', 14);
ylabel('magnification (mm/mm)', 'FontSize', 14);

plot(alp, mags1, 'b', LineWidth=0.75, Marker='.')
plot(alp, mags2, 'g', LineWidth=0.75, Marker='.')
plot(alp, mags3, 'r', LineWidth=0.75, Marker='.')

legend('Concave Si-533, Convex Si-422', 'Concave Si-533, Convex 1st order HOPG', 'Concave 4th order HOPG, Convex Si-422', fontsize=14)


end