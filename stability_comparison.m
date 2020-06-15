clear; clc;

d = 2; 

fun = @(x) 0.5*d-0.5*sum(cos(5*pi*x),2)+sum(x.^2,2);

K  = 150; lambda = 1/sqrt(d);

% fixed initial iterates
x1  = [1 -1];

% three randomly selected initial iterates
% x1  = 2*rand(1,d)-1;
% x1  = sqrt(d)*x1./sqrt(sum(x1.^2,2));

rho = 0.90; n = 5; alpha = 0.45; 
alpha2 = 0.35; alpha3 = 0.25; alpha4 = 0.15; 

XTrace1a = dfd(fun,x1,K,alpha,lambda,rho,n);
XTrace1b = dfd(fun,x1,K,alpha2,lambda,rho,n);

XTrace2a = dfd_unstable(fun,x1,K,alpha,lambda,rho,n);
XTrace2b = dfd_unstable(fun,x1,K,alpha2,lambda,rho,n);
XTrace2c = dfd_unstable(fun,x1,K,alpha3,lambda,rho,n);
XTrace2d = dfd_unstable(fun,x1,K,alpha4,lambda,rho,n);

figure(1)
set(gcf,'Position',[10/0.277 45/0.277 80/0.277 60/0.277]); % 8X6cm
% set(gca,'Position',[.16 .18 .78 .72]); % 8X6cm
figure_FontSize=10;
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

x = linspace(-1.5,1.5);
y = linspace(-1.5,1.5);
[X,Y] = meshgrid(x,y);
Z=0.5*d-0.5*(cos(5*pi*X)+cos(5*pi*Y))+X.^2+Y.^2;
mesh(X,Y,Z);

xticks([-1.5 0 1.5])
xticklabels({'-1.5','0','1.5'})
yticks([-1.5 0 1.5])
yticklabels({'-1.5','0','1.5'})

figure(2)
set(gcf,'Position',[100/0.277 45/0.277 80/0.277 60/0.277]); % 8X6cm
set(gca,'Position',[.16 .18 .78 .72]); % 8X6cm
figure_FontSize=10;
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);


plot(log10(sum(XTrace2a.^2,2)),'k:')
hold on
plot(log10(sum(XTrace2b.^2,2)),'b--')
plot(log10(sum(XTrace2c.^2,2)),'g-.')
plot(log10(sum(XTrace2d.^2,2)),'m-')
hold off
ylim([-15 5])
title('the iteration $$x_{k+1}=x_k-\alpha g_k$$','Interpreter','latex')
L1 = sprintf('\x03B1=%03.2f',alpha);
L2 = sprintf('\x03B1=%03.2f',alpha2);
L3 = sprintf('\x03B1=%03.2f',alpha3);
L4 = sprintf('\x03B1=%03.2f',alpha4);
lgnd=legend(L1,L2,L3,L4,'NumColumns',2);
po=get(lgnd,'Position');
set(lgnd,'Position',[po(1)+0.02, po(2)+0.02, po(3), po(4)]);
xlabel('number of iterations (k)')
ylabel('$$\log_{10}\|x_k-x_*\|_2^2$$','Interpreter','latex');

figure(3)
set(gcf,'Position',[190/0.277 45/0.277 80/0.277 60/0.277]); % 8X6cm
set(gca,'Position',[.16 .18 .78 .72]); % 8X6cm
figure_FontSize=10;
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

plot(log10(sum(XTrace1a.^2,2)),'k-')
hold on
plot(log10(sum(XTrace1b.^2,2)),'b--')
hold off
ylim([-15 5])
title('the iteration $$x_{k+1}=x_k-\alpha\hat{g}_k$$','Interpreter','latex')
L1 = sprintf('\x03B1=%03.2f',alpha);
L2 = sprintf('\x03B1=%03.2f',alpha2);
lgnd=legend(L1,L2);
po=get(lgnd,'Position');
set(lgnd,'Position',[po(1)+0.02, po(2)+0.02, po(3), po(4)]);
xlabel('number of iterations (k)')
ylabel('$$\log_{10}\|x_k-x_*\|_2^2$$','Interpreter','latex');



