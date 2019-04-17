%%%%%%%% To understand the code read article %%%%%%%%%%%%
%% A COMPUTATIONAL APPROACH FOR THE INVERSE PROBLEM OF %% 
%%        NEURAL CONDUCTANCES DETERMINATION            %%
%%                 Example 3.2                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;close all;clear all                                   
global T N J dt dx  A1 B1 Vv Uu Ek a b d h p q r Vp             
                                                                  
%%%%%%%%%%%         Start: defining PDE      %%%%%%%%%%%%%%%%%%%%|
                                                                %|
%---             Set the iNervals  [0 T] [0 L]               ---%|
L=1;    J=50;    x=linspace(0,L,J);   dx = x(2)-x(1);           %|
T=1;    N=50;    t=linspace(0,T,N);   dt = t(2)-t(1);           %|
                                                                %|
%---               Set the parameters                        ---%|
c=1.0;    Ek=1;                                                 %|
                                                                %| 
%---                Inicial Condition                        ---%|
r=sin(x);                                                       %|
                                                                %|
%---                Boundary condition                       ---%|
p=1*exp(t);   q=0*exp(-t);                                      %|
                                                                %|
%---                  Guess initial                             %|
[X,T]=meshgrid(x,t);  gkk=0*(X);                                %|
                                                                %|
%---                 Goal function (g_K)                     ---%|
gk=1/2*( exp(8*X-4)-1 )./( exp(8*X-4)+1 ) + T + 1 ;             %|
                                                                %|
%---     Perturbation of the Voltage (in percentage )        ---%|
MaxErro=1.000/100;                                               %|
                                                                %|
%---                For the stop criterion                   ---%|
tau =2.01;                                                      %|
                                                                %|
%%%%%%%%%-------             End              -------%%%%%%%%%%%%|
  
%-------           We denote the constants             ---------%
a=dt/(c*dx^2);  b=1+2*a;   d=dt/c;   h=dt/(c*dx);
                        
%-------         Calculating Vexa given  gk            ---------%
Vpp=zeros(N,J);  [Vexa U] =VsoluI(gk,Vpp);

%-------    Making the pertubation of Vexa in Vp       ---------%
 Vp=Vexa + (-MaxErro+(2*MaxErro).*rand(N,J)).*Vexa;

%---------  Calculing delta (see paper, equation (9) ) ---------%
 delta=MaxErro*sqrt( dt*dx*sum ( sum( Vexa.^2 )  )  );

 gk1=gkk;

%%--------------            k=========1           --------------%
 k=1;   [Vk Uk]=VsoluI(gkk,Vp);

%------       Calculing of the residue: ||Vp-Vk||  ------%
 ResiduoV=sqrt( dt*dx*[ sum(sum( (Vp -Vk )'.^2 ) )  ] ) ;
 Residuo(k)=ResiduoV;
 
%------              Calculating the Error         ------%
 Erro =1/J*1/N*sum(  sum ( abs( (gk -gkk )./gk ) ) )*100;    Error(k) = Erro;
 
%------                    PriN                   ------%
 fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');

while(tau*delta<=ResiduoV) 
k=k+1;                               

%-----        Calculating the iteration k+1           -----%
 gkk=gkk -(Vk-Ek).*Uk;

%-----              Calculating  Vk, Uk               -----%
 [Vk Uk]=VsoluI(gkk,Vp);

%-----   Calculing of the residue: ||Vp-Vk||        -------%
 ResiduoV=sqrt( dt*dx*[ sum(sum( (Vp -Vk )'.^2 ) )  ] ) ;
 Residuo(k)=ResiduoV;

%-----           Calculing the Error                ------%
 Erro =1/J*1/N*sum(  sum ( abs( (gk -gkk )./gk ) ) )*100;    Error(k) = Erro;

%------                    Print                   ------%
 fprintf('%10.6f\t\t',MaxErro*100,k,Erro,ResiduoV,tau*delta); fprintf('\n\n');
                            

end

R=abs(Vp-Vexa);
save('Example2-1.txt','T','-ascii'   );   save('Example2-2.txt','X','-ascii' ); 
save('Example2-3.txt','Vexa','-ascii');   save('Example2-4.txt','Vp','-ascii' );  
save('Example2-5.txt','Vk','-ascii'  );   save('Example2-6.txt','gk','-ascii' ); 
save('Example2-7.txt','gk1','-ascii' );   save('Example2-8.txt','gkk','-ascii'); 
k=linspace(1,k,k); 
save('Example2-9.txt','Residuo','Error','k','-ascii');

