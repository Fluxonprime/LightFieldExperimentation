clc
clear all
close all

k = 60;
qp_list = [2,6,10,14,20,26,38];
layer = [0,1,2];
count = 1;
for q = 1:size(qp_list,2)
    for l = 1:size(layer,2)
        filename = sprintf('./OUTPUT RGB LAYERS/Bikes/Rank_k60/QP%d/recfromyuvbikeslayer0%d.png',qp_list(q),layer(l));
        images{count} = imread(filename);
        count = count+1;
    end
end



 montage(images,'Size',[7 3]);

% name = sprintf('savedlayers');
% save(name,'images');
