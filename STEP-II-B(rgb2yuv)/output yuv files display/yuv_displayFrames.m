%numfrm = yuv2avi('rec_BalletDepthCam0_TensorALS_Rank1_QP2.yuv',[1024 628],'test.avi','none',15,'YUV444_8');
clc

close all
clear all


[Y, U, V] = yuvRead('Bikesrank60.yuv',624, 432,3);
%[Y, U, V] = yuvRead('I01_Bikes.yuv',624, 432,165);

%[Y, U, V] = yuvRead('rec_BDDepthCam4_TensorALS_Rank15_QP38.yuv',1024, 628,100);
%[Y, U, V] = yuvRead('D:\TENSOR MVD PROCESSING\DepthVideoCoding\BalletData\TENSOR ALS RESULTS\Camera4\TensorRank20\HEVCinput\BalletDepthCam4_TensorALS_Rank20.yuv',1024, 628,100);


figure;
c = 0;  % counter
imshow(Y(:,:,3));


% c = 0;  % counter
% for iFrame = 1:1:20
%     c = c + 1;
%     subplot(4,5,c), imshow(Y(:,:,iFrame));
%     title(['frame #', num2str(iFrame)]);
% end
% 
% figure;
% c = 0;  % counter
% for iFrame = 21:1:40
%     c = c + 1;
%     subplot(4,5,c), imshow(Y(:,:,iFrame));
%     title(['frame #', num2str(iFrame)]);
% end