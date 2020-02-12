[x, y] = textread("data.txt", "%f %f");

A = [x.^3 x.^2 x];

M = A'*A;
Y = A'*y;

C = inv(M)*Y;

f = @(x) (C(1,1)*x.^3) .+ (C(2,1)*x.^2) .+ (C(3,1)*x);

xx = linspace(-1, 6, 100);

yy = [f(xx)];
disp(C);

hold on;
plot(x, y, "*");
plot(xx', yy', "linewidth", 2);