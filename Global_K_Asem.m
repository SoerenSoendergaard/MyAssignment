function K = Global_K_Asem(k,angles,scheme)

% Angles = [angle between el-1 and global, angle between el-2 and global..]

% Define space of assembled K matrix

K = zeros(6,6);


%% Build each global element stiffness
NrEls = length(k);
for i=1:NrEls
    c = cosd(angles(i));
    s = sind(angles(i));
    k_Global = Global_K_El(k(i),c,s);
    
    % Plug into assembly -- hard coded due to time constraints
    if scheme == "triangle";
        if i == 1
            K(3,3:end) = k_Global(1,:);
            K(4,3:end) = k_Global(2,:);
            K(5,3:end) = k_Global(3,:);
            K(6,3:end) = k_Global(4,:);
        end
        if i == 2
            K(1,1:2) = k_Global(1,1:2)+K(1,1:2);   K(1,5:6) = k_Global(1,3:4)+K(1,5:6);
            K(2,1:2) = k_Global(2,1:2)+K(2,1:2);   K(2,5:6) = k_Global(2,3:4)+K(2,5:6);
            K(5,1:2) = k_Global(3,1:2)+K(5,1:2);   K(5,5:6) = k_Global(3,3:4)+K(5,5:6);
            K(6,1:2) = k_Global(4,1:2)+K(6,1:2);   K(6,5:6) = k_Global(4,3:4)+K(6,5:6);
        end
        if i== 3
            K(3,1:4) = k_Global(3,:)+K(3,1:4);
            K(4,1:4) = k_Global(4,:)+K(4,1:4);
            K(1,1:4) = k_Global(1,:)+K(1,1:4);
            K(2,1:4) = k_Global(2,:)+K(2,1:4);  
        end
    end
end
