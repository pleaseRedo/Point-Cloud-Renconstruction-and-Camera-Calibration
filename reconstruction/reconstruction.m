function [depth,ptCloud] = reconstruction(path,prefix,first,digits,suffix,outputName,use_calibration)
%   This is main function for 3d point cloud reconstruction
%Useage
% [depth,ptCloud] = reconstruction('Monkey_T1','00',0,40,2,'png','cube_cali',1);
% Tells programe running Monkey_T1 file sets start with '0000.png' files.Then
% save point cloud at directory with name 'cube_cali.ply'
% using calibrated matrices.
% Data sets need to be put at '\reconstruction\'
last = first + 19;


seq_u_color = load_sequence_color(path,prefix, first, last, digits, suffix);
seq_v_color = load_sequence_color(path,prefix, first+20, last+20, digits, suffix);




[uv] = light_decode(seq_u_color,seq_v_color);
[depth_map,threeD_cloud] = determine_depth(uv,use_calibration);

ptCloud = pointCloud(threeD_cloud);
pcwrite(ptCloud,outputName);

masked = depth_map == -1;
depth_map = masked.*(max(depth_map(:)))+(1-masked).*depth_map;

depth = depth_map(:,:,3);
figure;
imagesc(depth),title('depth map');
fprintf('done\n');




end

