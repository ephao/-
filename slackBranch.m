function [m]=slackBranch(B,s)

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
