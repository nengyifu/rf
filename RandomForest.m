clear all
clc

% support up to 9 classes
%% parameters
ts =0.5; 
% 'blobs.txt';'spirals.txt';'iris.txt';'tmp.txt';'wine.txt'
filenames = ['1.txt';'2.txt';'3.txt';'4.txt';'5.txt'];

% no_nodes
nodes = 3;
% treeNumber=50;
scores = 0;

progress = 0;
% Grid Search
for I = 1:3
    treeNumber = 50*I;
    for J = 1:5
        clearvars -except progress scores treeNumber filenames ts I J nodes
        progress = progress + 1;
        progress/15

        data=load(filenames(J,:));
        % root node
%   
%         rnode=cell(nodes,1);
% 
%         rchild_value=cell(nodes,1);
%         rchild_node_num=cell(nodes,1);
% 
%         data=roundn(data,-1);
%         sampleSize = length(data);
%         trainSize = floor(sampleSize*ts);
%         
%         %% run test
%         for j=1:treeNumber
%             Sample_num=randi([1,sampleSize],1,trainSize);% get sample indexs
%             SData=data(Sample_num,:);
%             [node,child_value,child_node_num]=ID3(SData);
%             rnode{j,1}=node;
%             rchild_value{j,1}=child_value;
%             rchild_node_num{j,1}=child_node_num;
%         end
% 
%         %% test, run all trees
%         for j=1:sampleSize
%             [type(j)]=statistics(treeNumber,rnode,rchild_value,rchild_node_num,data(j,:));
%         end
% 
%         label = data(:,end);
% 
%         c = 0;
%         for i = 1:sampleSize
%             if label(i)==type(i)
%                 c=c+1;
%             end
%         end
% 
%         score = c/sampleSize;
%         scores(I,J) = score;
        
    end
end