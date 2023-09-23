function k_Global = Global_K_El(k,c,s)

k_Global = zeros(4,4);
k_Global(1,:)= k*[c^2,c*s,-c^2,-c*s];
k_Global(2,:)= k*[c*s,s^2,-c*s,-s^2];
k_Global(3,:)= k*[-c^2,-c*s,c^2,c*s];
k_Global(4,:)= k*[-c*s,-s^2,c*s,s^2];

