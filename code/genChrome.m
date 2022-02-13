function Chrom=genChrome(popsize,N,lb,ub)
% generate population
Chrom=zeros(popsize,N); 
for i=1:popsize
    for j=1:N
        Chrom(i,j)=lb(j)+(ub(j)-lb(j))*rand(1,1);
    end
end