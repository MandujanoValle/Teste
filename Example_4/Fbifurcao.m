%-------------------------------------------------------%
%                  Solution of V and U                  %
%                      Example 3.4                      %
%-------------------------------------------------------%
%      |----------|-------------|----------------|      %
%      x0         xb           xL1              xL2     %
%      :---- a ---:----  b  ----:------ c -------:      %
%                                                       %
%  'a', 'b' e 'c' are integer numbers                   %
%                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [nxb,nxL1,np,nxL2,x1,x2,x3,dx,x]=Fbifurcao(x0,xb,xL1,xL2,n)
format rat   
%x0=0;  xL1=3;  xL2=4.5;   xb=1.5;

l=1;
while (mod(xb*l-x0*l,1)~=0 || mod(xL1*l-xb*l,1)~=0 || mod(xL2*l-xL1*l,1)~=0)
l=l+1;
end
NI0b =(xb-x0)*l*n         ;           % Number of intervals from 'x0' to 'xb'
NIbL1=(xL1-xb)*l*n        ;           % Number of intervals from 'xb' to 'xL1'
NIbL2=(xL2-xL1)*l*n       ;           % Number of intervals from 'xL1'to 'xL2'
                                     
                          ;           % x0      Occupy position 1
nxb =NI0b+1               ;           % xb      Occupy position nxb
nxL1=NI0b+NIbL1+1         ;           % xL1     Occupy position nxL1 
np  =NI0b+NIbL1+2         ;           % xL1+dx  Occupy position np
nxL2=NI0b+2*NIbL1+NIbL2+1 ;           % xL2     Occupy position nxL2
                                      

format                                
x1=linspace(x0,xb ,NI0b+1);           % vector x1 from x0 to xb
x2=linspace(xb,xL1,NIbL1+1);          % vector x2 from xb to xL1
x3=linspace(xb,xL2,NIbL1+NIbL2+1);    % vector x3 from xb to xL2
dx=x1(2)-x1(1);                       % x1(2)-x1(1)=x2(2)-x2(1)=x3(2)-x3(1)

x=[x1 x2(2:NIbL1+1) x3(1:NIbL1+NIbL2+1)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                     %
%                a+1  a+b+2                      a+2b+c+1             %
%                ↑       ↑       ...                 ↑                %
%                ------------------------------------|                %
%                |                                  xL2               %
%   |------------- xb                                                 %
%   x0           |                                                    %
%   |            ----------------------------------------------|      %
%   ↓                 ↓                                       xL1     %
%   ↓                 ↓                                        ↓      %
%   1  2 3 ...  a+1    a+2     ...                           a+b+1    %
%                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
