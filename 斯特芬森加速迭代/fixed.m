count = 0;
error = 10^-8;
x_0 = 1.5;
x_1 = 1.5;

while(count < 10)
    x_0 = x_1;
   temp = 20 / (x_0^2 + 2*x_0 + 10);
   %x_1 = x_0 - ((temp - x_0)^2 / ((20 / (temp^2 + 2*temp + 10)) - 2*temp + x_0));
   x_1 = temp;
   count = count + 1;
   disp(x_1);
   if abs(x_1 - x_0) < error
       break;
   end
end

disp(vpa(x_1,10));
disp(count);