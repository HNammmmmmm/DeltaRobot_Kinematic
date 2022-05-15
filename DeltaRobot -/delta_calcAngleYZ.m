function[status,theta] =delta_calcAngleYZ(x0, y0, z0)
    e = 63.25; % end effector
    f = 80; % base
    re = 215;
    rf = 110;
    sqrt3 = sqrt(3.0);
    pi = 3.141592653; % PI
    sin120 = sqrt3/2.0;
    cos120 = -0.5;
    tan60 = sqrt3;
    sin30 = 0.5;
    tan30 = 1/sqrt3;
    t = (f-e)*tan30/2;
    dtr = pi/180.0;

    y1 = -0.5 * 0.57735 * f; 
    y0 = y0 - (0.5 * 0.57735 * e); 
    % z = a + b*y
    a = (x0*x0 + y0*y0 + z0*z0 +rf*rf - re*re - y1*y1)/(2*z0);
    b = (y1-y0)/z0;
    % discriminant
    d = -(a+b*y1)*(a+b*y1)+rf*(b*b*rf+rf);
    if (d < 0) 
       disp('Error'); % non-existing point \
    end
    yj = (y1 - a*b - sqrt(d))/(b*b + 1);
    zj = a + b*yj;
    if (yj>y1)
        theta = 180.0*atan(-zj/(y1 - yj))/pi + 180.0;
    else
        theta = 180.0*atan(-zj/(y1 - yj))/pi + 0.0;
    end
    status = 0; %Tra ve status de xac minh cho ham Inverse
end