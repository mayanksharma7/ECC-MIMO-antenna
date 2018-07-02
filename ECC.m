%format longE
format long
Em_th1 = csvread('mag_rETheta_1.csv',1,0);
Em_th2 = csvread('mag_rETheta_2.csv',1,0);
Ep_th1 = csvread('ang_rad_rETheta_1.csv',1,0);
Ep_th2 = csvread('ang_rad_rETheta_2.csv',1,0);

E_th1 = Em_th1(:,3).*exp(1i*Ep_th1(:,3));
E_th2 = Em_th2(:,3).*exp(1i*Ep_th2(:,3));
%conj

Em_Phi1 = csvread('mag_rEPhi_1.csv',1,0);
Em_Phi2 = csvread('mag_rEPhi_2.csv',1,0);
Ep_Phi1 = csvread('ang_rad_rEPhi_1.csv',1,0);
Ep_Phi2 = csvread('ang_rad_rEPhi_2.csv',1,0);

E_Phi1 = Em_Phi1(:,3).*exp(1i*Ep_Phi1(:,3));
E_Phi2 = Em_Phi2(:,3).*exp(1i*Ep_Phi2(:,3));

theta = 0:pi/180:pi;
phi = 0:pi/180:2*pi;

num_hat = (E_th1.*conj(E_th2)) + (E_Phi1.*conj(E_Phi2));
num = num_hat.*sin((Em_th1(:,2)).*(pi/180));
%num = num_hat;
%csvwrite('data_1.csv',num)

num_reshape = reshape(num,361,181);

%Q1 = trapz(X,Y,2)
%Iy=trapz(theta,num_reshape);
I_num_phi=trapz(phi,num_reshape);
I_num = trapz(theta,I_num_phi)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%G_th1 = csvread('G_Theta_1.csv',1,2);
%G_th2 = csvread('G_Theta_2.csv',1,2);
G_th1 = abs(E_th1).^2;
G_th2 = abs(E_th2).^2;

%G_Phi1 = csvread('G_Phi_1.csv',1,2);
%G_Phi2 = csvread('G_Phi_2.csv',1,2);
G_Phi1 = abs(E_Phi1).^2;
G_Phi2 = abs(E_Phi2).^2;

den1_hat = G_th1 + G_Phi1;
den2_hat = G_th2 + G_Phi2;

den1 = den1_hat.*sin((Em_th1(:,2)).*(pi/180));
den2 = den2_hat.*sin((Em_th1(:,2)).*(pi/180));

den1_reshape = reshape(den1,361,181);
I_den1_phi=trapz(phi,den1_reshape);
I_den1=trapz(theta,I_den1_phi);

den2_reshape = reshape(den2,361,181);
I_den2_phi=trapz(phi,den2_reshape);
I_den2=trapz(theta,I_den2_phi);

I_den = sqrt(I_den1)*sqrt(I_den2)

%K = 10^-6;
ECC = abs(I_num)/I_den


%I = trapz(y,trapz(x,F,2))