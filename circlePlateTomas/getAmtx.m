function A_matrix = getAmtx(Rok1, Rok2, Rok3, bk)
    A_matrix = zeros(6,6);
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
end