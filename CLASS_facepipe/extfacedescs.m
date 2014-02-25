function [DETS,PTS,DESCS]=extfacedescs(opts,img,debug)

if nargin<3
    debug=false;
end

if debug
    figure(1);
    clf('reset');
    set(gcf,'doublebuffer','on');
    %figure(2);
    %clf('reset');
    %set(gcf,'doublebuffer','on');
end

if ischar(img)
    I=imread(img);
    detpath=[img '.vj'];
    if exist(detpath)
        DETS=readfacedets(detpath);
    else
        DETS=runfacedet(I,img);
    end
else
    I=img;
    DETS=runfacedet(I);
end

PTS=zeros(0,0,size(DETS,2));
DESCS=zeros(0,size(DETS,2));
for i=1:size(DETS,2)

    P=findparts(opts.model,I,DETS(:,i));
    PTS(1:size(P,1),1:size(P,2),i)=P;
    if debug
        figure(1);
        imagesc(I);
        hold on;
        plot(DETS(1,i)+DETS(3,i)*[-1 1 1 -1 -1],DETS(2,i)+DETS(3,i)*[-1 -1 1 1 -1],'y-','linewidth',2);
        plot(PTS(1,:,i),PTS(2,:,i),'y+','markersize',10,'linewidth',2);
        hold off;
        axis image;
        colormap gray;
        %figure(2);
    end
    
    %fd=extdesc(opts.desc,I,PTS(:,:,i),debug);
    %DESCS(1:numel(fd),i)=fd;
    
    if debug
        drawnow;
        if i+1<size(DETS,2)
            pause;
        end
    end
    
end
