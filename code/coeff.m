function [r] = coeff(fcst,obs)
nx=length(obs); 
[ny,mb]=size(fcst);
if (nx~=ny)
    r=-1;
else;
    r=0;
    for j=1:mb
        r=r+corr(obs,fcst(:,j));
    end
end;

% r=r/mb

