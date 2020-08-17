function [min,exitflag]=Optpower(B,x,Tmax,nodeLoad,nodeGeneration,PGmaxF)
%目标是削减尽量少的负荷
s=1;
A=adjacentMatrix(B);
m=slackBranch(B,s);
xMatrix=branchXMatrix(A,m,x,s,B);
Y=getBMatrix(xMatrix);
reciprocalOfX=(1./x)';

AS=A(2:size(A,1),2:size(A,2));
nodeLoadS=nodeLoad(2:size(nodeLoad,1),1);
nodeGenerationS=nodeGeneration(2:size(nodeGeneration,1),1);
reciprocalOfXS=reciprocalOfX(2:size(reciprocalOfX,1),1);
PGmax=PGmaxF(2:size(PGmaxF,1),1);

for i=1:size(Y,1)
    reciprocalOfXS(:,i)=reciprocalOfXS(:,1);
end
    
co=reciprocalOfXS.*(AS*inv(Y));
% T=co*(nodeGeneration(2:size(nodeGeneration,1),1)-nodeLoadS);
coT=-ones([size(x,2)-1,1]);
c=ones([size(A,2)-1,1]);%未乘co时削减负荷的系数

copSP=[];%发电机前面的系数
for i =1:size(co,1)
    copSP=[copSP;co(i,:).*nodeGenerationS'];
end

coc=[];%被削减负荷前面的系数
for i =1:size(co,1)
    coc=[coc;co(i,:).*c'];
end

Aeq=[diag(coT),coc,copSP
    zeros([1,size(coT,1)]),c',nodeGenerationS'];
% 线路潮流约束(-T)+co*(Psp+C)=coPld
beq=[co*nodeLoadS
    sum(nodeLoadS)];
% bopt=[Tmax',nodeLoadS',PGmax'];
% Aopt=zeros(size(Tmax,1)+size(c,1)+size(PGmax,1));
% Aopt(1:size(Tmax,1),1:size(Tmax,1))=(-1).*diag(coT);
% Aopt(size(Tmax,1)+1:size(Tmax,1)+size(c,1),size(Tmax,1)+1:size(Tmax,1)+size(c,1))=diag(c);
% Aopt(size(Tmax,1)+size(c,1)+1:size(Tmax,1)+size(c,1)+size(PGmax,1),size(Tmax,1)+size(c,1)+1:size(Tmax,1)+size(c,1)+size(PGmax,1))=diag(nodeGenerationS);
f=[zeros([1,size(coT,1)]),c',zeros([1,size(nodeGenerationS,1)])];
ub=[Tmax(2:size(Tmax,1),1)',nodeLoadS',PGmax'];
lb=[(-1).*Tmax(2:size(Tmax,1),1)',zeros([1,size(nodeLoadS,1)+size(PGmax,1)])];
Aopt=[];
bopt=[];
[min,~,exitflag,~]=linprog(f,Aopt,bopt,Aeq,beq,lb,ub);
end

