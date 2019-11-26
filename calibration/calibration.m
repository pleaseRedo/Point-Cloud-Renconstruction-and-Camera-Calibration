function [out_cam,out_proj] = calibration(isSynthetic,isReal,isOur)
% This is a kit function that wraps up every function I wrote together
% It will output homographed images for camera and projector image.
%   all parameters are flags represent which data set to use.
if isSynthetic+isReal+isOur > 1 || isSynthetic+isReal+isOur == 0
    disp('Please enter valid choice e.g calibration(1,0,0) for calibration using synthetic ')
    out_cam = 0;
    out_proj = 0;
else
    if isSynthetic == 1
        % For synthetic calibration
        for name_idx=[0,2,4]
            for_cam = imread(['calibration/000',num2str(name_idx+1),'.png']);

            for_proj = imread(['calibration/000',num2str(name_idx),'.png']);
            board_x = 378;
            board_y = 277;
            board_size = 270;    
            [out_cam,out_proj] = tilt_back(for_proj,for_cam,board_x,board_y,board_size,1024,768);
            imwrite(out_cam,['output/output_synthetic_calibration/out_',num2str(name_idx),'.jpg']);  

        end
    elseif isReal==1
        % For real calibration
        for name_idx=1:9
            for_cam = imread(['real_calibration/IMG_932',num2str(name_idx),'.jpg']);

            for_proj = imread(['real_calibration/IMG_932',num2str(name_idx),'.jpg']);

            figure, imshow(for_proj), title('Please locate 4 corners');
            [pts_x, pts_y] = getline(gcf);
            set_pt1 = [pts_x';pts_y'];
            board_x = 518;
            board_y = 120;
            board_size = 299;
            [out_cam,out_proj] = tilt_back(for_proj,for_cam,board_x,board_y,board_size,1024,768);
            imwrite(out_cam,['output/output_real_calibration/out_',num2str(name_idx),'.jpg']);  

        end

        % For own image calibration
    elseif isOur==1
        for name_idx=1:12
            for_cam = imread(['our_calibration/',num2str(name_idx),'.jpg']);

            for_proj = imread(['our_calibration/',num2str(name_idx),'.jpg']);

            figure, imshow(for_proj), title('Please locate 4 corners');
            [pts_x, pts_y] = getline(gcf);
            set_pt1 = [pts_x';pts_y'];
            board_x = 2746;
            board_y = 1516;
            board_size = 216;
            [out_cam,out_proj] = tilt_back(for_proj,for_cam,board_x,board_y,board_size,1500,1000);
            imwrite(out_cam,['output/output_our_calibration/out_',num2str(name_idx),'.jpg']);  

        %     
        end

    end    

end




end

