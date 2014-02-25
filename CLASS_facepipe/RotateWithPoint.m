function imgOut = RotateWithPoint(imgImput, point, theta)
   %shift = point - [point(1,1) point(1,2)]*[cos(theta) -sin(theta);sin(theta) cos(theta)];
    tform = [cos(theta) -sin(theta) 0;
        sin(theta) cos(theta) 0;
        -1*point(1,1)*cos(theta)+point(1,2)*sin(theta)+point(1,1) -1*point(1,1)*sin(theta)-point(1,2)*cos(theta)+point(1,2) 1];
    
end