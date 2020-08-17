function [xMatrix]=branchXMatrix(A,m,x,s,B)
% xMatrix是支路阻抗矩阵,行列都是节点号，不包含平衡节点
n=0;

%线路故障时，当没有负荷失掉，这段不用改
for i=1:size(A,2)-1
    if ismember(i+1,m(:,2))%i+1表示包括平衡节点的节点总数，m中的节点编号包含着平衡节点
    n=n+1;%n用于得到m中储存的支路编号
    xMatrix(i,i)=x(1,m(n,1));
    else
    xMatrix(i,i)=Inf;
    end
end

% 本代码这里只适合将第一个节点设为平衡节点的情况
% 如果需要更改平衡节点位置，可以只更改以下for循环块，其余两个for循环块不用更改
for z=1:size(B,1)
    if B(z,1)~=s&&B(z,2)~=s
        xMatrix((B(z,1)-1),(B(z,2)-1))=x(1,z);
        xMatrix((B(z,2)-1),(B(z,1)-1))=x(1,z);
    end
end

for i=1:size(A,2)-1
    for j=1:size(A,2)-1
        if xMatrix(i,j)==0
            xMatrix(i,j)=Inf;
        end
    end
end
end