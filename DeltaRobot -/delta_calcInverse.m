function[theta1,theta2,theta3] = delta_calcForward(x0,y0,z0)
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
    theta1 =0; theta2 = 0; theta3 = 0;
    [status,theta1] = delta_calcAngleYZ(x0, y0, z0);
    if (status == 0) 
      [stt,theta2] = delta_calcAngleYZ(x0*cos120 + y0*sin120, y0*cos120-x0*sin120, z0); % rotate coords to +120 deg
    end
    if (status == 0) 
      [stt,theta3] = delta_calcAngleYZ(x0*cos120 - y0*sin120, y0*cos120+x0*sin120, z0); % rotate coords to -120 deg

    end
end