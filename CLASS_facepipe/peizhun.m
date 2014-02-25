clear all;close all;
fid=fopen('listWOMEN.txt','r');
i = 1;
fileNames = [];
while ~feof(fid)
    a = fgets(fid)
end
fclose(fid);
break
X = uint8([ 255 0 75; 44 225 100]); 
Y = uint8([ 50 50 50; 50 50 50 ]); 
Z = imadd(double(X),double(Y)) 
break

base_points = [1 2; 4 8];
input_points = [2 4; 8 16];
Tlinear = cp2tform(input_points,base_points,'linear conformal');
tformfwd([1 2],Tlinear)