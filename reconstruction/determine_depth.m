 function [depth_map,threeD_cloud] = determine_depth(uv,use_calibration)
% %This function will estimate the depth of input uv.
% USAGE: determine_depth(uv,1) if using calibration matrices
% uv: decoded uv code. HeightxWidthx2 size
% use_calibration : flag, showing whether to use external calibration
% matrices
[height,width,dim] = size(uv);
if use_calibration == 0
    synthetic_matrices;

elseif use_calibration == 1
    % PLEASE make sure you have loaded the projection matrices. They are placed in
    % the output folder.
    % Drag them to the reconstruction folder. Make sure the following files
    % exists.
    load extrinsic_matrix_cam.mat;
    load extrinsic_matrix_proj.mat;
    load intrinsic_matrix_cam.mat;
    load intrinsic_matrix_proj.mat;
    
    extrinsic_cam = extrinsic_matrix_cam;
    extrinsic_proj = extrinsic_matrix_proj;
    intrinsic_cam  = intrinsic_matrix_cam;
    intrinsic_proj = intrinsic_matrix_proj;
end


%Top left 3x3 of extrin_m is rotation matrix
rotate_cam = extrinsic_cam(1:3,1:3);
rotate_proj = extrinsic_proj(1:3,1:3);
% Last coloumn of extrin_m is translate matrix
translate_cam = extrinsic_cam(1:3,4);
translate_proj = extrinsic_proj(1:3,4);



threeD_cloud = zeros(height*width,3);
depth_map = zeros(height,width,3);

count = 1;
for i = 1:height
    for j = 1:width
        %if uv(i,j,1)>0 &&uv(i,j,2)>0 
         if sum(uv(i,j,:))>2   
            point_current_cam = [j;i;1]; % Matlab indexing[x,y] is transposed. Compare to camera equation's point[x,y]
            point_current_proj = [uv(i,j,2);uv(i,j,1);1];
            %pixel to camera coordinate 
            coord_cam = intrinsic_cam\point_current_cam;
            coord_proj = intrinsic_proj\point_current_proj;
            
            %Following to Machine Vision Lecture 14, we need to form a
            %system of equations, in order to get coordinate [u v w]:
            A = zeros(4,3);
            b = zeros(4,1);
            row_1a = [rotate_cam(3,1)*coord_cam(1)-rotate_cam(1,1), rotate_cam(3,2)*coord_cam(1)-rotate_cam(1,2), rotate_cam(3,3)*coord_cam(1)-rotate_cam(1,3)];
            A(1,:) = row_1a;
            row_2a = [rotate_cam(3,1)*coord_cam(2)-rotate_cam(2,1), rotate_cam(3,2)*coord_cam(2)-rotate_cam(2,2), rotate_cam(3,3)*coord_cam(2)-rotate_cam(2,3)];
            A(2,:) = row_2a;
            row_3a = [rotate_proj(3,1)*coord_proj(1)-rotate_proj(1,1), rotate_proj(3,2)*coord_proj(1)-rotate_proj(1,2), rotate_proj(3,3)*coord_proj(1)-rotate_proj(1,3)];
            A(3,:) = row_3a;
            row_4a = [rotate_proj(3,1)*coord_proj(2)-rotate_proj(2,1), rotate_proj(3,2)*coord_proj(2)-rotate_proj(2,2), rotate_proj(3,3)*coord_proj(2)-rotate_proj(2,3)];
            A(4,:) = row_4a;
   
            b(1:2) = [translate_cam(1)-translate_cam(3)*coord_cam(1), translate_cam(2)-translate_cam(3)*coord_cam(2)];
            b(3:4) = [translate_proj(1)-translate_proj(3)*coord_proj(1), translate_proj(2)-translate_proj(3)*coord_proj(2)];
            % Solve system
            x = A\b;
            threeD_cloud(count,:) = x;
            count = count + 1;
            % Find lambda
            depth_map(i,j,:) = extrinsic_cam * [x;1];
            
            
        else
            depth_map(i,j,:) = -1;
        end
        
        
    end
    
    
end


end

