%%-------------------------------------%%
%%             Figures                 %%
%%          Example 3.4                %%
%%-------------------------------------%%
clc;close all;clear all
A          =importdata('Example4-1.txt');
Ae1        =importdata('Example4-1e1.txt');
Ae2        =importdata('Example4-1e2.txt');
Ae3        =importdata('Example4-1e3.txt');
t          =importdata('Example4-2.txt');
x          =importdata('Example4-3.txt');
Ve1        =importdata('Example4-4.txt');
Vpe1       =importdata('Example4-5.txt');
Vke1       =importdata('Example4-6.txt');
Ve2        =importdata('Example4-7.txt');
Vpe2       =importdata('Example4-8.txt');
Vke2       =importdata('Example4-9.txt');
Ve3        =importdata('Example4-10.txt');
Vpe3       =importdata('Example4-11.txt');
Vke3       =importdata('Example4-12.txt');
B          =importdata('Example4-13.txt');

g  =A  (1,:);   g1  =A(2,:)  ;  gk  =A(3,:);   x  =A(4,:);   
ge1=Ae1(1,:);   g1e1=Ae1(2,:);  gke1=Ae1(3,:); xe1=Ae1(4,:);
ge2=Ae2(1,:);   g1e2=Ae2(2,:);  gke2=Ae2(3,:); xe2=Ae2(4,:);
ge3=Ae3(1,:);   g1e3=Ae3(2,:);  gke3=Ae3(3,:); xe3=Ae3(4,:);
Residuo=B(1,:); Error=B(2,:); k=B(3,:);

%-----------------------   Figures of Ve1 and Ve1-Vpe1  --------------------------%
[Xe1,T1]=meshgrid(xe1,t);
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe1,T1,Ve1);
colormap;
xlabel('Edge e_1 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V [mV]','fontsize',10);
title('Subplot A: Edge e_1');
shading flat 

subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe1,T1,Ve1-Vpe1);
colormap;
xlabel('Edge e_1 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^\delta [mV]','fontsize',10);
zlim([-0.05  0.05]);
title('Subplot B: Edge e_1');
shading flat 
saveas(gcf,'Ex4-1.eps', 'psc2')

%-----------------------   Figures of Ve2 and Ve2-Vpe2  --------------------------%
[Xe2,T2]=meshgrid(xe2,t);
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe2,T2,Ve2);
colormap;
xlabel('Edge e_2 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V [mV]','fontsize',10);
title('Subplot A: Edge e_2');
shading flat 


subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe2,T2,Ve2-Vpe2);
colormap;
xlabel('Edge e_2 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^\delta [mV]','fontsize',10);
zlim([-0.05  0.05]);
title('Subplot B: Edge e_2');
shading flat 
saveas(gcf,'Ex4-2.eps', 'psc2')

%-----------------------   Figures of Ve3 and Ve3-Vpe3  --------------------------%
[Xe3,T3]=meshgrid(xe3,t);
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe3,T3,Ve3);
colormap;
xlabel('Edge e_3 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V [mV]','fontsize',10);
title('Subplot A: Edge e_3');
shading flat 


subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe3,T3,Ve3-Vpe3);
colormap;
xlabel('Edge e_3 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^\delta [mV]','fontsize',10);
zlim([-0.05  0.05]);
title('Subplot B: Edge e_3');
shading flat 
saveas(gcf,'Ex4-3.eps', 'psc2')


%%------------------------    Figures of gk, gk1, gkk    --------------------------%
figure
subplot(2,2,1);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(xe1,ge1,'r-*',xe1,g1e1,'b-*',xe1,gke1,'g-o','LineWidth',0.8,'MarkerSize',6);
legend({'Exact solution: g_K ','Initial data: g_K^{1,\delta} ','Approximate solution: g_K^{k_*,\delta}'},'Location','southeast','FontSize',7)
xlabel('Edge e_1 [cm]','fontsize',10);
ylabel('g_K, g_K^{1,\delta}, g_K^{k_*,\delta}','fontsize',10);  
title('Subplot A: Edge e_1')

