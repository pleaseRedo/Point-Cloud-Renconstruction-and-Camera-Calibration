 function [out_cam,out_proj] = tilt_back(for_proj,for_cam,board_x,board_y,board_size,outputSize_x,ouputSize_y)
%TILT_BACK will compute the homography then applying to the uncalibrated
%images.

% for_proj : projection image
% for_cam  : printed image
% board_x,y,size : controls the origin of checkerboard and its size per
% square
%outputSize_x,y : specify the output resolution
figure, imshow(for_proj), title('Please locate 4 corners, hit ENTER to confirm choice, DEL to redraw');
[pts_x, pts_y] = getline(gcf);
close all;

set_pt1 = [pts_x';pts_y'];
% board_x = 378;
% board_y = 277;
% board_size = 270;
%Clockwise direction
set_pt2 = [board_x,board_x+board_size,board_x+board_size,board_x;board_y,board_y,board_y+board_size,board_y+board_size]; 
H = get_bestHomography(set_pt1,set_pt2);
T = projective2d(H);

out_proj = imwarp(for_proj,T, 'OutputView', imref2d([ouputSize_y,outputSize_x]));
out_cam = imwarp(for_cam, T, 'OutputView', imref2d([ouputSize_y,outputSize_x]));

%imshow(out_proj);
figure, subplot(2,2,1),imshow(for_proj),title({'Original projected image', 'P^c_{projected}'});
hold on;
%plot(set_pt2(1,:), set_pt2(2,:), 'b--o');
plot(set_pt1(1,:), set_pt1(2,:), 'c*');
hold off;
subplot(2,2,2), imshow(out_proj),title({'Homographed projector image', 'P^p_{projected}'});
hold on;
plot(set_pt2(1,:), set_pt2(2,:), 'b--o');
%plot(set_pt1(1,:), set_pt1(2,:), 'c*');
hold off;
subplot(2,2,3), imshow(for_cam), title({'Original calibration checkerboard', 'P^c_{printed}'});
subplot(2,2,4), imshow(out_cam), title({'Reprojected calibration checkerboard', 'P^p_{printed}'});
end

