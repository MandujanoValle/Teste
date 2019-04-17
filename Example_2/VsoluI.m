%%-------------------------------------%%
%%     Solution of V and U             %%
%%          Example 3.2                %%
%%-------------------------------------%%
function [V U]=VkaproximaI(gk,Vp)                                    
global  N J a b d h p q r Ek 

%------------ Matrix A ------------%                                          
A =zeros(J,J); 
for i=1:J-1
      A(i,i+1) = -a ;  A(i+1,i)= -a  ;  A(i+1,i+1) = 1+2*a;
end;  A(1,1)   = 1+a;  A(J,J) = 1+a;  


%-------------- find V -------------%
B =zeros(N,J);                                            
B(:,1) =-h*p;          B(:,J)=h*q; 

V(1,:)=r; 

for n=1:N-1
V(n+1,:)=[V(n,:)+d*gk(n+1,:)*Ek+B(n+1,:)]*inv( A+d*diag(gk(n+1,:)) );
end

%-------------- find U -------------%
U=zeros(N,J); 

D=Vp-V;


U(N,:)=[h*D(N,:)]*inv( A+d*diag(gk(N,:)) );
for n=1:N-1
U(N-n,:)=[U(N-n+1,:)+d*D(N-n,:)]*inv( A+d*diag(gk(N-n,:)) );
end


