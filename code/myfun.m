function [f,w]=myfun(x,objnumber,variablenumber)

%% objective functions
global y X N L;
[a,b] = size(X);
w=x./sum(x);% weights
wmat=ones(L,1)*w;
fcst=sum(X.*wmat,2);
obs=y;

% kge=klinggupta(fcst,obs);
perf = det_scores( obs, fcst );

for i = 1:b;
    sigma(i) = rand.*nanstd(X(:,i)-y);
end;
sigma_s = mean(sigma);  % A single sigma (constant for all members)

PI = [0 0.05 0.1 0.25 0.5 0.75 0.9 0.95 1];
SI = [];
NR = [];
IRND = [];
for n = 1:a;
    % Get the weights and variances for all models/members
    % Generate 100 random numbers between 1 and 9
    w_cumsum = [0 cumsum(w)];
    w_cumsum(:,end) = 1;
    nrnd = 100;
    rnd = rand(nrnd,1);
    irnd = find_ranges(rnd,w_cumsum);
    while length(irnd) < nrnd;
        rnd = rand(nrnd,1);
        irnd = find_ranges(rnd,w_cumsum);
    end;
    % Check the distribution
    [nr,h] = hist(irnd,b);
    corr_w_h = corrcoef(h,w);
    corr_w_h = corr_w_h(2,1);
    NR = [NR;nr];
    IRND = [IRND;irnd];
    % Generate "nrnd=100" predictions based on Gausian distribution - N(d(t,k),sigma(k))
    for j = 1:nrnd;
        i = irnd(j); % Find model index, k
        s(n,j) = -999;
        while s(n,j) < 0;
            s(n,j)=randn.*sigma(i)+X(n,i); % Generate a prediction s(j)=randn*sigma_s1+d(t,k);
        end;
    end;
end;
ga = s;

[ nrd ] = normreld(ga, obs);

f(1)=-perf;% maximization NSE
f(2)=nrd;% minimization




