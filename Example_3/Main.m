%%%%%%%% To understand the code read article %%%%%%%%%%%%
%% A COMPUTATIONAL APPROACH FOR THE INVERSE PROBLEM OF %% 
%%        NEURAL CONDUCTANCES DETERMINATION            %%
%%                   Example 3.3                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;close all;clear all                                   
global T N J dt dx  A1 B1 Vv Uu Ek Ena a b d h p q r Vp             
                                                                  
%%%%%%%%%%%         Start: defining PDE      %%%%%%%%%%%%%%%%%%%%|
                                                                %|
%---             Set the intervals  [0 T] [0 L]               ---%|
L=1;  J=50;  x=linspace(0,L,J);  dx = x(2)-x(1);                %|
T=1;  N=50;  t=linspace(0,T,N);  dt = t(2)-t(1);                %|
                                                                %|
%---               Set the parameters                        ---%|
c=1;    Ek=0.0;    Ena=1.0;                                     %|
                                                                %|
%---                Inicial Condition                        ---%|
r=4.0*cos(x);                                                   %|
                                                                %|
%---                Boundary condition                       ---%|
p=0.5*exp(t);   q=0.0*sin(t)+0.0*exp(-t);                       %|
                                                                %|
%---                  Guess initial                             %|
gK=2*(exp(8*x-4)-1)./(exp(8*x-4)+1)+2;     gKk =0*x+2.0;        %|
                                                                %|
%---                 Goal function (g_K)                     ---%|
gNa=1*(exp(6*x-3)-1)./(exp(6*x-3)+1)+1;    gNak=0*x+2.0;        %|
                                                                %|
%---     Perturbation of the Voltage (in percentage )        ---%|
MaxErro=1.0/100;                                         %|
                                                                %|
%---                For the stop criterion                   ---%|
tau =2.01;                                                      %|
                                                                %|
%%%%%%%%%-------             End              -------%%%%%%%%%%%%|

%-------           We denote the constants             ---------% 
a=dt/(c*dx^2);    d=dt/c;      h=dt/(c*dx);
                        
%-------         Calculating Vexa given  gK            ---------%
Vpp=zeros(N,J);  [Vexa U] =VsoluI(gK,gNa,Vpp);

%-------     Making the pertubation of Vexa in Vp      ---------%
Vp=Vexa + (-MaxErro+(2*MaxErro).*rand(N,J)).*Vexa;

%-------  Calculing delta for the equation (9) of the paper ----%
delta=MaxErro*sqrt( dt*dx*sum ( sum( Vexa.^2 )  )  );

gK1=gKk;  gNa1=gNak;

%---------                  k ====== 1             ------------%
k=1;  [Vk Uk]=VsoluI(gKk,gNak,Vp);

%------       Calculing of the residue: ||Vp-Vk||  ------%
  ResiduoV=sqrt( dt*dx*[ sum(sum( (Vp -Vk )'.^2 ) )  ] ); 
  Residuo(k)=ResiduoV;
%------              Calculating the Error         ------%
  Erro =1/2*1/J*(  sum ( abs( (gK -gKk )./gK ) + abs( (gNa -gNak )./gNa  ) ) )*100;    
  Error(k) = Erro;
%------                    Print                   ------%
  fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');

k=0;
%for k=0:50      
while(tau*delta<=ResiduoV) 
k=k+1;                               

%-----        Calculating the iteration k+1           -----%
  for i=1:J
   adjK(i) =1/T*dt*sum ( ( Vk(:,i)-Ek  ).*Uk(:,i) );
   adjNa(i)=1/T*dt*sum ( ( Vk(:,i)-Ena ).*Uk(:,i) );
  end
  gKk=gKk -adjK;   gNak=gNak-adjNa;

%-----              Calculating  Vk, Uk               -----%
  [Vk Uk]=VsoluI(gKk,gNak,Vp);
              

%-----   Calculing of the residue: ||Vp-Vk||        -------%
  ResiduoV=sqrt( dt*dx*[ sum(sum( (Vp -Vk )'.^2 ) )  ] ); ; 
  Residuo(k)=ResiduoV;
 
%-----           Calculing the Error                ------%
  Erro =1/2*1/J*(  sum ( abs( (gK -gKk )./gK ) + abs( (gNa -gNak )./gNa  ) ) )*100;
  Error(k) = Erro;

%------                    Print                   ------%
  fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');
end

save('Example3-1.txt','Vexa','-ascii');
save('Example3-2.txt','gK','gK1','gKk','gNa','gNa1','gNak','x','-ascii');
save('Example3-3.txt','t','-ascii');
k=linspace(1,k,k);
save('Example3-4.txt','Residuo','Error','k','-ascii');
save('Example3-5.txt','Vp','-ascii');
save('Example3-6.txt','Vk','-ascii');
