# Point-Cloud-Renconstruction-and-Camera-Calibration
Implementation of using structured light for 3D depth reconstruction, based on the techniques discussed in:  
*High-Accuracy Stereo Depth Maps Using Structured Light  
*Projector calibration for 3D scanning using virtual target images 

The project folder can be divided into two parts: calibration and reconstruction.

Each folder contains necessary functions in order to meet project's specification.



# reconstruction

NOTE: Before doing reconstruction, please make sure you can camera and projector's extrinsic ans intrinsic matrices.

Running reconstruction is simple, just calling function reconstruction(path,prefix,first,digits,suffix,outputName,use_calibration).

If I'm calling reconstruction('head_own','_H8A0',065,3,'JPG','head_own',0);

The program will do reconstruction from images in 'head_own' folder. And output a .ply file with name 'head_own'.

Details of first five parameters can be found in load_sequence_color.m

The last parameter must be in the form of 0 and 1.

If input is 1 then the program will use your calibrated matrices.

All image sets must be placed at the same directory as the function is located. 
For using calibrated matrices place four matrices in this directory as well but must be named as:
intrinsic_matrix_cam.mat
intrinsic_matrix_proj.mat
extrinsic_matrix_cam.mat
extrinsic_matrix_proj.mat



# Calibration

Performing calibration can be done by calling function calibration(isSynthetic,isReal,isOur).

Each of these paramenters are flags telling program what data sets to use.
All data sets must be placed at the same directory as the function is located. 

After running above function, make sure to use calib_gui from TOOLBOX_calib to finshi the calibration process.
This tool box is introduced by lab2/caltech.


# Output


For reconstruction, there are several subfolders named by the data set. Each subfolder I put the u v and depth outcome in it.

For calibration, the subfolders are named by the calibration data sets. Each subfolder contains homographed images and the computed extrinsic/ intrinsic matrices for camera and projector.

# Please refer to file report.pdf for further project details 
![result](https://github.com/pleaseRedo/Point-Cloud-Renconstruction-and-Camera-Calibration/blob/master/112617351124_0report_8.jpg)
