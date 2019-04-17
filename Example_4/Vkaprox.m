%%-------------------------------------%%
%%     Solution of V and U             %%
%%          Example 3.4                %%
%%      Explicit Euluer Method         %%
%%-------------------------------------%%
function [V U]=Vkaprox(g, Vp)  
global  d  Jb JL1 A1 J N Vo f p q s h a b
      
%----------------- Calculating the matrix A1 ------------------% 
for i=1:J-1                                                    
A1(i,i+1) =a;    A1(i+1,i) =a;    A1(i+1,i+1) =b;                 
end                                                               
A1(1,1)        =-a+1;  A1(JL1,JL1) =-a+1 ;  A1(J,J)  =-a+1 ; 
A1(Jb,Jb)    = 0  ;  A1(Jb,Jb-1) =a+b/3;  A1(Jb,Jb+1)  =a+b/3; 
A1(Jb,JL1+1) =b/3 ;  A1(JL1+1,Jb)=a    ;  A1(JL1+1,JL1)=0    ; 
A1(JL1,JL1+1)=0   ;

%------------  Matrix A2  ------------%   
A2=zeros(J,J);      
A2=-d*diag(g);                                                  
A2(Jb,Jb)=0            ;    A2(Jb,Jb-1) =-d*g(Jb)/3;         
A2(Jb,Jb+1)=-d*g(Jb)/3;    A2(Jb,JL1+1)=-d*g(Jb)/3;         
A=A1+A2; 

%-------------- find V -------------%
B1=zeros(J,N); 
B1(1,:) =-h*p;  B1(JL1,:)=h*q;  B1(J,:)=h*s;
B=B1+f*g'*ones(1,N);

V(1,:)=Vo;                                   
for n=1:N-1                                                      
V(n+1,:)=A*V(n,:)'+B(:,n);                                      
end                                                               


%-------------- find U -------------%
D=d*(Vp-V)';

U(N,:)=zeros(1,J);
for n=1:N-1
U(N-n,:)=A*U(N-n+1,:)'+D(:,N-n+1);
end
