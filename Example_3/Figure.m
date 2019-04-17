%%-------------------------------------%%
%%             Figures                 %%
%%          Example 3.3                %%
%%-------------------------------------%%
clc;close all;clear all                        
Vexa     =importdata('Example3-1.txt');
A        =importdata('Example3-2.txt');
t        =importdata('Example3-3.txt');
B        =importdata('Example3-4.txt');
Vp       =importdata('Example3-5.txt');
Vk       =importdata('Example3-6.txt');
gK=A(1,:); gK1=A(2,:); gKk=A(3,:); gNa=A(4,:); gNa1=A(5,:); gNak=A(6,:); x=A(7,:);
Residuo=B(1,:); Error=B(2,:); k=B(3,:);
%-----------------------   Figures of Vexa, Vp and V   --------------------------%
[X,T]=meshgrid(x,t);
figure
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',20)
surf(X,T,Vexa);
colormap;
xlabel('Space [cm]','fontsize',15);
ylabel('Time [ms]','fontsize',15); 
zlabel('V','fontsize',15);
shading flat 
saveas(gcf,'Ex3-0.eps', 'psc2')

figure
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',20)
surf(X,T,Vexa-Vp);
colormap;
xlabel('Space [cm]','fontsize',15);
ylabel('Time [ms]','fontsize',15); 
zlabel('V-V^\delta','fontsize',15);
zlim([-0.3  0.3]);
shading flat 
saveas(gcf,'Ex3-1.eps', 'psc2')


%----------    Figures of gK, gK1, gKk, and gNa, gNa1, gNak  --------------------%
figure
subplot(211);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(x,gK,'r-*',x,gK1,'b-*',x,gKk,'g->','LineWidth',1,'MarkerSize',8);
legend({'Exact solution: g_K ','Initial data: g_K^{1,\delta} ','Approximate solution: g_K^{k_*,\delta}'},'Location','north','FontSize',10,'Location' , 'southeast')
grid
xlabel('Space [cm]','fontsize',10);
ylabel('g_K, g_K^{1,\delta}, g_K^{k_*,\delta}','fontsize',10);  
title('Subplot A:  Function g_K');

subplot(212);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(x,gNa,'r-*',x,gNa1,'b-*',x,gNak,'g->','LineWidth',1,'MarkerSize',8);
legend({'Exact solution: g_{Na} ','Initial data: g_{Na}^{1,\delta} ','Approximate solution: g_{Na}^{k_*,\delta}'},'Location','north','FontSize',10,'Location' , 'southeast')
grid
xlabel('Space [cm]','fontsize',10);
ylabel('g_{Na}, g_{Na}^{1,\delta}, g_{Na}^{k_*,\delta}','fontsize',10);  
title('Subplot B:  Function g_{Na}');
saveas(gcf,'Ex3-2.eps', 'psc2')


%----------     Figures of gK-gKk, gNa-gNak and Vexa-Vk     --------------------%
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(x,gK-gKk,'r-*',x,gNa-gNak,'b-*','LineWidth',1,'MarkerSize',8);
legend({'g_K-g_K^{k_*,\delta}','g_{Na}-g_{Na}^{k_*,\delta}'},'FontSize',10,'Location' ,'east')
grid
xlabel('Space [cm]','fontsize',10);
title('Subplot A: g_K-g_K^{k_*,\delta} and g_{Na}-g_{Na}^{k_*,\delta}');

subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(X,T,Vexa-Vk);
colormap;
xlabel('Space [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^{k_*\delta}','fontsize',10);
title('Subplot B: V-V^{k_*,\delta}');
shading flat 
saveas(gcf,'Ex3-3.eps', 'psc2')



%---------------- Figure Error and Residual vs k=iteration number ---------------%
figure; 
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Error,'LineWidth',2,'MarkerSize',12); 
xlim([1 160]); 
xlabel('Iterations number','fontsize',10);
ylabel('Mean absolute percentage error','fontsize',10);                     
title('Subplot A');                       
subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Residuo,'LineWidth',2,'MarkerSize',12);                       
xlim([1 160]);
xlabel('Iterations number','fontsize',10);
ylabel('Residual','fontsize',10);  
title('Subplot B'); 
saveas(gcf,'Ex3-4.eps', 'psc2')

