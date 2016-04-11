function J = findlines(impath)
    %angleArray = [0, np.pi/6, (2*np.pi)/6, (3*np.pi)/6, (4*np.pi)/6,(5*np.pi)/6];
    image = imread(impath);
    image = rgb2gray(image);
    %[Gx, Gy] = imgradientxy(image);
   
    [mag,D] = imgradient(image);
%     D(D < 0) = D(D < 0)+180; % 0 to 180
%     D = D+90; % perpendicular, 90 to 270
%     D(D > 180) = D(D > 180)-180; % perpendicular, 0 to 180
%     D = ceil(D);
%     D(D == 180) = 0; % perpendicular, 0 to 179
%     
    bestPointsX = [];
    bestPointsY = [];
  
    %tolerance = 1091;
    tolerance = 1088;
    
    %disp(size(image));
    imageSize = size(image);
    columnSize = imageSize(2);
    rowSize = imageSize(1);
    %disp(image)
    
    disp('ROWSIZE');
    disp (imageSize(1));
    disp('COLSIZE')
    disp(imageSize(2));
    
    
    for a = 1:rowSize
        for b = 1:columnSize
            if (mag(a,b) > tolerance)
                %disp(mag(a,b));
                 bestPointsX = [bestPointsX, a];
                 bestPointsY = [bestPointsY, b];
                 %bestPointsX = [bestPointsX, b];
                 %bestPointsY = [bestPointsY, rowSize-a];
            end
        end
    end
    
    scatter(bestPointsX, bestPointsY);
   
    
    
    dispMin = -(sqrt(power(imageSize(1),2) + power(imageSize(2),2)));
    dispMax = (sqrt(power(imageSize(1),2) + power(imageSize(2),2)));
   
    %angleArray = [0:pi/99:pi]';
    %angleArray = 0:pi/99:pi;
    angleArray = [0,180];
    
   
    votingArray = zeros(abs(dispMin)+ abs(dispMax), length(angleArray));
   

    for i=1:length(bestPointsX)
          x = bestPointsY(i);
          y = size(mag,1)-bestPointsX(i);
          
          angle = D(bestPointsX(i),bestPointsY(i)) ; % angle of line 
          displacement = round(dot([-sin(angle/180*pi), cos(angle/180*pi)], [x, y])) + dispMax; % displacement of line
          
          disp(displacement);
          displacementIndex = abs(round((displacement - dispMin)/(dispMax-dispMin))*99)+1;
          [votingArray, angleArray] = vote(bestPointsX(i),bestPointsY(i), mag, angle, displacementIndex, votingArray, angleArray);
    end
           
%     for i=1:length(bestPointsX)
% 		for j=i+1:length(bestPointsX)
%             %xi = bestPointsY(i);
%             %yi = rowSize - bestPointsX(i);
%             xi = bestPointsX(i);
%             yi = bestPointsY(i);
%             
%             %xj = bestPointsY(j);
%             %yj = rowSize - bestPointsX(j);
%              xj = bestPointsX(j);
%              yj = bestPointsY(j);
%             
%             x = yi; % from left
%             y = size(M,1)-xi; % from bottom
%             angle = D(xi,yi); % angle of line 
%             displacement = round(dot([-sin(a/180*pi), cos(a/180*pi)], [x, y])); % displacement of line
% 
%             %angle = 0;
%             %if (xj - xi) ~= 0
%             %    angle = (pi/2) + atan(yj - yi/(xj -xi));
%                 
%             %else
%             %    angle = pi/2;
%             %end
%             
%             
% 			%angleIndex = abs(angle*(6/pi));
%             %c = [0.5 * (xj+xi), 0.5 * (yj+yi)];
%             %c = abs(xi)*tan(pi-angle)+abs(yi);
%             %displacement = abs(c)*cos(pi-angle);
%             %displacement = (c(1)*cos(angle) + c(2)*sin(angle))+dispMax;
%             displacementIndex = abs(round((displacement - dispMin)/(dispMax-dispMin))*99)+1;
%          
%             %disp('DISPLACEMENT');
%             %disp(displacement);
%             
%             
%             
%             %negative diagonal is min
%             %positive diagonal is max
%             %disp('yes');
%             [votingArray, angleArray] = vote(angle, displacementIndex, votingArray, angleArray);
%         end
%     end
%     
    angles = [];
    displs = [];
    votingArraySize = size(votingArray);
    votingArrayRows = votingArraySize(1);
    votingArrayCols = votingArraySize(2);
    disp('LOOOOOL!!');
    disp(votingArrayRows);
    disp(votingArrayCols);
    
    regmax = imregionalmax(votingArray);
    
    
    for i = 1:votingArrayRows
        for j= 1:votingArrayCols
            if(votingArray(i,j)) > 1
                disp('here is the answer');
                disp(i);
                displs = [displs i];
                angles = [angles (angleArray(j))];
                disp(angleArray(j));
                disp(votingArray(i,j));
            end
        end
    end
    
    
    angles
    displs
    image = flipdim(image,2);
    finalImage = drawlines(zeros(800,600), angles, displs);
    finalImage = imrotate(finalImage,-90);
    figure, imshow(image)
    figure, imshow(finalImage)
 
    %disp(votingArray);
end
    