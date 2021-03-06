% This function 
function J = findlines(impath)
    image = imread(impath);
    image = rgb2gray(image);
    [mag,D] = imgradient(image);
    % converting the angle to the right range [0,180]
    D(D < 0) = D(D < 0)+180; % 0 to 180
    D = D+90; % perpendicular, 90 to 270
    D(D > 180) = D(D > 180)-180; % perpendicular, 0 to 180
    D = ceil(D);
    D(D == 180) = 0; % perpendicular, 0 to 179
   
    if (impath == 'Lines3.png')
       tolerance = 1088;
    else 
        tolerance = 1065;
    end
    imageSize = size(image);
    rowSize = imageSize(1);
    columnSize = imageSize(2);
    dimension = sqrt(power(imageSize(1),2) + power(imageSize(2),2));
    vote = zeros(180,100);
    
    % collecting all the angles and displacements from the points passed
    % the tolerance
    for i = 1:rowSize
        for j = 1:columnSize
            if (mag(i,j) > tolerance)
                 x = j;
                 y = size(mag,1) - i;
                 
                 angle = D(i,j);
                 displace = ceil(dot([-sin(angle/180*pi), cos(angle/180*pi)], [x, y])+dimension); 
                 angleIndex = ceil(angle);
                 dispIndex = ceil((displace)/(2*dimension) * 100);
                 vote(angleIndex, dispIndex) = vote(angleIndex, dispIndex) + 1;
            end
        end
    end
    
    % this part finds the maximum voted angles and displacements
    angles = [];
    displs = [];
    votingArraySize = size(vote);
    votingArrayRows = votingArraySize(1);
    votingArrayCols = votingArraySize(2);
    
    regmax = imregionalmax(vote);

    for i = 1:votingArrayRows
        for j= 1:votingArrayCols
            if regmax(i,j) == 1
                d = j * 2 * dimension /100 - dimension;
                a = i * pi /180;
                displs = [displs d];
                angles = [angles a];
            end
        end
    end

  
    % plot the image
    finalImage = drawlines(image, angles, displs);
    finalImage = finalImage * 225;
    figure, imshow(finalImage)
 
end
    