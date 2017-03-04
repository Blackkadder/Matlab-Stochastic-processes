%this exercise asks you to compute simulated option price using risk
%neutral density method Z(T)
%refer to book Chapter 6 for details

%clear all variables in the environment and close all figure windows
clear all
close all

%%parameter initializations
N=10000; %number of terminal values we will simulate

T=10; %number of months till expiration

sigma=sqrt(0.35^2/12); %monthly stock volatility
mu=0.12/12+0.5*sigma^2; %monthly drift for stock
r=log(1.05)/12; %set continuously compounded monthly rate
theta=(mu-r)/sigma; %price of risk
s0=100; %initial stock price
K = 100; %strike price for the options
tmln=1:1:T+1;
%simulate random BM outcomes W(T)'s
WT=randn(N,T)*sqrt(T); %note sqrt(T) here! since randn is standard normal with variance of 1 and we want variance of T

%assignment #3

%1- using (3.28) construct simulated vector of stock prices st at T
st=zeros(N,T+1)+100;

for j=1:N
    %note that we need to update zt for each new draw to be independent!
    for i=1:T
        st(j,i+1)=s0*exp(sigma*WT(j,i)+(mu-0.5*(sigma^2))*(i));
    end
    
end

plot(tmln,st);

%2- use st vector to construct simulated payoffs vectors of call and put
%with strike K. pt and ct. You can use max(0,...) and min(0,...) functions to do that
c=max(0,st-K)
p=max(0,K-st)

%3- using (6.25) construct zt. Dont forget maturity T!
zt=ones(N,T+1);
for j=1:N
    %note that we need to update zt for each new draw to be independent!
 
    for i=1:T
        zt(j,i+1)=exp(-theta*WT(j,i)-0.5*(sigma^2)*i);
    end   
end

%4 - construct vectors of discounted call and put payoffs each multiplied by
%zt. You can use '.*' operator to multiply vectors element-by-element
c2=c.*zt;
p2=p.*zt;


%5- then compute the mean (expectation) of these vectors.  This is based on
%formula (6.34) and should give you the prices of the options. Report you
%prices for put and call
callprice = mean(sum(c2,2));%18.6811
putprice=mean(sum(p2,2)); %23.37