subplot(2,2,2);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(xe2,ge2,'r-*',xe2,g1e2,'b-*',xe2,gke2,'g-o','LineWidth',0.8,'MarkerSize',6);
legend({'Exact solution: g_K ','Initial data: g_K^{1,\delta} ','Approximate solution: g_K^{k_*,\delta}'},'Location','southeast','FontSize',7)
xlabel('Edge e_2 [cm]','fontsize',10);
ylabel('g_K, g_K^{1,\delta}, g_K^{k_*,\delta}','fontsize',10);  
title('Subplot B: Edge e_2')


pos1=[0.23 0.1 0.6 0.33];
subplot('Position',pos1)
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(xe3,ge3,'r-*',xe3,g1e3,'b-*',xe3,gke3,'g-o','LineWidth',0.8,'MarkerSize',6);
legend({'Exact solution: g_K ','Initial data: g_K^{1,\delta} ','Approximate solution: g_K^{k_*,\delta}'},'Location','northwest','FontSize',7)
xlabel('Edge e_2 [cm]','fontsize',10);
ylabel('g_K, g_K^{1,\delta}, g_K^{k_*,\delta}','fontsize',10);  
title('Subplot C: Edge e_3')
saveas(gcf,'Ex4-4.eps', 'psc2')


%%-----------     Figures of  ge1-gke1 and Ve1-Vke1     --------------------%
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(xe1,ge1-gke1,'LineWidth',1,'MarkerSize',8);
ylabel('g_K-g_K^{k_*,\delta}','fontsize',10);
xlabel('Edge e_1 [cm]','fontsize',10);
title('Subplot A: Edge e_1');

subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe1,T1,Ve1-Vke1);
colormap;
xlabel('Edge e_1 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^{k_*\delta} [mV]','fontsize',10);
title('Subplot B: Edge e_1');
shading flat 
saveas(gcf,'Ex4-5.eps', 'psc2')


%%-----------     Figures of  ge2-gke2 and Ve2-Vke2     --------------------%
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(xe2,ge2-gke2,'LineWidth',1,'MarkerSize',8);
xlabel('Edge e_2 [cm]','fontsize',10);
ylabel('g_K-g_K^{k_*,\delta}','fontsize',10);
title('Subplot A: Edge e_2');


subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe2,T2,Ve2-Vke2);
colormap;
xlabel('Edge e_2 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^{k_*\delta} [mV]','fontsize',10);
title('Subplot B: Edge e_2');
shading flat 
saveas(gcf,'Ex4-6.eps', 'psc2')


%%-----------     Figures of  ge2-gke2 and Ve2-Vke2     --------------------%
figure
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(xe3,ge3-gke3,'LineWidth',1,'MarkerSize',8);
xlabel('Edge e_3 [cm]','fontsize',10);
ylabel('g_K-g_K^{k_*,\delta}','fontsize',10);
title('Subplot A: Edge e_3');

subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
surf(Xe3,T3,Ve3-Vke3);
colormap;
xlabel('Edge e_3 [cm]','fontsize',10);
ylabel('Time [ms]','fontsize',10); 
zlabel('V-V^{k_*\delta} [mV]','fontsize',10);
title('Subplot B: Edge e_3');
shading flat 
saveas(gcf,'Ex4-7.eps', 'psc2')



%%%----------------  Figure of Error vs k =Iterations number  ----------------------%
figure; 
subplot(221);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Error,'LineWidth',2,'MarkerSize',12); 
xlabel('Iterations number','fontsize',10);
ylabel('Mean absolute percentage error','fontsize',10);                     
title('Subplot A');  
                     
subplot(222);
set(gcf,'position',[500 528 1028 1000]); 
set(gca,'fontsize',15)
plot(k,Residuo,'LineWidth',2,'MarkerSize',12);
xlabel('Iterations number','fontsize',10);
ylabel('Residual','fontsize',10);  
title('Subplot B'); 
saveas(gcf,'Ex4-8.eps', 'psc2')
