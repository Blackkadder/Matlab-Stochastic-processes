%in this example we simulate discrete version of Borwonian Motion
%with 10 periods each

%clear all variables in the environment and close all figure windows
clear all
close all

%%parameter initializations
N=10000; %number of paths we will simulate
T=10000; %number of dt intervals in each path
s=0; %starting time
t=1; %terminal time, purely for convenience, coud always be rescaled to any number


%%preliminary calculations/initializations

% this is our time increment dt
dt=(t-s)/T; 

%this is timeline vector of times where we construct BM observatons
% it runs from s to t with dt increments
tmln=s:dt:t; 

%initialize matrix to store all BM paths with zeros
wt=zeros(N,T+1);

%%how to simulate one path
%generate z_t's which are standard normal using funciton randn() (see help)
zt=randn(1,T);

%compute one path and store it in the first row of wt
for i=1:T
    
    wt(1,i+1)=wt(1,i)+zt(i)*(dt)^(0.5);
    
end

%plot the first path from the first row of wt
plot(tmln,wt(1,:))
%annotate the chart
legend('W(t)');
title('Sample path of Brownian motion')

%plot z_t's with dashed line in another window
figure(2)
plot(tmln(2:T+1),zt,'--')
%annotate the chart
legend('z_t');
title('Sample path of increments z_t')

%homework assignment:

%PART 1
%Add another (outer) loop over N, the number of paths and simulate N paths
%storing each in a new row of wt. The outer loop onver N should include the one
%shown above that generates one path.
%dont foget to draw new set of zt each time!
%To address an element of wt use nontation w(j,i)=....; where 'j' is a loop
%counter for the current path you simulate.

%track the execution time for this loop for later comparison to another
%method
cpt=cputime;

for j=1:N
    %note that we need to update zt for each new draw to be independent!
    zt=randn(1,T);
    for i=1:T
         wt(j,i+1)=wt(j,i)+zt(i)*(dt)^(0.5);
    end
end

%this will time the execution of the loop for later comparison
method1_time=cputime-cpt;

%PART 2
%using matrix of wt constructed in part 1
%construct changes of wt from time 0.2 to 0.5 for each of N realizations
%store the increments in a vector dw. Refer to basic.m tutorial on matrix
%operations
%Compute the mean and the variance of these increments using mean and var
%fnctions applied to dw
%report your results

%first locate indexes corresponding to times of 0.2 and 0.5:
tstrt= 0.2/dt; %you could use as alternative fucntion =find(tmln==0.2);
tend= 0.5/dt; % or = find(tmln==0.5)

%then construct increment of BM process between two times by subtracting
%corresponding columns from wt matrix
dw=wt(:,tstrt)-wt(:,tend);

%computing and printing mean and variance
echo on
meandw=mean(dw)
vardw=var(dw)
echo off

pause

%alternative vectorizd syntax for simulataion
%speeds up the code considerably

%for comparison we track this method as before using cputime funciton:
cpt=cputime;

%draw all zt's at once as a matrix N by T with each row corresponding
%to one run of the simulation

zt1=randn(N,T);

%then use cumulative sum command for matrices to sum up along the rows
%dimension 2, type 'help cumsum' at the prompt for proper usage

wt1 = cumsum(zt1*(dt^0.5),2);

%stop the timer to compare methods:
method2_time=cputime-cpt;

%print comparison results
fprintf('%30s\n','Timing results (sec)' )
fprintf('%-20s %-5.3f \n','method1',method1_time)
fprintf('%-20s %-5.3f \n','method2',method2_time)
fprintf('%-20s %-5.3f \n\n\n','difference', method1_time-method2_time)


%repeat homework computations:
dw1=wt1(:,tstrt)-wt1(:,tend);
%computing and printing mean and variance
echo on
meandw=mean(dw1)
vardw=var(dw1)
echo off
