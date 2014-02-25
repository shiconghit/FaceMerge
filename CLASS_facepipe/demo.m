clear all;close all;
init;

%fprintf('running from cached face detections...\n');
fid=fopen('listWOMEN2.txt','r');
index = 0;
MergeImg = zeros(160,120,3);
figure;
while ~feof(fid)
    index = index+1;
    filename = fgets(fid);
    filename =filename(1:13);
    [DETS,PTS,DESCS]=extfacedescs(opts,filename);
%%
    %a1 = atan(PTS(2,4) - PTS(2,1))/((PTS(1,4) - PTS(1,1)))*180/3.14159;
    %a2 = atan(PTS(2,9) - PTS(2,8))/((PTS(1,9) - PTS(1,8)))*180/3.14159;
    %Í¼ÏñÅä×¼²Ù×÷
    base_points = [38 65;51 65;63 65;77 65;49 81;57 82;65 81;47 92;68 92];
    try
    input_points = PTS';
    catch
        continue
    end
    Tlinear = cp2tform(input_points,base_points,'linear conformal');
    %tformfwd([1 2],Tlinear)
    img = imread(filename);
    imgTrans = imtransform(img,Tlinear, 'XData',[1 120], 'YData',[1 160]);
    %{
    imshow(imgTrans);
    hold on;
    for basePointIndex = 1:size(base_points,1)
        plot(base_points(basePointIndex,1),base_points(basePointIndex,2),'y+','markersize',10,'linewidth',2);
    end
    hold off;
    %}
    for ii = 1:size(imgTrans,1)
        for jj=1:size(imgTrans,2)
            for kk=1:3
                try
                    MergeImg(ii,jj,kk) = double(MergeImg(ii,jj,kk))+ double(imgTrans(ii,jj,kk));
                catch

                end
            end
        end
    end
    imshow(uint8(MergeImg./index));
    hold on;
    pause;
end
MergeImg = MergeImg./index;
figure;
imshow(uint8(MergeImg));
fclose(fid);



%%
fprintf(' DETS: %d x %d\n',size(DETS,1),size(DETS,2));
fprintf('  PTS: %d x %d x %d\n',size(PTS,1),size(PTS,2),size(PTS,3));
fprintf('DESCS: %d x %d\n',size(DESCS,1),size(DESCS,2));
break;


if strcmp(computer,'PCWIN')

    pause;
    
    fprintf('running using face detector binary...\n');

    I=imread('047640.jpg');
    
    [DETS,PTS,DESCS]=extfacedescs(opts,I,true);
    
	fprintf(' DETS: %d x %d\n',size(DETS,1),size(DETS,2));
	fprintf('  PTS: %d x %d x %d\n',size(PTS,1),size(PTS,2),size(PTS,3));
	fprintf('DESCS: %d x %d\n',size(DESCS,1),size(DESCS,2));
end
