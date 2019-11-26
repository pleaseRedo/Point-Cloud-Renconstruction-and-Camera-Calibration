function [uv] = light_decode(seq_u_color,seq_v_color)
% This function does the light decode job, but mainly it just puts find_uv,
% and unreliable_remove function together. The actual implementation is
% written in thouse individual files.
% path = 'cube_T1';
% prefix = '0';
% first = 0;
% last = 19;
% digits = 3;
% suffix = 'png';
% 
% 
[width,height,~,num_frame] = size(seq_u_color);
% 
seq_u = zeros(width,height,num_frame);
seq_v = zeros(width,height,num_frame);

for i = 1:num_frame
   seq_u(:,:,i) = rgb2gray(seq_u_color(:,:,:,i));
   seq_v(:,:,i) = rgb2gray(seq_v_color(:,:,:,i));   
end

% UV decoding
tic;
u = find_uv(seq_u);

v = find_uv(seq_v);
toc
% Unreliable removeal
uv = unreliable_remove(u,v,6);
u = uv(:,:,1);

v = uv(:,:,2);
figure;
subplot(1,2,1),imagesc(u),title('u');
subplot(1,2,2),imagesc(v),title('v');
end

