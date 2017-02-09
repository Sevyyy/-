A = [0 0 0 0 0 0 0;
     0 0 1 1 0 0 0;
     0 0 0 1 0 0 0;
     0 0 0 1 1 0 0;
     0 0 1 1 1 1 0;
     0 0 1 1 1 0 0;
     0 1 0 1 0 1 0;
     0 0 0 0 0 0 0];
B1 = [1 1 1];
center1 = [1,1];
B2 = [1 1;0 1];
center2 = [1,2];

C1 = dilation(A,B1,center1);
C2 = erosion(A,B1,center1);
C3 = dilation(A,B2,center2);
C4 = erosion(A,B2,center2);
C5 = dilation(erosion(A,B1,center1),B1,center1);
C6 = dilation(erosion(A,B2,center2),B2,center2);
C7 = erosion(dilation(A,B1,center1),B1,center1);
C8 = erosion(dilation(A,B2,center2),B2,center2);

subplot(4,2,1);
imshow(C1)
subplot(4,2,2);
imshow(C2);
subplot(4,2,3);
imshow(C3);
subplot(4,2,4);
imshow(C4);
subplot(4,2,5);
imshow(C5)
subplot(4,2,6);
imshow(C6);
subplot(4,2,7);
imshow(C7)
subplot(4,2,8);
imshow(C8);
