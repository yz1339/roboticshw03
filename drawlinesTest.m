
 %This displays answer for Question 2b-a
 angles = (3*pi)/4;
 %Lines of angle > pi/2 have negative displacement
 displs = -200;
 finalImag = drawlines(zeros(300,400),angles,displs);
 disp(finalImag);
 figure, imshow(finalImag)
 
 
 %This displays answer for Question 2b-b
 angles = pi/4;
 %Lines of angle < pi/2 can have negative or positive displacement:
 %They are negative when holding below the point (0,0)
 displs = -100;
 finalImag = drawlines(zeros(300,400),angles,displs);
 disp(finalImag);
 figure, imshow(finalImag)
 
 %This displays answer for Question 2b-c
 angles = pi/6;
 %Lines of angle < pi/2 can have negative or positive displacement
 %They are positive when holding above the point (0,0)
 displs = 50;
 finalImag = drawlines(zeros(300,400),angles,displs);
 disp(finalImag);
 figure, imshow(finalImag)