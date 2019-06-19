function D_matrix = getDmtx(Rok2, bk, v)
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
end