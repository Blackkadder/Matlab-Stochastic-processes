%in this example we simulate discrete version of diffusion process

%clear all variables in the environment and close all figure windows
clear all
close all

%%parameter initializations
N=100000; %number of paths we will simulate
T=1000; %number of dt intervals in each path
s=0; %starting time
t=1; %terminal time, purely for convenience, coud always be rescaled to any number
mu=0.1; %drift for stock
sigma=0.45; %volatility

%%preliminary calculations/initializations

% this is our time increment dt
dt=(t-s)/T; 

%this is timeline vector of times where we construct BM observatons
% it runs from s to t with dt increments
tmln=s:dt:t; 

%initialize matrix to store all BM paths with zeros
st=ones(N,T+1);

%%how to simulate one path
%generate z_t's which are standard normal using funciton randn() (see help)
zt=randn(1,T);

%compute one path and store it in the first row of wt
for i=1:T
    
    st(1,i+1)=st(1,i) + st(1,i)*(mu*dt+sigma*zt(i)*(dt)^(0.5));
    
end

%plot the first path from the first row 
plot(tmln,st(1,:))
%annotate the chart
legend('S(t)');
titlestring=sprintf('Sample path of Diffusion with \\mu = %4.2f and \\sigma = %4.2f',mu,sigma);
title(titlestring)
ylabel('S(t)')
xlabel('t')


%homework assignment:

%Modify the code to simulate N diffusion paths, similar to BM case in the
%previous asssignment (see mb_sol.m for solution). Then compute the mean 
%and variance across simulated paths 
%for the log of stock return between t=0 and t=1, i.e. mean and variance of log(S(1)/S(0))

%track the execution time for this loop for later comparison to another
%method
cpt=cputime;

for j=1:N
    %note that we need to update zt for each new draw to be independent!
    zt=randn(1,T);
    for i=1:T
    st(j,i+1)=st(j,i)*(1 + mu*dt+sigma*zt(i)*(dt)^(0.5));
    end
end

%this will time the execution of the loop for later comparison
method1_time=cputime-cpt;

%construct simualated log returns between 0 and 1
%note that 'end' referes to the last entry in the matrix
%note that './' 'divides' one vector by another element by element
sr=log(st(:,end)./st(:,1));
% if you dont know the './', then an alternative would be
%r1=log(st(:,end))-log(st(:,1));

%computing and printing mean and variance
echo on
meansr=mean(sr)
stdsr=std(sr)
%theoretical
meansrth=mu-0.5*sigma^2
stdsrth=sigma
echo off

pause

%alternative method using cumprod
%for comparison we track this method as before using cputime funciton:
cpt=cputime;

%draw all zt's at once as a matrix N by T with each row corresponding
%to one run of the simulation

zt1=randn(N,T);

%construct instanteneous returns matrix using zt's
dss=mu*dt+sigma*zt1*(dt)^(0.5);

%then use cumulative product command for matrices to multiply along the rows
%dimension 2, type 'help cumprod' at the prompt for proper usage
%note that you have to start with column of ones for this to work

st1 = cumprod([ones(N,1) (1+dss)],2);

%stop the timer to compare methods:
method2_time=cputime-cpt;

%print comparison results
fprintf('%30s\n','Timing results (sec)' )
fprintf('%-20s %-5.3f \n','method1',method1_time)
fprintf('%-20s %-5.3f \n','method2',method2_time)
fprintf('%-20s %-5.3f \n\n\n','difference', method1_time-method2_time)


%repeat homework computations:
sr1=log(st1(:,end))-log(st1(:,1));
%computing and printing mean and variance
echo on
meansr1=mean(sr1)
stdsr1=std(sr1)
echo off
