function [ kge ] = klinggupta( fcst,obs)
%Nash Sutcliffe Efficiency measure
% INPUT:
%   obs       - target values [k,1] 
%   fcst      - predictive forecast [k,1]

cflow=[fcst obs];

sdmodelled=nanstd(fcst);
sdobserved=nanstd(obs);

mmodelled=nanmean(fcst);
mobserved=nanmean(obs);

r=corr(cflow');
relvar=sdmodelled/sdobserved;
bias=mmodelled/mobserved;

%KGE timeseries
kge=1- sqrt( ((r(1,2)-1).^2) + ((relvar-1).^2) + ((bias-1).^2) );

end