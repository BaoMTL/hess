function [ nrd ] = normreld( fcst,obs)
% Normalized Reliability Deviation
% INPUT:
%   obs       - target values [k,1]
%   fcst      - predictive ensemble forecast [k,m]
[k,m]=size(fcst);
rmse=0;
variance=0;
for i=1:k % day
    for j=1:m % model
        rmse=rmse+(fcst(i,j)-obs(i))^2;
        %         rmse=rmse+(mean(fcst(i,:))-obs(i))^2;
        variance=variance+(fcst(i,j)-nanmean(fcst(i,:)))^2;
    end
end;
% rmse=sqrt(rmse/k);
rmse=sqrt((rmse/k)/m);
variance=sqrt((variance/(m-1))/k);
nrd=(rmse-variance)/rmse;
