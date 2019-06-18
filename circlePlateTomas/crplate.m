clc; clear;
% initial data
q_LOAD =20; % KN/m
f=20; % KN
L=16; % span length m
h=0.05; % thickness of plate 
E=210e6; % modulus of elastisty kPa
v=.3; % poisson's ratio
%
r=L/2; % radious of plate 
B=[1.5 1.5 3 2]; % [m]
no_FE=length(B); % Number of plate finite elements
b=B/2; % half of FE
coords = zeros(no_FE,3);
coords(1,1)=0; 
coords(1,2)=B(1)/2; 
coords(1,3)=B(1);
for i=2:no_FE
    coords(i,1)=coords(i - 1,3);
    coords(i,2)=coords(i - 1,3) + B(i)/2;
    coords(i,3)= coords(i - 1,3) + B(i);
end
coords
no_of_local_dis=6; % Number of local displacements 
no_of_global_dis=16; % Number of global displacements 

% % 2. compatipality matrix C
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
C=[c_1stcompatipality_matrix;c_2ndcompatipality_matrix;c_3rdcompatipality_matrix;c_4thcompatipality_matrix]


% % 4. MATRIX OF EQUILIBRIUM EQUATIONS A 

for k=1:no_FE
Rok1=coords(k,1);
Rok2=coords(k,2);
Rok3=coords(k,3);
bk=b(k);
A_matrix(1,1)=Rok1;
A_matrix(2,1)=1.5*Rok1/bk-1;
A_matrix(2,2)=1;
A_matrix(2,3)=-2*Rok1/bk;
A_matrix(2,5)=Rok2/2*bk;
A_matrix(3,1)=-Rok2/bk+2;
A_matrix(3,2)=-5/6;
A_matrix(3,3)=2*Rok2/bk-2;
A_matrix(3,4)=2/3;
A_matrix(3,5)=-Rok2/bk;
A_matrix(3,6)=1/6;
A_matrix(4,1)=-Rok2/bk;
A_matrix(4,2)=-1/6;
A_matrix(4,3)=2*Rok2/bk+2;
A_matrix(4,4)=-2/3;
A_matrix(4,5)=-Rok2/bk-2;
A_matrix(4,6)=5/6;
A_matrix(5,5)=-Rok3;
A_matrix(6,1)=Rok3/2*bk;
A_matrix(6,3)=-2*Rok3/bk;
A_matrix(6,5)=1+1.5*Rok3/bk;
A_matrix(6,6)=-1;
A_(k*6-5:k*6,k*6-5:k*6)=2*pi*A_matrix;
end
A=C'*A_


% % 5. Flexibility MATRIX OF D
for k=1:no_FE
Rok2=coords(k,2);
bk=b(k);
j1=Rok2-bk;
j2=4*Rok2-3*bk;
j3=Rok2+bk;
j4=4*Rok2+3*bk;
D_matrix(1,1)=j2;
D_matrix(1,2)=-v*j2;
D_matrix(1,3)=2*j1;
D_matrix(1,4)=-2*v*j1;
D_matrix(1,5)=-Rok2;
D_matrix(1,6)=v*Rok2;
D_matrix(2,1)=D_matrix(1,2);
D_matrix(2,2)=j2;
D_matrix(2,3)=-2*v*j1;
D_matrix(2,4)=2*j1;
D_matrix(2,5)=v*Rok2;
D_matrix(2,6)=-Rok2; 
D_matrix(3,1)=D_matrix(1,3);
D_matrix(3,2)=D_matrix(2,3);
D_matrix(3,3)=16*Rok2;
D_matrix(3,4)=-16*v*Rok2;
D_matrix(3,5)=2*j3;
D_matrix(3,6)=-2*v*j3;
D_matrix(4,1)=D_matrix(1,4);
D_matrix(4,2)=D_matrix(2,4);
D_matrix(4,3)=D_matrix(3,4);
D_matrix(4,4)=16*Rok2;
D_matrix(4,5)=-2*v*j3;
D_matrix(4,6)=2*j3;
D_matrix(5,1)=D_matrix(1,5);
D_matrix(5,2)=D_matrix(2,5);
D_matrix(5,3)=D_matrix(3,5);
D_matrix(5,4)=D_matrix(4,5);
D_matrix(5,5)=j4;
D_matrix(5,6)=-v*j4;
D_matrix(6,1)=D_matrix(1,6);
D_matrix(6,2)=D_matrix(2,6);
D_matrix(6,3)=D_matrix(3,6);
D_matrix(6,4)=D_matrix(4,6);
D_matrix(6,5)=D_matrix(5,6);
D_matrix(6,6)=j4;
K.k=E*h^3/(12*(1-v^2));
D_(k*6-5:k*6,k*6-5:k*6)=(2*pi*bk/(15*K.k*(1-v^2)))*D_matrix
end


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

F=Fo+C'*Fp_
Uglob=inv(A*inv(D_)*A')*F
Ulocal=inv(D_)*A'*Uglob


M_Ro=Ulocal(1:2:end);
M_fi=Ulocal(2:2:end);
um_mm=1000*[Uglob(2:4:end);0]

u_allowable=16/250*1000





