function plotcircle2(eye, coords)
pause on;

% coords = [a b pR iR]
a = coords(1)
b = coords(2)
pR = coords(3)
iR = coords(4)

% plot pupil edge on image
% show image with detected dimensions
% create detected circle edge
% determine circle points
theta = 2*pi/128:(2*pi)/128:(2*pi)/8;
x1 = round(pR * cos(theta));
y1 = round(pR * sin(theta));
% 
X1 = [x1 y1 y1 -x1 -x1 -y1 -y1 x1];
Y1 = [y1 x1 -x1 y1 -y1 -x1 x1 -y1];

pA = a + X1;
pB = b + Y1;

% again for iris
x2 = round(iR * cos(theta));
y2 = round(iR * sin(theta));
X2 = [x2 y2 y2 -x2 -x2 -y2 -y2 x2];
Y2 = [y2 x2 -x2 y2 -y2 -x2 x2 -y2];

iA = a + X2;
iB = b + Y2;
%
ind = sub2ind(size(eye),iA,iB);
ind2 = sub2ind(size(eye),pA,pB);
eye = uint8(eye);

eye(ind) = 255;
eye(ind2) = 255;
% display image with edge features

figure, imshow(eye);
%hold on;
%plot(a,b,'wx');
%plot(pA, pB, 'r.');
%plot(iA, iB, 'r.');
%hold off;