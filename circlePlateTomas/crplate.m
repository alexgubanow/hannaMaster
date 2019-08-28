close all; clc; clear;
format compact;
addpath('../matlab2tikz/');
% initial data
q_LOAD =20; % KN/m
f=20; % KN
L=16; % span length m
h=0.05; % thickness of plate 
E=210e6; % modulus of elastisty kPa
v=.3; % poisson's ratio
%
r=L/2; % radius of plate
B=[1.5 1.5 3 2];%vector of elements lengths, meters
no_FE=length(B); % Number of plate finite elements, as length of vector with elements lengths
b=B/2; % half of elements lengths
coords = zeros(no_FE,3);%filling matrix (number of elements by 3) by zeros
coords(1,2)=B(1)/2;% coordinate of half of first element
coords(1,3)=B(1);% coordinate of end of first element
for i=2:no_FE% loop over coordinates matrix, "i" is current element, "i-1" is previous element
    coords(i,1)=coords(i - 1,3);%start coordinate as end coordinate of previous element
    coords(i,2)=coords(i - 1,3) + B(i)/2;%half coordinate as end coordinate of previous element plus half length of current element
    coords(i,3)= coords(i - 1,3) + B(i);%end coordinate as end coordinate of previous element plus length of current element
end
saveAsFileDairy('coords', coords);
no_of_local_dis=6; % Number of local displacements 
no_of_global_dis=16; % Number of global displacements 
% 2. Compatipality matrix C
% for the first FE
c_1stcompatipality_matrix=zeros(no_of_local_dis,no_of_global_dis);
c_1stcompatipality_matrix(2:6,1:5)=eye(5);
% for the Second FE
c_2ndcompatipality_matrix=zeros(no_of_local_dis,no_of_global_dis);
c_2ndcompatipality_matrix(1:6,4:9)=eye(6);
% for the third FE
c_3rdcompatipality_matrix=zeros(no_of_local_dis,no_of_global_dis);
c_3rdcompatipality_matrix(1:6,8:13)=eye(6);
% for the 4th FE
c_4thcompatipality_matrix=zeros(no_of_local_dis,no_of_global_dis);
c_4thcompatipality_matrix(1:5,12:16)=eye(5);
% the total compatipality matrix of displacements
C=[c_1stcompatipality_matrix;c_2ndcompatipality_matrix;c_3rdcompatipality_matrix;c_4thcompatipality_matrix];
%saveAsFileDairy('C', C);
%4. Matrix of equilibrium equantions A
for k=1:no_FE
A_matrix = getAmtx(coords(k,1), coords(k,2), coords(k,3), b(k));
A_(k*6-5:k*6,k*6-5:k*6)=2*pi*A_matrix;
end
A=C'*A_;
saveAsFileDairy('A', A);
% % 5. Flexibility MATRIX OF D
for k=1:no_FE
Rok2=coords(k,2);
bk=b(k);
D_matrix = getDmtx(coords(k,2), b(k), v);
K.k=E*h^3/(12*(1-v^2));
D_(k*6-5:k*6,k*6-5:k*6)=(2*pi*bk/(15*K.k*(1-v^2)))*D_matrix;
end
saveAsFileDairy('D', D_);
% % 6. EXTERNAL LOAD VICTOR F
Fo=zeros(no_of_global_dis,1);
Rof=6;
 Fo(13)=f*2*pi*Rof;
 % Rof coordinate where f
 % Fkp is nodal external load vector which is equivilant to distributed load of the kth element 
 q_Load_vector=[20 20 0 0];
 for k=1:no_FE
     bk=b(k);
     q=q_Load_vector(k); 
     Rok2=coords(k,2);
     Fk=(2*pi*bk/3)*q*[3*Rok2-bk;3*Rok2+bk];
     Fp=[0;0;Fk;0;0];
     Fp_(6*k-5:k*6,1)=Fp;
 end
F=Fo+C'*Fp_;
saveAsFileDairy('F', F);

Uglob=inv(A*inv(D_)*A')*F;
saveAsFileDairy('Uglob', Uglob);

S=inv(D_)*A'*Uglob;
saveAsFileDairy('S', S);

M_Ro=S(1:2:end);
saveAsFileDairy('M_Ro', M_Ro);

M_fi=S(2:2:end);
saveAsFileDairy('M_fi', M_fi);

um_mm = 1000*[Uglob(1:4:end);0];
saveAsFileDairy('um_mm', um_mm);
% xcoord = [0;coords(1:end,3)];
% figure(1);
% plot(xcoord,um_mm,'DisplayName','Uglob');
% xlabel('Coordinates of elements, m') 
% ylabel('Displacement, m') 
% set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
% matlab2tikz('um_mm.tex','showInfo', false);
u_allowable=16/250*1000;
saveAsFile('u_allowable', u_allowable);
fullCoord = [-8; -6; -4.5; -2.25; 0; 2.25; 4.5; 6; 8];
plotU(fullCoord, um_mm, 1, true);
plotMfi(fullCoord, M_fi,3, true);
plotMro(fullCoord, M_Ro, 2, true);













