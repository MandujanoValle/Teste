%%%%%%%% To understand the code read article %%%%%%%%%%%%
%% A COMPUTATIONAL APPROACH FOR THE INVERSE PROBLEM OF %% 
%%        NEURAL CONDUCTANCES DETERMINATION            %%
%%                   Example 3.4                       %%
%%             See equation (12) of paper              %%              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%   Figure %%%%%%%%%%%%%%%%%%%%%%
%                                                      %
%            Jb   np=JL1+1              JL2         %
%            ↑       ↑       ...           ↑           %
%            ------------------------------|           %
%            |                            xL2          %
%   |------- xb                                        %
%   x0       |                                         %
%   |        -------------------------------------|    %
%   ↓                 ↓                          xL1   %
%   ↓                 ↓                           ↓    %
%   1  2 3 ...   Jb    Jb+1     ...            JL1  %
%                                                      %
%  % x1: Vector from x0 to xb                          %
%  % x2: Vector from xb to xL1                         %
%  % x3: Vector from xb to xL2                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
clc;close all;clear all     
global  d  Jb JL1 A1 J Vo N f B1 d Vp p q s h a b
%%%%%%%%%%%         Start: defining PDE      %%%%%%%%%%%%%%%%%%%%|
                                                                %|
%---          Set the temporal variabel  [0 T]               ---%|
T=1;  N=300;  t=linspace(0,T,N);  dt=t(2)-t(1);                 %|
                                                                %|
%---              Set the spatial variability                   %|
x0=0;   xL1=2;    xL2=3;                                        %|
                                                                %|
%---               Set the parameters                        ---%|
c=2;            E=2;                                            %|
                                                                %|
%---              Set the poiN of bifurcation                   %|
xb=1;                                                           %|
                                                                %|
%---     The number of points of the spatial variable         --%|
nn=15;                                                          %|
%%%-----------------       Bifurcation       -----------------%%%|
                                                                %|
[Jb,JL1,np,JL2,x1,x2,x3,dx,x]=Fbifurcao(x0,xb,xL1,xL2,nn);      %| 
                                                                %|
  J1=length(x1);  % Number of poiNs from x0 to xb               %|
  J2=length(x2);  % Number of poiNs from xb to xL1              %|
  J3=length(x3);  % Number of poiNs from xb to xL2              %|
  J =length(x);   % Number of poiNs from x                      %|
%%%-----------------------------------------------------------%%%|
                                                                %|
%---                Inicial Condition                        ---%|
Vo=0*x+0*2;                                                     %|
                                                                %|
%---                Boundary condition                       ---%|
  p=2*t;      q=cos(t);     s=0*sin(t);                         %|
% For x=x0;   For x=xL1;    For x=xL2;                          %|
                                                                %|
%---                  Guess initial                             %|
gk=0+0*sin(x);                                                  %|
                                                                %|
%---                 Goal function (g_K)                     ---%|
g =exp(x);                                                      %|
                                                                %|
%---     Perturbation of the Voltage (in perceNage )        ---%|
MaxErro=1.000/100;                                                %|
                                                                %|
%---                For the stop criterion                   ---%|
tau =2.01;                                                      %|
                                                                %|
%%%%%%%%%-------             End              -------%%%%%%%%%%%%|

%-------       Stability  of explicit Euler method      ---------%
estabi=dt < 7/24*dx^2/(2+dx^2);
                                                          
%-------           We denote the constaNs              ---------%
a=dt/(c*dx^2);   b=-2*a+1;   d=dt/c;   f=dt*E/c;   h=dt/(c*dx);   
                                       
%-----------------       Solution of V       -----------------%
Vpp=zeros(N,J);   [Vexa Uexa]=Vkaprox(g,Vpp);

%------     Making the pertubation of Vexa in Vp      ---------%
Vp=Vexa + (-MaxErro+(2*MaxErro).*rand(N,J)).*Vexa;

%------ Calculing delta for the equation (9) of the paper ----%
delta=MaxErro*sqrt( dt*dx*sum ( sum( Vexa.^2 )  )  );

g1=gk;
%%--------------------       k=========1       ---------------%%
k=1;  [Vk Uk]=Vkaprox(gk,Vp);

%------       Calculing of the residue: ||Vp-Vk||  ------%
  ResiduoV=sqrt( dt*dx*sum( sum( (Vp-Vk).^2 ) ) ); 
  Residuo(k)=ResiduoV; 

%------              Calculating the Error         ------%
  Erro=1/J*sum( abs( ( gk -g )./g ) ) *100;    Error(k)=Erro;

%------                    Print                   ------%
  fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');

%for k=1:50
while(tau*delta<=ResiduoV)
k=k+1;                               

%-----        Calculating the iteration k+1           -----%  
  for i=1:J
    adj(i)=1/T*dt*(Vk(:,i)-E)'*Uk(:,i);
  end
  gk=gk-adj;                                                       
  
%-----              Calculating  Vk, Uk               -----%
  [Vk Uk]=Vkaprox(gk,Vp);

%-----   Calculing of the residue: ||Vp-Vk||        -------%
  ResiduoV=sqrt( dt*dx*sum( sum( (Vp-Vk).^2 ) ) ); 
  Residuo(k)=ResiduoV;                                                               
                                                             
%-----           Calculing the Error                ------% 
  Erro=1/J*sum( abs( ( gk -g )./g ) ) *100;    Error(k)=Erro;
  
%------                    Print                   ------%
  fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');                                                
end
ge1=g(1:J1);                   g1e1=g1(1:J1);                    gke1=gk(1:J1);
Ve1=Vexa(:,1:J1);              Vpe1=Vp(:,1:J1);                  Vke1=Vk(:,1:J1);

ge2=g(J1:J1+J2-1);             g1e2=g1(J1:J1+J2-1);              gke2=gk(J1:J1+J2-1); 
Ve2=Vexa(:,J1:J1+J2-1);        Vpe2=Vp(:,J1:J1+J2-1);            Vke2=Vk(:,J1:J1+J2-1);

ge3=g(J1+J2:J1+J2+J3-1);       g1e3=g1(J1+J2:J1+J2+J3-1);        gke3=gk(J1+J2:J1+J2+J3-1);
Ve3=Vexa(:,J1+J2:J1+J2+J3-1);  Vpe3 =Vp(:,J1+J2:J1+J2+J3-1);     Vke3=Vk(:,J1+J2:J1+J2+J3-1);

k=linspace(1,k,k);
save('Example4-1.txt','g','g1','gk','x','-ascii');
save('Example4-1e1.txt','ge1','g1e1','gke1','x1','-ascii');
save('Example4-1e2.txt','ge2','g1e2','gke2','x2','-ascii');
save('Example4-1e3.txt','ge3','g1e3','gke3','x3','-ascii');
save('Example4-2.txt','t','-ascii');
save('Example4-3.txt','x','-ascii');
save('Example4-4.txt','Ve1','-ascii');
save('Example4-5.txt','Vpe1','-ascii');
save('Example4-6.txt','Vke1','-ascii');
save('Example4-7.txt','Ve2','-ascii');
save('Example4-8.txt','Vpe2','-ascii');
save('Example4-9.txt','Vke2','-ascii');
save('Example4-10.txt','Ve3','-ascii');
save('Example4-11.txt','Vpe3','-ascii');
save('Example4-12.txt','Vke3','-ascii');
save('Example4-13.txt','Residuo','Error','k','-ascii');



