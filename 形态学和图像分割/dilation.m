function [C] = dilation(A, B, pos)
   [a_m,a_n] = size(A);
   [b_m,b_n] = size(B);
   AA = zeros(a_m+b_m*2,a_n+b_n*2);
   AA(b_m+1:b_m+a_m,b_n+1:b_n+a_n) = A;
   C = zeros(a_m,a_n);
   for i = b_m+1:b_m+a_m
       for j = b_n+1:b_n+a_n
           row = i-pos(1)+1;
           col = j-pos(2)+1;
           temp = AA(row:row+b_m-1,col:col+b_n-1) & B;
           if any(any(temp))
               C(i-b_m, j-b_n) = 1;
           end   
       end
   end
end

