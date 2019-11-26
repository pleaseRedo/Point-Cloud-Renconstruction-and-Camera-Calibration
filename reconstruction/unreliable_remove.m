function [uv] = unreliable_remove(u,v,threshold)
% remove the unreliable pixels, usually the background.
%threshold = 32 paper suggested.
[height,width,~] = size(u);


% Create a mask based on the threshold.
mask_cube = zeros(size(u));
uv = zeros(size(u));
filtered = u(:,:,2) + v(:,:,2);
filtered =filtered>threshold;
mask_cube(:,:,1) = filtered;
mask_cube(:,:,2) = filtered;
uv(:,:,1) = u(:,:,1) ;
uv(:,:,2) =  v (:,:,1);

% Masking the unreliable pixels.
uv = uv .* mask_cube; 

% u = uv(:,:,1);
% v = uv(:,:,2);

end

