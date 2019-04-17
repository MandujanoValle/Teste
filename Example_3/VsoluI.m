%%-------------------------------------%%
%%     Solution of V and U             %%
%%          Example 3.3                %%
%%-------------------------------------%%
function [V U]=VkaproximaI(gK,gNa,Vp)
global  N J a b d h p q r Ek Ena 

%------------ Matrix A ------------%                                          
        A =zeros(J,J); 

for i=1:J-1
A(i,i+1) = -a;  A(i+1,i)= -a;    A(i+1,i+1) = 1+2*a+d*( gK(i+1)+gNa(i+1) );
end             
A(1,1)   = 1+a+d*( gK(1)+gNa(1) );    A(J,J) = 1+a+d*( gK(J)+gNa(J) );
A=inv(A);
%-------------- find V -------------%
B =zeros(N,J);                                            
B(:,1) =-h*p;          B(:,J)=h*q; 

V(1,:)=r; 

for n=1:N-1
V(n+1,:)=[ V(n,:) + d*( gK*Ek + gNa*Ena ) + B(n+1,:) ]*A;
end

%-------------- find U -------------%
U=zeros(N,J); 

D=Vp-V;

U(N,:)=0;
for n=1:N-1
U(N-n,:)=[ U(N-n+1,:)+d*D(N-n,:) ]*A;
end
