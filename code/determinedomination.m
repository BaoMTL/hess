function dominatedmat=determinedomination(valuemat)

popsize=size(valuemat,1); 
dominatedmat=zeros(popsize,1);
for i=1:popsize
    for j=1:i-1
        if ~dominatedmat(j)
            if dominatefun(valuemat(i,:),valuemat(j,:))
                dominatedmat(j)=1;
            elseif dominatefun(valuemat(j,:),valuemat(i,:))
                dominatedmat(i)=1;
                break;
            end
        end
    end
end
