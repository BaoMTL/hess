function Chrom=mutationGA(Chrom,popsize,PM,N,lb,ub)
for i=1:popsize
    a=rand; 
    if a<PM
        r=unidrnd(N);
        Chrom(i,r)=lb(r)+(ub(r)-lb(r))*rand(1,1);
    end
end