clc
clear all
close all

rank_list=[60];
for k= 1:size(rank_list,2)
disp('-----Rank-----');
disp(rank_list(k));

fileName = sprintf('./OUTPUT YUV FILES/Bunnies/BunniesRank%d.yuv',rank_list(k));
%fileName = sprintf('./OUTPUT YUV FILES/orgbikestRank%d.yuv',rank_list(k));
nrFrame = 3; %Since 3 layers
fileId = fopen(fileName, 'w');

for f = 1 : nrFrame
    disp('Layer');
    disp(f);
    inputlayer = sprintf('./INPUT RGB LAYERS/Bunnies/Rank_k%d/bunlayer0%d_k%d.png',rank_list(k),f-1,rank_list(k));
    %inputlayer = sprintf('./INPUT RGB LAYERS/orgbikeslayer0%d_k%d.png',f-1,rank_list(k));
    imgRgb = imread(inputlayer);
    %imgRgb = imread(sprintf('bikeslayer0%d_k60.png',f-1));
    imgRgb = imresize(imgRgb,[512,816]);  %for hevc step, we need pixels to be in multiples of 8
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