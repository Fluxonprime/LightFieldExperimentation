clc
clear all
close all
diary log_acqimgs_intra
qp = 2;
textoutput = sprintf('\n\n----QP : %d ---- \n',qp);
disp(textoutput);
mycommand = sprintf('TAppEncoder.exe -c intra%d.cfg -q %d',qp,qp);
system(mycommand);
diary off