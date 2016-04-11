function indexes = getIndexes(data, width)


derivative = diff(data);
for i = 1:size(derivative)
   derivative(i) = abs(derivative(i));
end

[peaks, locs] = findpeaks(derivative);

%clean up data

MAX = max(peaks);
for i = 1:size(peaks)
    if ((peaks(i)/MAX) < 0.05)
        peaks(i) = 0;
        locs(i) = 0;
    end
end

indexes =[ ];
for i = 1:size(locs)
    if(locs(i) ~= 0)
        
        if(i > 1)
            %compare to previous element
            if((locs(i) - locs(i-1)) < width)
                %do nothing
            else
                indexes = [indexes locs(i)];
                disp(locs(i));
            end
        else
            
            indexes = [indexes locs(i)];
            disp(locs(i));
            
        end     
    end
    
end


end
