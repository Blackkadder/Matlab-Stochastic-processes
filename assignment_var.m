%note yeild is optional and can be omitted or seto zero
%[Call, Put] = blsprice(s0, K, r, T, sigma, yield)


%this exercise asks you to compute simulated VAR of option portfolio

%clear all variables in the environment and close all figure windows
clear all
close all

%%parameter initializations
N=1000000; %number of terminal values we will simulate

%VaR confidences
alphas=[0.05 0.02 0.01 0.005];

T=3; %number of months till expiration
Ti=2; %number of months for which we compute VaR

%parameters
sigma=sqrt(0.35^2/12); %monthly stock volatility
mu=0.12/12+0.5*sigma^2; %monthly drift for stock
r=log(1.05)/12; %set continuously compounded monthly rate
s0=100; %initial stock price

%for bull spread
K1 = 100; 
K2 = 105;
%for covered call and straddle
K3 = s0;


%number of options in portfolio
%negative is short 
ns=100;
np1=100;
nc1=100

%initial values of the options
[BSC01, BSP01] = blsprice(s0, K1, r, T, sigma);
[BSC02, BSP02] = blsprice(s0, K2, r, T, sigma);
[BSC03, BSP03] = blsprice(s0, K3, r, T, sigma);

%initial portfolio value
x0_bull=nc1*BSC01-nc1*BSC02;
x0_covered_call=ns*s0-nc1*BSC03;
x0_straddle=nc1*BSC03+np1*BSP03;

%simulate random BM outcomes W(T)'s
WT=randn(N,1)*sqrt(Ti); %note sqrt(T) here! since randn is standard normal with variance of 1 and we want variance of T

%simulated vector of stock prices st at T
st=s0*exp(sigma*WT + (mu-0.5*sigma^2)*Ti);

%use BS model to compute prices for all values in st (note function takes
%vector of stock prices and returns vectors of option prices)

[BSC1, BSP1] = blsprice(st, K1, r, T-Ti, sigma);
[BSC2, BSP2] = blsprice(st, K2, r, T-Ti, sigma);
[BSC3, BSP3] = blsprice(st, K3, r, T-Ti, sigma);

%losses and gains from each option and stock
lc1=-(BSC1-BSC01);
lc2=-(BSC2-BSC02);
lc3=-(BSC3-BSC03);
lp1=-(BSP1-BSP01);
lp2=-(BSP2-BSP02);
lp3=-(BSP3-BSP03);

sl=-(st-s0);

%portfolio losses and gains in percent of initial value
pl=nc1*lc1-nc1*lc2/x0_bull;
p2=(ns*s0-nc1*lc3)/x0_covered_call;
p3=(nc1*lc3+np1*lp3)/x0_straddle;
plot(p2)

%plot histogram of portfolio losses for illustration
%bull
hist(pl,(0.9*min(pl)):0.01:(1.1*max(pl)))
ttls=sprintf('Portfolio losses (negatives are gains) Number of sims = %9d',N );
title(ttls)
xls=sprintf('Conditional mean loss = %5.4f',mean(pl(find(pl>0))) );
xlabel(xls)
%compute Var cutoffs
vars=prctile(pl,100*(1-alphas));

%print Vars in dollar terms
%and initial investment
fprintf('%6.3f  ',1-alphas)
fprintf('\n')
fprintf('%5.4f  ',vars)
fprintf('\n')
fprintf('%6.1f  ',vars*x0_bull)

fprintf('\n\n%5.1f\n\n ',x0_bull)


%covered call
hist(p2,(0.9*min(pl)):0.01:(1.1*max(p2)))
ttls=sprintf('Portfolio losses (negatives are gains) Number of sims = %9d',N );
title(ttls)
xls=sprintf('Conditional mean loss = %5.4f',mean(p2(find(p2>0))) );
xlabel(xls)


%print Vars in dollar terms
%and initial investment
fprintf('%6.3f  ',1-alphas)
fprintf('\n')
fprintf('%5.4f  ',vars)
fprintf('\n')
fprintf('%6.1f  ',vars*x0_covered_call)

fprintf('\n\n%5.1f\n\n ',x0_covered_call)


%straddle
hist(p3,(0.9*min(pl)):0.01:(1.1*max(p3)))
ttls=sprintf('Portfolio losses (negatives are gains) Number of sims = %9d',N );
title(ttls)
xls=sprintf('Conditional mean loss = %5.4f',mean(p3(find(p3>0))) );
xlabel(xls)


%print Vars in dollar terms
%and initial investment
fprintf('%6.3f  ',1-alphas)
fprintf('\n')
fprintf('%5.4f  ',vars)
fprintf('\n')
fprintf('%6.1f  ',vars*x0_straddle)

fprintf('\n\n%5.1f\n\n ',x0_straddle)
