clear; clc;

d = 10; 

fun = @(x) 0.5*d-0.5*sum(cos(5*pi*x),2)+sum(x.^2,2);

K  = 1000; lambda = 1/sqrt(d);

% three randomly selected initial iterates
x1three = 2*rand(3,d)-1;
x1three = sqrt(d)*x1three./sqrt(sum(x1three.^2,2));

n = 20; 
rho1 = 0.97; rho2 = 0.96; rho3 = 0.95;
alpha1 = 0.35; alpha2 = 0.4; alpha3 = 0.45;

XTrace1 = dfd(fun,x1three(1,:),K,alpha1,lambda,rho1,n);
XTrace2 = dfd(fun,x1three(2,:),K,alpha2,lambda,rho2,n);
XTrace3 = dfd(fun,x1three(3,:),K,alpha3,lambda,rho3,n);

figure(1)
figure_FontSize=10;
set(gcf,'Position',[100/0.277 45/0.277 80/0.277 60/0.277]); % 8X6cm
set(gca,'Position',[.16 .18 .78 .72]); % 8X6cm
set(get(gca,'XLabel'),'FontSize',figure_FontSize,'Vertical','top');
set(get(gca,'YLabel'),'FontSize',figure_FontSize,'Vertical','middle');
set(findobj('FontSize',10),'FontSize',figure_FontSize);
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);

plot(log10(sum(XTrace1.^2,2)),'k-')
hold on
plot(log10(sum(XTrace2.^2,2)),'b--')
plot(log10(sum(XTrace3.^2,2)),'m-.')
hold off
ylim([-25 5])

title(sprintf('d=%d, n=%d',d,n))
L1 = sprintf('\x03C1=%03.2f, \x03B1=%03.2f',rho1,alpha1);
L2 = sprintf('\x03C1=%03.2f, \x03B1=%03.2f',rho2,alpha2);
L3 = sprintf('\x03C1=%03.2f, \x03B1=%03.2f',rho3,alpha3);
lgnd=legend(L1,L2,L3);
po=get(lgnd,'Position');
set(lgnd,'Position',[po(1)+0.02, po(2)+0.02, po(3), po(4)]); %8X6cm
xlabel('number of iterations (k)')
ylabel('$$\log_{10}\|x_k-x_*\|_2^2$$','Interpreter','latex');
