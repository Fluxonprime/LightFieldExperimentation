clc
clear all
close all

rank_list=[20,24,28,32,36,40,44,48,52,56,60];
%mode = 1;
for k= 1:size(rank_list,2)
%sprintf('rank:%d',rank_list(k))
disp('--Rank--');
disp(rank_list(k));

fileName = sprintf('./OUTPUT YUV FILES/Bikes/BikesRank%d.yuv',rank_list(k));
nrFrame = 3; %Since 3 layers
fileId = fopen(fileName, 'w');

for f = 1 : nrFrame
    disp('Layer');
    disp(f);
    inputlayer = sprintf('./INPUT RGB LAYERS/Bikes/Rank_k%d/bikeslayer0%d_k%d.png',rank_list(k),f-1,rank_list(k));
    imgRgb = imread(inputlayer);
    %imgRgb = imread(sprintf('bikeslayer0%d_k60.png',f-1));
    imgRgb = imresize(imgRgb,[432,624]);
    %disp('size of rgb...');
    dim = size(imgRgb);
    %disp(dim);
	
	% convert YUV to RGB
	imgYuv = reshape(convertRgbToYuv(reshape(imgRgb, dim(1) * dim(2), 3)), dim(1), dim(2), 3);
    %disp(' size of yuv...');
    %disp(size(imgYuv));
    
	% write Y component
	buf = reshape(imgYuv(:, :, 1).', [], 1); % reshape
	count = fwrite(fileId, buf, 'uchar');
			
	% write U component
	buf = reshape(imgYuv(1 : 2 : end, 1 : 2 : end, 2).', [], 1); % downsample and reshape
	count = fwrite(fileId, buf, 'uchar');

	% write V component
	buf = reshape(imgYuv(1 : 2 : end, 1 : 2 : end, 3).', [], 1); % downsample and reshape
	count = fwrite(fileId, buf, 'uchar');
end

fclose(fileId);

end