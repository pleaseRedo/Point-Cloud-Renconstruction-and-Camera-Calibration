function [decode] = find_uv(seq)
%Decoding image to get [u v]
% 
%seq = seq_u(512:1024,768:1536,:);
[height, width, num_frame] = size(seq);
decode = zeros(height,width,2);
decode2 = zeros(height,width,2);

temp = zeros(height*width,10);
count = 0;
temp2 = zeros(width,10);
%count2 =0;
for i = 1:height
    %temp2 = zeros(width,10);
count2 = 0;
    for j = 1:width
        count = count+1;
%count2 = count2+1;
        binary_pair = zeros(1,10); % we have ten pairs in total. 
        bp_count =1;
        pat_diff_sum = 0;
        
        for f = [1,3,5,7,9,11,13,15,17,19]
            
            pattern_1 = seq(i,j,f);
            pattern_2 = seq(i,j,f+1);
            
            pat_diff = pattern_1 - pattern_2;
            pat_diff_sum = pat_diff_sum + abs(pat_diff);
        
            % White stands for 1 and black for 0;
            if pat_diff > 0 % Check if white pattern comes first 
                % This condition will eliminate backgrounds from encoding
                % part.
                binary_pair(bp_count) = 1;
            else
                binary_pair(bp_count) = 0;
            end

            bp_count = bp_count + 1;          
        end
        temp(count,:) = binary_pair;
        %temp2(count2,:) = binary_pair;
        %decode(i,j,1) = bi2de(binary_pair);
        decode(i,j,2) = pat_diff_sum; % This is later used for background removal(unreliable noise).
    end  
    %decode(i,:,2) = transpose(bi2de(temp2));
end
 deci = bi2de(temp);
% 
 fliped = reshape(deci',[width,height]);
 %decode(:,:,1)=(fliped'); % Code keeped for denoise illustration
 %comparison
 % Median filter remove background noise even further.
 decode(:,:,1)=medfilt2(fliped',[5,5]);
end

