function f=mutationcross(parent_chromosome,objnumber,variablenumber,lb,ub,PM,PC)
global y X N L;
[popsize,v1]=size(parent_chromosome); 
K=objnumber+variablenumber;

Chrom=parent_chromosome(:,1:variablenumber);

Chrom=crossGA(Chrom,popsize,PC,N);
Chrom=mutationGA(Chrom,popsize,PM,N,lb,ub);

for i=1:popsize
    Chrom(i,variablenumber+1:K)=myfun(Chrom(i,1:variablenumber),objnumber,variablenumber);
end
f = Chrom;
