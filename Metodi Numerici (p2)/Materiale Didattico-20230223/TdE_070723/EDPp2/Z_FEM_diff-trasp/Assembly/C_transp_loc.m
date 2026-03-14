function [T_loc]=C_transp_loc(dphiq,Grad, w_2D,nln,BJ,beta)

T1_loc=zeros(nln,nln);
T2_loc=zeros(nln,nln);
T_loc=zeros(nln,nln);

for i=1:nln
    for j=1:nln
        for k=1:length(w_2D)
            Binv = inv(BJ(:,:,k));      
            Jdet = det(BJ(:,:,k));    
            grad = Grad(k,:,j) * Binv;
            T1_loc(i,j) = T1_loc(i,j) + (Jdet.*w_2D(k)) .* dphiq(1,k,i) .* grad(1);
            T2_loc(i,j) = T2_loc(i,j) + (Jdet.*w_2D(k)) .* dphiq(1,k,i) .* grad(2);
        end
    end
end
T_loc = beta(1)*T1_loc + beta(2)*T2_loc;



                                              
                                           