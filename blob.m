vidReader=vision.VideoFileReader('C:\Users\Vikas\Documents\MATLAB\test2.mp4');

vidReader.VideoOutputDataType='double';
vidPlayer = vision.DeployableVideoPlayer;
diskElem=strel('disk',8);
%define blob area for blob analysis
hBlob=vision.BlobAnalysis('MinimumBlobArea',100,...
    'MaximumBlobArea',1500000);
%Background=step(videoReader);
while ~isDone(vidReader)
    vidFrame=step(vidReader);
I = rgb2hsv(vidFrame);

% Define thresholds for channel 1 based on histogram settings
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.200;
channel1Max = 0.7;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 0.350;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.250;
channel3Max = 0.700;
% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

Ibwopen=imopen(sliderBW,diskElem);
%subplot(1,3,2);
imshow(Ibwopen);
[objArea,objCentroid,bboxOut]=step(hBlob,Ibwopen);
Ishape=insertShape(vidFrame,'Rectangle',bboxOut,'Linewidth',4);
%numobj=length(objArea);
%subplot(1,3,3)
%imshow(Ishape);
step(vidPlayer,Ishape);
end
%figure 
%subplot(1,2,1);
%imshow(Ishape);