% 生成节点支路矩阵A
function [A]=adjacentMatrix(B)
n=size(B,1);
for i=1:n
    A(i,B(i,1))=1;
    A(i,B(i,2))=-1;
end
end

