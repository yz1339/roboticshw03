function [A,B] = vote(angle, displacementIndex, array, angleArray) 
    %if ismember(angle,angleArray) == 1
     angleIndex = 0;
     wasFound = -1;
     %disp('Length!!:');
     %disp(length(angleArray));
     for i = 1:length(angleArray)
         %disp('ANGLE!!!');
         %disp(angle);
         %disp(angleArray(i));
        if angle == angleArray(i)
            angleIndex = i;
            wasFound = 1;
            %disp(angleIndex);
            break;  
        end 
     end
            
     %   end
    if wasFound == 1     
        %disp('DISPLACEMENT AND ANGLE');
        %disp(displacementIndex);
        %disp(angleArray(angleIndex));
        array(displacementIndex, angleIndex) = array(displacementIndex,angleIndex)+1;
        %disp('final result');
       % disp( array(displacementIndex, angleIndex));
    else
        %disp('helloooo');
        %disp(size(array));
        angleArray = [angleArray, angle];
        tempAngleIndex = size(angleArray);
        angleIndex = tempAngleIndex(2);
        arraySize =size(array);
        
        newColumn = [];
        for i = 1:arraySize(1)
            newColumn = [newColumn; 0];
        end
        %disp(size(array));
        %array(:, arraySize(2)+1) = [0;0];
        array(:, arraySize(2)+1) = newColumn;
        
        %for i = 1:arraySize(1)
        %    array(i) = [array(i), 0];
        %end
        %disp(displacementIndex)
        %disp(angleArray)
        
        %disp('before');
        %disp(displacementIndex);
        %disp(angleIndex);
        %disp(array(displacementIndex, angleIndex));
        array(displacementIndex, angleIndex) = array(displacementIndex, angleIndex) + 1;
        %disp('lol!!!');
       % disp(array(displacementIndex, angleIndex));
       
    end
    A = array;
    B = angleArray;
    
end