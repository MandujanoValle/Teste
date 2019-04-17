%%-------------------------------------%%
%%             Figures                 %%
%%          Example 3.2                %%
%%-------------------------------------%%
%%%------------------------------------------%%
clc;close all;clear all                        
T        =importdata('Example2-1.txt');
X        =importdata('Example2-2.txt');
Vexa     =importdata('Example2-3.txt');
Vp       =importdata('Example2-4.txt');
Vk       =importdata('Example2-5.txt');
gk       =importdata('Example2-6.txt');
gk1      =importdata('Example2-7.txt');
gkk      =importdata('Example2-8.txt');
B        =importdata('Example2-9.txt');
Residuo=B(1,:); Error=B(2,:); k=B(3,:);
%-----------------------   Figures of Vexa, Vp and Vk  --------------------------%
figure
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',20)
surf(X,T,Vexa);
colormap;
xlabel('Space [cm]','fontsize',15);
ylabel('Time [ms]','fontsize',15); 
zlabel('V','fontsize',15);
shading flat 
saveas(gcf,'Ex2-0.eps', 'psc2')

figure
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',20)
surf(X,T,Vexa-Vp);
colormap;
xlabel('Space [cm]','fontsize',15);
ylabel('Time [ms]','fontsize',15); 
zlabel('V-V^\delta','fontsize',15);
zlim([-0.04 0.04]);
shading flat 
saveas(gcf,'Ex2-1.eps', 'psc2')

%--------------------- Figures of gk, gkk, gk-gkk and Vexa-Vk ---------------------%
figure;
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(X,T,gk)
xlabel('Space [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10);
shading flat
title('Subplot A:  g_K')


subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(X,T,gkk)
xlabel('Space [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10);
shading flat
title('Subplot B:   g_K^{k_*,\delta}')

subplot(223);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(X,T,gk-gkk )
xlabel('Space [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10);  
shading flat
colormap(jet(30))
title('Subplot C:  g_K-g_K^{k_*,\delta}')

subplot(224);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(X,T,Vexa-Vk )
xlabel('Space [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10);  
shading flat
title('Subplot D:  V-V^{k_*,\delta}')
saveas(gcf,'Ex2-2.eps', 'psc2')

%---------------- Figure Error and Residual vs k=iteration number ---------------%
figure; 
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Error,'LineWidth',2,'MarkerSize',12);  
xlabel('Iterations number','fontsize',10);
xlim([1 450])
ylabel('Mean absolute percentage error','fontsize',10);                     
title('Subplot A');                       
subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Residuo,'LineWidth',2,'MarkerSize',12);                       
xlabel('Iterations number','fontsize',10);
xlim([1 450])
ylabel('Residual','fontsize',10);  
title('Subplot B'); 
saveas(gcf,'Ex2-3.eps', 'psc2')
