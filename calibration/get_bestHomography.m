function [H] = get_bestHomography(set_pt1,set_pt2)
%   This will compute the homography matrix based on input two point sets
%   

    num_points  = size(set_pt1,2);
    pts1Hom = vertcat(set_pt1,ones(1,num_points));
    pts2Hom = vertcat(set_pt2,ones(1,num_points));

    
    A = zeros(2*num_points,9);
    odd_num = 1;
    for i = 1:num_points%[1,3,5,7,9,11,13,15,17]
   % Building matrix A from Machine vision lecture slides 14     
        u = pts1Hom(1,i);
        v = pts1Hom(2,i);
        x = pts2Hom(1,i);
        y = pts2Hom(2,i);
        A(odd_num,:) = [0,0,0,-u,-v,-1,y*u,y*v,y];
        A(odd_num+1,:) = [u,v,1,0,0,0,-x*u,-x*v,-x];
        odd_num = odd_num+2;
    end
    h = AhisZero_solve(A);
    
    H = reshape(h,3,3);
   
end

