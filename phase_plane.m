% Author: Warish Orko This function takes in a matrix, A, of a linear
% system and a pair of co-ordinates to use as initial conditions. It plots
% a vector field for the system, indicated by arrows, and nullclines
% indicated by thin red dashed lines. It then plots a forward trajectory in
% red and a backward trajectory in green from the initial condition in
% blue.

function phase_plane(A,init)

% Plot vector field
x = -10:10;
y = x;
[X, Y] = meshgrid(x,y);
u = A(1,1).*X + A(1,2).*Y;
v = A(2,1).*X + A(2,2).*Y;
Ax = axes;
quiver(X,Y,u,v,'k');
hold on
set(Ax,'YLim',[-10 10])
set(Ax,'XLim',[-10 10])

% Plot nullclines
ny = ( -A(2,1).*x ) ./ (A(2,2) );
plot(x,ny,':')
hold on
nx = -A(1,2).*y ./ A(1,1);
plot(x,nx,':')

% Plot trajectories from initial point
U = @(x,y) A(1,1).*x + A(1,2).*y;
V = @(x,y) A(2,1).*x + A(2,2).*y;

U_init = U(init(1),init(2));
V_init = V(init(1),init(2));
Px = init(1);
Py = init(2);

% Forward trajectory
ii = 0;
while -10 < Px && Px < 10 && -10 < Py && Py < 10
    if ii == 0
        plot(Px,Py,'.b','MarkerSize',19);
    end
    Px = Px + U_init/100;
    Py = Py + V_init/100;
    plot(Px,Py,'.r','MarkerSize',15);
    hold on
    U_init = U(Px,Py);
    V_init = V(Px,Py);
    ii = ii + 1;
    if ii > 400
        disp(['Computation time exceeded. Trajectory from ' num2str(init(1)) ',' num2str(init(2)) ' settles at ' num2str(Px) ',' num2str(Py)])
        break
    end
end

% Backward trajectory
Px = init(1);
Py = init(2);
ii = 0;
while -10 < Px && Px < 10 && -10 < Py && Py < 10
    if ii == 0
        plot(Px,Py,'.b','MarkerSize',19);
    end
    Px = Px - U_init/100;
    Py = Py - V_init/100;
    plot(Px,Py,'.g','MarkerSize',15);
    hold on
    U_init = U(Px,Py);
    V_init = V(Px,Py);
    ii = ii + 1;
    if ii > 400
        disp(['Computation time exceeded. Trajectory from ' num2str(init(1)) ',' num2str(init(2)) ' settles at ' num2str(Px) ',' num2str(Py)])
        break
    end
end