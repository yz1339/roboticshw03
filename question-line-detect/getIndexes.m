function indexes = getIndexes(data, width)

%this function will get the indexes at which there are lines (vrtcl,
%hrznt)


%get derivative of the plotted data, to find all the peaks
derivative = diff(data);
for i = 1:size(derivative)
   derivative(i) = abs(derivative(i));
end

[peaks, locs] = findpeaks(derivative);

%clean up data, only the "relevant" (large) peaks will be considered
%as places where a line begins
MAX = max(peaks);
for i = 1:size(peaks)
    if ((peaks(i)/MAX) < 0.05)
        %if the peak is not relevant (less than 5% of the max, then
        %changed for a zero

        peaks(i) = 0;
        locs(i) = 0;
    end
end

indexes =[ ];
%get all the indexes where the lines are
for i = 1:size(locs)
    if(locs(i) ~= 0)
        
        if(i > 1)
            %this filters out very thin lines, i.e.,
            %if the previous element is very close together (two "peaks"
            %in very close proximity, then one of them is not added
            %since thre is only one line. If they are not close together
            %then that means that the other peak is a line where a larger
            %element ends, like the opposite side of the square.

            %compare to previous element
            if((locs(i) - locs(i-1)) < width)
                %do nothing
            else
                indexes = [indexes locs(i)];
                %disp(locs(i));
            end
        else
            
            indexes = [indexes locs(i)];
            %disp(locs(i));
            
        end     
    end
    
end


end
