a = 146
b = 147
pR = 43
iR = 99
f=imread('image1.bmp');
% plot pupil edge on image
% show image with detected dimensions
% create detected circle edge
% determine circle points
theta1 = 0:(2*pi)/128:(2*pi)/8;
x1 = round(pR * sin(theta1));
y1 = round(pR * cos(theta1));
% 
X1 = [x1 y1 y1 -x1 -x1 -y1 -y1 x1];
Y1 = [y1 x1 -x1 y1 -y1 -x1 x1 -y1];

pA = a + X1;
pB = b + Y1;


% again for iris
x2 = round(iR * sin(theta1));
y2 = round(iR * cos(theta1));
X2 = [x2 y2 y2 -x2 -x2 -y2 -y2 x2];
Y2 = [y2 x2 -x2 y2 -y2 -x2 x2 -y2];

iA = a + X2;
iB = b + Y2;


% display image with edge features
imshow(f);
hold on;
plot(a,b,'wx')
plot(pA, pB, 'r:')
plot(iA, iB, 'r:')
