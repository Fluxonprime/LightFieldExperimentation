clc
clear all
close all

nframes = 3;
%rank_list=[20,24,28,32,36,40,44,48,52,56,60];
rank_list=[60];
qp_list=[2];
%qp_list = [2,6,10,14,20,26,38];

for r = 1:size(rank_list,2)
k = rank_list(r);
for q = 1:size(qp_list,2)
 qp = qp_list(q);
 textoutput = sprintf('\n\n ----RANK :%d ----QP : %d ---- \n',k,qp);
 disp(textoutput);
 inputfilename = sprintf('./INPUT YUV FILES/Bunnies/Rank_k%d/decQP%d_Bunniesrank%d.yuv',k,qp,k);
 %inputfilename = sprintf('./INPUT YUV FILES/decQP%d_orgbikesrank%d.yuv',qp,k);
 
 
%[Y, U, V] = yuvRead(inputfilename,624, 432,nframes);

[Y, U, V] = yuvRead(inputfilename,816, 512,nframes); %format is widthxheight

dim = size(Y);
for f =1:nframes
    disp('Layer');
    disp(f);
    yy = Y(:,:,f);
    uu = U(:,:,f);
    vv = V(:,:,f);
    yuv(:,:,1) = double(yy);
    yuv(:,:,2) = imresize(double(uu),2,'bicubic');
    yuv(:,:,3) = imresize(double(vv),2,'bicubic');
    imgrgb = reshape(convertYuvToRgb(reshape(yuv, dim(1) * dim(2), 3)), dim(1), dim(2), 3);
    %figure;
    %imshow(imgrgb);
    
    filename = sprintf('./OUTPUT RGB LAYERS/Bunnies/Rank_k%d/QP%d/recfromyuvbunnieslayer0%d.png',k,qp,f-1);
    %filename = sprintf('./OUTPUT RGB LAYERS/recfromyuvorgbikeslayer0%d.png',f-1);
    imwrite((imgrgb),filename); 


end
end
end