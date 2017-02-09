count = 0;
error = 10^-8;
x = 0.5;
x_1 = 0.5;

while(1)
   x = x_1;
   %{
   temp = 20 / (x^2 + 2*x + 10);
   up = (temp - x)^2;
   down = 20 / (temp^2 + 2*temp + 10) - 2*temp + x;
   %}
   temp = (x^2 + 2 - exp(x)) / 3;
   up = (temp - x)^2;
   down = (temp^2 + 2 - exp(temp)) / 3 -2*temp + x;
   x_1 = x - up / down;

   count = count + 1;
   disp(vpa(x_1,20));
   if abs(x_1 - x) < error
       break;
   end
end


disp(count);