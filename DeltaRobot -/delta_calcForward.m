function[x0,y0,z0] = delta_calcForward(theta1,theta2,theta3)
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

    theta1 =theta1*dtr;
    theta2 = theta2*dtr;
    theta3 = theta3*dtr;

    x1 = 0.0;
    y1 = -(t + rf*cos(theta1));
    z1 = -rf*sin(theta1);

    y2 = (t + rf*cos(theta2))*sin30;
    x2 = y2*tan60;
    z2 = -rf*sin(theta2);

    y3 = (t + rf*cos(theta3))*sin30;
    x3 = -y3*tan60;
    z3 = -rf*sin(theta3);

    dnm = (y2-y1)*x3-(y3-y1)*x2;

    w1 = x1*x1 + y1*y1 + z1*z1;
    w2 = x2*x2 + y2*y2 + z2*z2;
    w3 = x3*x3 + y3*y3 + z3*z3;

% x = (a1*z + b1)
    a1 = ((z2-z1)*(y3-y1)-(z3-z1)*(y2-y1));
    b1 = -((w2-w1)*(y3-y1)-(w3-w1)*(y2-y1))/(2.0);

% y = (a2*z + b2);
    a2 = -((z2-z1)*x3+(z3-z1)*x2);
    b2 = ((w2-w1)*x3 - (w3-w1)*x2)/(2.0);

% az^2 + bz + c = 0
    a = a1*a1 + a2*a2 + dnm*dnm;
    b = 2*(a1*b1 + a2*(b2-y1*dnm) - z1*dnm*dnm);
    c = b1*b1 + (b2-y1*dnm)*(b2-y1*dnm) + (z1*z1 - re*re)*dnm*dnm;

% discriminant
    d = b*b - 4.0*a*c;
    if (d < 0) 
        disp('Error'); % non-existing point \
    end
    z0 = -0.5*(b+sqrt(d))/a;
    x0 = (a1*z0 + b1)/dnm;
    y0 = (a2*z0 + b2)/dnm;

end
