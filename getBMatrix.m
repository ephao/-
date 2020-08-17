function [Y]=getBMatrix(xMatrix)
for i=1:size(xMatrix,1)
    for j=1:size(xMatrix,1)
        if i==j
            a=0;
            for j=1:size(xMatrix,1)
                a=a+1/xMatrix(i,j);
                Y(i,i)=a;
            end
        else
            Y(i,j)=-1/xMatrix(i,j);
        end
    end
end
end