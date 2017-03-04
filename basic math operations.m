%this is basic tutorial on matrix and vector manipulation

echo on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%assign a matrix or vector manually

a=[ 1 2 3 ; 4 5 6 ; 7 8 9]

a1=1:2:11

%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%special matricies

b=zeros(2,3)

%hit any key to proceed
pause

ident=eye(3)

%hit any key to proceed
pause

c= ones(1,3)

%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get a vector subset of a matrix
d = a(:,2) %this is column #2 from a
d23= a(:,[1 3]) % this is columns 1 and 3 from a
%hit any key to proceed
pause

e = a(3,:) % this is row #3 from a
e12 = a([1 2],:) % this is rows 1 and 2 from a
%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%matrix operations

%transpose
atrns=a'

dtrans=d'

%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%combine by stacking or extending
bonc=[b ; c]

cone = [c ; e]

ewithc= [ e c]

dprwithc = [d'  c]

%hit any key to pr oceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%add/subtract
aplusbonc = a+bonc

aminusbonc= a-bonc

%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%multiplication
%make sure the dimensions agree, otherwise use ' (prime) to transpose
%vector or matrix

ad= a*d

dpa= d'*a

cacp=c*a*c'

epe=e'*e

%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mean adn variance of values in a vector
meane=mean(e)

meane=mean(d)

vare=var(e)

vard=var(d)

%hit any key to proceed
pause

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mean and variance of matrix gives variances within each column
meana=mean(a)

vara=var(a)

%comapre to
meana1=[mean(a(:,1)) mean(a(:,2)) mean(a(:,3))]

vara1=[var(a(:,1)) var(a(:,2)) var(a(:,3))]


echo off