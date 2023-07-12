function seq2Yuv(mov, fileName, mode,nrFrame)
% save tensor_output to YUV 4:2:0 file

switch mode
	case 1 % replace file
		fileId = fopen(fileName, 'w');
	case 2 % append to file
		fileId = fopen(fileName, 'a');
	otherwise
		fileId = fopen(fileName, 'w');
end

dim = size(mov);

for f = 1 : nrFrame
    %disp(f);
    Input=mov(:,:,f);
    Input=mat2gray(Input); %makes the max value as 1.00 and converts others accordingly
    Input=im2uint8(Input); % converts the 0-1 values as 0-255
	imgRgb = repmat(Input,[1 1 3]); %now is a rgb image with values 0-255
     disp('in seq2yuv size of rgb...');
    disp(size(imgRgb));
	
	% convert YUV to RGB
	imgYuv = reshape(convertRgbToYuv(reshape(imgRgb, dim(1) * dim(2), 3)), dim(1), dim(2), 3);
    disp('in seq2yuv size of yuv...');
    disp(size(imgYuv));
    
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

