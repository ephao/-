function [xMatrix]=branchXMatrix(A,m,x,s,B)
% xMatrix��֧·�迹����,���ж��ǽڵ�ţ�������ƽ��ڵ�
n=0;

%��·����ʱ����û�и���ʧ������β��ø�
for i=1:size(A,2)-1
    if ismember(i+1,m(:,2))%i+1��ʾ����ƽ��ڵ�Ľڵ�������m�еĽڵ��Ű�����ƽ��ڵ�
    n=n+1;%n���ڵõ�m�д����֧·���
    xMatrix(i,i)=x(1,m(n,1));
    else
    xMatrix(i,i)=Inf;
    end
end

% ����������ֻ�ʺϽ���һ���ڵ���Ϊƽ��ڵ�����
% �����Ҫ����ƽ��ڵ�λ�ã�����ֻ��������forѭ���飬��������forѭ���鲻�ø���
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