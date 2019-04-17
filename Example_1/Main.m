%%%%%%%%      To understand the code read article     %%%%%%%%%%%%
%%     A COMPUTATIONAL APPROACH FOR THE INVERSE PROBLEM OF      %% 
%%             NEURAL CONDUCTANCES DETERMINATION                %%
%%                       Example 3.1                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;close all;clear all                                   
global T N J dt dx  A1 B1 Vv Uu Ek a b d h p q r Vp             
                                                                  
%%%%%%%%%%%         Start: defining PDE      %%%%%%%%%%%%%%%%%%%%|
                                                                %|
%---             Set the intervals  [0 T] [0 L]              ---%|
L=1;   J=50;    x=linspace(0,L,J);   dx = x(2)-x(1);            %|
T=1;   N=50;    t=linspace(0,T,N);   dt = t(2)-t(1);            %|
                                                                %|
%---               Set the parameters                        ---%|
c=1;    Ek=0.0;                                                 %|
                                                                %|
%---                Inicial Condition                        ---%|
r=2.5*tan(x);                                                   %|
                                                                %|
%---                Boundary condition                       ---%|
p=exp(-t);   q=2*exp(-t);                                       %|
                                                                %|
%---                  Guess initial                             %|
gkk =0*x;                                                       %|
                                                                %|
%---                 Goal function (g_K)                     ---%|
gk=sec(x);                                                    %|
                                                                %|
%---     Perturbation of the Voltage (in percentage )        ---%|
MaxErro=5.00/100;                                              %|
                                                                %|
%---                For the stop criterion                   ---%|
tau =2.01;                                                      %|
                                                                %|
%%%%%%%%%-------             End              -------%%%%%%%%%%%%|
  
%-------           We denote the constants            ----------%   
a=dt/(c*dx^2);  d=dt/c;   h=dt/(c*dx);

%-------         Calculating Vexa given  gk            ---------%
Vpp=zeros(N,J); [Vexa U] =VsoluI(gk,Vpp);

%----------    Making the pertubation of Vexa in Vp    ---------%
Vp=Vexa + (-MaxErro+(2*MaxErro).*rand(N,J)).*Vexa;

%---------  Calculing delta (see paper, equation (9) ) ---------%
delta=MaxErro*sqrt( dt*[ sum( Vexa(:,1).^2  +  Vexa(:,J).^2 ) ] );

gkk1=gkk;
%---------                  k ====== 1             ------------%
k=1;  [Vk Uk]=VsoluI(gkk,Vp);

%------       Calculing of the residue: ||Vp-Vk||  ------%
  ResiduoV=sqrt( dt*[ sum( (Vp(:,1) -Vk(:,1) )'.^2 ) + sum( (Vp(:,J)-Vk(:,J))'.^2 ) ] ) ; 
  Residuo(k)=ResiduoV;
%------              Calculating the Error         ------%
  Erro =1/J*  sum ( abs( (gk -gkk )./gk ) ) *100;    Error(k) = Erro;

%------                    Print                   ------%
  fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');

while(tau*delta<=ResiduoV) 
k=k+1;                               

%-----        Calculating the iteration k+1           -----%
  for i=1:J
   adj(i)=1/T*dt*sum ( ( Vk(:,i)-Ek ).*Uk(:,i) );                                                    
  end
  gkk=gkk -adj;

%-----              Calculating  Vk, Uk               -----%
  [Vk Uk]=VsoluI(gkk,Vp);
              
%-----   Calculing of the residue: ||Vp-Vk||        -------%
  ResiduoV=sqrt( dt*[ sum( (Vp(:,1) -Vk(:,1) )'.^2 ) + sum( (Vp(:,J)-Vk(:,J))'.^2 ) ] ) ; 
  Residuo(k)=ResiduoV;
 
%-----           Calculing the Error                ------%
  Erro =1/J*  sum ( abs( (gk -gkk )./gk ) ) *100;    Error(k) = Erro;

%------                    Print                   ------%
  fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');
end

k=linspace(1,k,k); 

save('Example1-1.txt','gk','gkk1','gkk','x','-ascii');save('Example1-2.txt','t','-ascii');
save('Example1-3.txt','Vexa','-ascii');               save('Example1-4.txt','Vp','-ascii');
save('Example1-5.txt','Vk','-ascii');

save('Example1-6.txt','Residuo','Error','k','-ascii');





