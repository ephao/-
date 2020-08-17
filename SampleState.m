function [ staSum] = SampleState( faultRate,recoverRate )
%SAMPLESTATE Summary of this function goes here
%   Detailed explanation goes here
flag=0;
Iter=1;
status=[];
staSum=[];
while Iter<=1000
    if flag==0
        status=RunStateSample(faultRate);
        flag=1;
    else
        status=FaultStateSample(recoverRate);
        flag=0;
    end
    staSum=[staSum,status];
    Iter=Iter+1;
end
end

