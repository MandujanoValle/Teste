%%-------------------------------------%%
%%             Figures                 %%
%%          Example 3.1                %%
%%-------------------------------------%%
clc;close all;clear all                        
A        =importdata('Example1-1.txt');
t        =importdata('Example1-2.txt');
Vexa     =importdata('Example1-3.txt');
Vp       =importdata('Example1-4.txt');
Vk       =importdata('Example1-5.txt');
B        =importdata('Example1-6.txt');

gk=A(1,:);   gk1=A(2,:);  gkk=A(3,:); x=A(4,:);   Residuo=B(1,:); Error=B(2,:); k=B(3,:);

%-----------------------   Figures of Vexa, Vp and Vk  --------------------------%
figure
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',20)
plot(t,Vexa(:,20),'r-*',t,Vp(:,20),'c-o',t,Vexa(:,1),'b-*',t,Vp(:,1),'g-o','LineWidth',2,'MarkerSize',10);
xlabel('Time [ms]','fontsize',20);
ylabel('Voltage [mV]','fontsize',20);  
legend ({ 'V(t,L)' , 'V^\delta(t,L)' , 'V(t,0)' , 'V^\delta(t,0)' }, 'location','south','FontSize',20 ); 
saveas(gcf,'Ex1-1.eps', 'psc2')

%%------------------------    Figures of gk, gk1, gkk    --------------------------%
figure
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',20)
plot(x,gk,'r-*',x,gk1,'b-*',x,gkk,'g->','LineWidth',2,'MarkerSize',10);
legend({'Exact solution: g_K ','Initial data: g_K^{1,\delta} ','Approximate solution: g_K^{k_*,\delta}'},'Location','southeast','FontSize',20)
xlim([-0.01 1])
xlabel('Space [cm]','fontsize',20);
ylabel('g_K, g_K^{1,\delta}, g_K^{k_*,\delta}','fontsize',20);  
saveas(gcf,'Ex1-2.eps', 'psc2')
%------------------     Figures of gkk-gk and V|r-Vk|r     --------------------%
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(x,gk-gkk,'r-*','LineWidth',0.8,'MarkerSize',7);
legend({'g_K^{k_*,\delta}-g_K'},'Location','southwest','FontSize',10)
ylim([-0.6 0]);
xlabel('Space [cm]','fontsize',10);
title('Subplot A:  g_K-g_K^{k_*,\delta}')


subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(t,abs(Vexa(:,1)-Vk(:,1)),'r-*',t,abs(Vexa(:,20)-Vk(:,20)),'b-*','LineWidth',0.8,'MarkerSize',7);
legend({'V(t,0)-V^{k_*,\delta}(t,0)','V(t,L)-V^{k_*,\delta}(t,L)'},'Location','north','FontSize',10)
ylim([0 0.55]);
xlabel('Time [cm]','fontsize',10);
ylabel('Voltage [mV]','fontsize',10);  
title('Subplot B:  V|_{\Gamma}-V^{k_*,\delta}|_{\Gamma}') 
saveas(gcf,'Ex1-3.eps', 'psc2')


%%----------------  Figure of Error vs k =Iterations number  ----------------------%
figure; 
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Error,'LineWidth',2,'MarkerSize',12); 
xlabel('Iterations number','fontsize',10);
xlim([1 5]);
ylabel('Mean absolute percentage error','fontsize',10);                     
title('Subplot A');  
                     
subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Residuo,'LineWidth',2,'MarkerSize',12);                       
xlim([1 5]);
xlabel('Iterations number','fontsize',10);
ylabel('Residual','fontsize',10);  
title('Subplot B'); 
saveas(gcf,'Ex1-4.eps', 'psc2')

