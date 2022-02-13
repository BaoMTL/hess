function irnd=find_ranges(rnd,w_cumsum);

%  This function identifies the range indices for array x in xrng

nx=length(rnd); % 100
nrng=length(w_cumsum)-1; % 3
for j=1:nx;
    irnd(j)=-1;
    for i=1:nrng;
        if rnd(j)>=w_cumsum(i) & rnd(j)<w_cumsum(i+1);
            irnd(j)=i; 
            break;
        end;
    end;
    if irnd(j)<0;
        disp('range indicator negative - stop'); 
        stop; 
    end;
end;
return;
