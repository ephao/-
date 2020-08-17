function [m]=slackBranch(B,s)
% m的第一列表示线路编号，第二列表示所连节点
m=[];
for i=1:size(B,1)
    if B(i,1)==s
        m=[m;
            i,B(i,2)];
    end
    if B(i,2)==s
        m=[m;
            i,B(i,1)];
end
end