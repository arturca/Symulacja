function h = strawberry(pos,R,varargin)
% strawberry 
% -------------------
% Syntax
% h = FRUIT.STRAWBERRY(pos,R)
%
% Input Arguments
% pos: the center coordinate
%
% R: the sectional radius by the shape

if nargin == 0 
    pos = [0 0 0];
    R = 1;
elseif nargin == 1
    R = 1;
end
if ~isempty(varargin)
    color = varargin{1,1};
else
    color = [1 0 0];
end

phi = linspace(0,2*pi,50);
theta = linspace(0,pi/2,50);
[theta,phi] = meshgrid(theta,phi);
xUp = R  *sin(theta).*cos(phi); 
yUp = R  *sin(theta).*sin(phi);
zUp = R/2*cos(theta);

% the upper face of strawberry
h(1) = surface(xUp,yUp,zUp);

xDown = R  *sin(theta+pi/2).*cos(phi); 
yDown = R  *sin(theta+pi/2).*sin(phi);
zDown = 2*R*cos(theta+pi/2);

hold on

% the lower face of strawberry
h(2) = surface(xDown,yDown,zDown);

set(gca,'DataAspectRatio',[1 1 1]);
set(h,'EdgeColor','none','FaceColor',color);

n = 20;    % number in each section-divided symbol
hZ = (0:-0.2:-2-(-0.2))'*R; % the height coord for Z-axis
hZ = repmat(hZ,1,n); % repmat the hZ
r  = sqrt(R^2-hZ.^2/4);  % the radius in each circular-sector
alpha = 2*pi/n * ones(size(r)); % the radius angles in each circular-sector
alpha = cumsum(alpha,2);
X = r.*cos(alpha);
Y = r.*sin(alpha);
[cols,rows] = size(hZ);

% the strawberry seed distrubution 
dim = logical(SeedMatrix(cols,rows));

% generate the seeds' coordinates
x_seed = X(dim);
y_seed = Y(dim);

% the ellipsoid Z-coords
z_seed = real(-2*sqrt(R^2-x_seed.^2-y_seed.^2));

nz = [0 0 1];
for ind = 1:length(x_seed)
    hold on
    [xel,yel,zel] = ellipsoid(x_seed(ind),y_seed(ind),z_seed(ind),...
        R/30,R/30,R/15);
    s = surface(xel,yel,zel);
    h = [h,s];%#ok
    % the normal on each seed coordinates.
    nvec = [x_seed(ind),y_seed(ind),z_seed(ind)/4];
    
    % intersect angle between normals and XOY-plane.
    beta = asin(abs(sum(nvec.*nz)/norm(nvec)));
    
    % set the direction perpendicular to Z-axis and the normals
    direction = [nvec(2) -nvec(1) 0]; % 
    rotate(s,direction,-beta*180/pi,[x_seed(ind),y_seed(ind),z_seed(ind)]);
    set(s,'EdgeColor','none','FaceColor','y')
end

%view(3);
%light
hold on
centers = [0.6 0 0.6]*R;
fsize = 0.4*R;
angle = 10;
direction = [0 1 0];

le1 = leaf(centers,fsize,angle,direction);
le2 = leaf(centers,fsize,angle,direction);
rotate(le2,[0 0 1],72*1,[0 0 0.5]);
le3 = leaf(centers,fsize,angle,direction);
rotate(le3,[0 0 1],72*2,[0 0 0.5]);
le4 = leaf(centers,fsize,angle,direction);
rotate(le4,[0 0 1],72*3,[0 0 0.5]);
le5 = leaf(centers,fsize,angle,direction);
rotate(le5,[0 0 1],72*4,[0 0 0.5]);
h = [h ,le1,le2,le3,le4,le5];

for i = 1 : length(h)
    h(i).XData = h(i).XData + pos(1);
    h(i).YData = h(i).YData + pos(2);
    h(i).ZData = h(i).ZData + pos(3);
end

set(h,'tag',mfilename);

function sm = SeedMatrix(m,n)

if m < n
    smt = SeedMatrix(n,m);
    sm  = smt';
    return
end

a = eye(m,n);
b = zeros(n,n);
b(1,1:2:end) = 1;
a(1:2:end,1) = 1;
if n > 1
    b(2,2:2:end) = 1;
    a(2:2:end,2) = 1;
end

sm = a*b;


function h = leaf(centers,fsize,angle,direction)
% leaf for strawberry, for private use only.
x = [0:0.01:1,0.99:-0.01:0]*fsize*3;
y = [sin(pi*(0:0.01:1)),-sin(pi*(0.99:-0.01:0))]*fsize;
x = repmat(x,2,1);
y = repmat(y,2,1);
z = repmat([-fsize/40;fsize/40],1,size(x,2));
% the upper surface
h(1) = surface(x,y,z);
h(1).FaceColor = [0 1 0.2];
h(1).EdgeColor = 'none';
set(gca,'DataAspectRatio',[1 1 1]);
hold on
% the lower surface
h(2) = patch(x',y',z','g');
% leaf vein
hold on
s0 = plot3([0,fsize*3;0,fsize*3]',[0 0;0 0],...
    [fsize/40,fsize/40;-fsize/40,-fsize/40]');
set(s0,'LineWidth',1.5,'Color','k');
h = [h,s0'];
% more branchings on the leaf vein
xx = linspace(0,fsize*3,8);
xx([1,end])=[];
xsolve = [0.89324560021135820980940264746604,...
    1.4330758498567331434356736755553,...
    1.8291133943908810862131562859384,...
    2.1593804246750885431034036290128,...
    2.4548442667149027768253229434202,...
    2.7315841774617883072049331955351]*fsize;
ysolve = sin(pi/3/fsize*xsolve)*fsize;
xs = [xx ,xx;xsolve,xsolve];
X = repmat(xs,1,2);
ys = [zeros(size(ysolve)) , zeros(size(ysolve));ysolve,-ysolve];
Y = [ys,ys];
Z = [ones(size(xs))*fsize/40,-ones(size(xs))*fsize/40];
hold on
s = plot3(X,Y,Z);
h = [h,s'];
set(s,'LineWidth',1.5,'Color','k');
pos = [fsize*3/2 0 0];
p = centers - pos;
origin = p;
for i = 1 : length(h)
    h(i).XData = h(i).XData + p(1);
    h(i).YData = h(i).YData + p(2);
    h(i).ZData = h(i).ZData + p(3);
    if nargin > 2
        if nargin == 3
            direction = [0 1 0];
        end
        rotate(h(i),direction,angle,origin);
    end
end
