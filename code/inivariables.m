function Chrom=inivariables(popsize,objnumber,variablenumber,lb,ub)

global y X N L;

K=objnumber+variablenumber; 

Chrom=genChrome(popsize,N,lb,ub);
for i=1:popsize
    Chrom(i,variablenumber+1:K)=myfun(Chrom(i,1:variablenumber),objnumber,variablenumber);
end