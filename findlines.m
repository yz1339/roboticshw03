function J = findlines(impath)
    %angleArray = [0, np.pi/6, (2*np.pi)/6, (3*np.pi)/6, (4*np.pi)/6,(5*np.pi)/6];
    image = imread(impath);
    image = rgb2gray(image);
    %[Gx, Gy] = imgradientxy(image);
   
    [mag,~] = imgradient(image);
    bestPointsX = [];
    bestPointsY = [];
   
    tolerance = 1091;
    
    %disp(size(image));
    imageSize = size(image);
    columnSize = imageSize(2);
    rowSize = imageSize(1);
    %disp(image)
    
    for a = 1:rowSize
        for b = 1:columnSize
            if (mag(a,b) > tolerance)
                %disp(mag(a,b));
                bestPointsX = [bestPointsX, a];
                bestPointsY = [bestPointsY, b];
            end
        end
    end
    
   
    %disp(columnSize);
    %disp(rowSize);
    dispMin = -(sqrt(power(rowSize,2) + power(columnSize,2)));
    dispMax = (sqrt(power(rowSize,2) + power(columnSize,2)));
    %angleArray = 0:pi/99:pi;
    angleArray = [0,pi];
    disp(length(angleArray));
    votingArray = zeros(abs(dispMin)+ abs(dispMax), length(angleArray));
  
    
    %disp(votingArray);
    %disp(length(bestPointsX));
    
    %disp('poop');
    
    
    for i=1:length(bestPointsX)
		for j=i+1:length(bestPointsX)
            xi = bestPointsY(i);
            yi = rowSize - bestPointsX(i);
            
            xj = bestPointsY(j);
            yj = rowSize - bestPointsX(j);
            
            angle = 0;
            if (xj - xi) ~= 0
                angle = atan(yj - yi/(xj -xi));
                
            else
                angle = pi/2;
            end
			%angleIndex = abs(angle*(6/pi));
            c = [0.5 * (xj+xi), 0.5 * (yj+yi)];
            displacement = c(1)*cos(angle) + c(2)*sin(angle);
            displacementIndex = abs(round((displacement - dispMin)/(dispMax-dispMin))*99)+1;
            %negative diagonal is min
            %positive diagonal is max
            %disp('yes');
            [votingArray, angleArray] = vote(angle, displacementIndex, votingArray, angleArray);
        end
    end
    
    angles = [];
    displs = [];
    votingArraySize = size(votingArray);
    votingArrayRows = votingArraySize(1);
    votingArrayCols = votingArraySize(2);
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
    
    
    finalImage = drawlines(zeros(600,800), angles, displs);
    figure, imshow(image)
    figure, imshow(finalImage)
 
    %disp(votingArray);
end
    