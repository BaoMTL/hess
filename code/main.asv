%% Multiobjective Genetic Algorithm: NSGA-2
% Created by:: Jing Xu <jing.xu.1@ulaval.ca>, Dec.2017

clc;close all;clear all;

load('demo.mat') % e.x., Cbaskatong_Mod1_fcast_d_4.mat
X=fcst; y=obs;

rand('seed', 100);
format long g;
global y X N L;

L=size(X,1); % days
N=size(X,2); % members

popsize=100;% Population size
maxiter=1;% Number of runs

%% Objective function set
objnumber=2;% Number of objective functions
variablenumber=N;% Number of variables
PM=0.1;% Mutation Probability
PC=0.7;% crossing-over rate

lb=0*ones(1,N);
ub=1*ones(1,N);

Chrom=inivariables(popsize,objnumber,variablenumber,lb,ub);% initialization vector
Chrom=nondominationsort(Chrom, objnumber, variablenumber);% Non domination Sorting on initial population

value01=zeros(maxiter,2);
value02=zeros(maxiter,2);

wait_hand = waitbar(0,'GA mutil running...', 'tag', 'TMWWaitbar');
tour = 2;
for i = 1 : maxiter
    pool=round(popsize/2);
    parent_chromosome=tournaselect(Chrom,pool,tour);
    offchrom=mutationcross(parent_chromosome,objnumber,variablenumber,lb,ub,PM,PC);% distribution index for mutation / mutation constant
    mainp=size(Chrom,1);
    offspring_pop=size(offchrom,1);
    tempchrom(1:mainp,:)=Chrom;
    tempchrom(mainp+1:mainp+offspring_pop,1:objnumber+variablenumber)=offchrom;
    tempchrom=nondominationsort(tempchrom,objnumber,variablenumber);% Non domination Sorting on initial population
    Chrom=replacechrom(tempchrom,objnumber,variablenumber,popsize);% Selection vecor

    value01(i,1)=min(Chrom(:,variablenumber+1));
    value01(i,2)=mean(Chrom(:,variablenumber+1));

    value02(i,1)=min(Chrom(:,variablenumber+2));
    value02(i,2)=mean(Chrom(:,variablenumber+2));

    waitbar(i/maxiter,wait_hand);% update
end
delete(wait_hand);% delete

%% Outputs
best=Chrom(1,1:variablenumber);

figure;
plot(-Chrom(:,variablenumber+1),Chrom(:,variablenumber+2),'*');
xlabel('f1');
ylabel('f2');
grid on;
title('Multiobjective genetic algorithm: NSGA-2 pareto fronts','fontname','Calibri');

%% find the un-repeated nondomination solutions
dominatedmat=determinedomination(Chrom(:,variablenumber+1:variablenumber+objnumber));% Non domination solutions
dominatedmat=dominatedmat==0;
[mat2,indexa1]=matuniquefun(Chrom(dominatedmat,variablenumber+1:variablenumber+objnumber));% non-repetitive pareto
index99=find(dominatedmat);
indexselect=index99(indexa1);
mat3=Chrom(indexselect,1:variablenumber);
disp('Non domination solution');
mat3;


I=8; % the Ith nondomination solution
x=mat3(I,:);
[f,w]=myfun(x,objnumber,variablenumber);
disp([num2str(I),'th','non domination solution']);
disp('weigts');
w
disp('scores');

nse=-f(1) % maximization
nrd=f(2) % minimization



