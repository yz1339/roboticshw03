function findlineshv(impath)

I = imread(impath);
dims = size(I);




HorizontalLines = I;
VerticalLines = imrotate(I, 270);


%scan for Horizontal lines
HorizontalLines = sum(HorizontalLines, 2);
HorizontalLines = squeeze(HorizontalLines(:,:,1));

HorizontalLinesIndex = getIndexes(HorizontalLines, 10);

%scan for Vertical Lines
VerticalLines = sum(VerticalLines, 2);
VerticalLines = squeeze(VerticalLines(:,:,1));

VerticalLinesIndex = getIndexes(VerticalLines, 10);




imshow(I);



for i = 1:numel(HorizontalLinesIndex)
   y = [HorizontalLinesIndex(i) HorizontalLinesIndex(i)];
   x = [0 dims(2)];
   line(x, y, 'LineWidth', 3, 'Color', 'r' );
end

for i = 1:numel(VerticalLinesIndex)
    
    x = [VerticalLinesIndex(i) VerticalLinesIndex(i)];
    y = [0 dims(1)];
    line(x, y, 'LineWidth', 3, 'Color', 'r' );
    
end

end
