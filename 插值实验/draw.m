function draw(x, y)
    syms t;
    if(length(x) ~= length(y))
        disp('Dimension not equal!');
        return;
    end
    n = length(x);
    table = zeros(n,n-1);
    table = [y',table];
    for j = 2:n
        for i = j:n
            table(i,j) = (table(i,j-1) - table(i-1,j-1)) / (x(i) - x(i-j+1));
        end
    end
    %disp(table);
    
    x_1 = linspace(0,1);
    x_2 = 0:64;
    y_newton_1 = 0;
    y_newton_2 = 0;
    for i = 1:n
        z_1 = 1;
        z_2 = 1;
        for k = 1:i-1
            z_1 = z_1 .* (x_1 - x(k));
            z_2 = z_2 .* (x_2 - x(k));
        end
        y_newton_1 = y_newton_1 + table(i,i) * z_1;
        y_newton_2 = y_newton_2 + table(i,i) * z_2;
    end
    
    pp = csape(x, y, 'complete');
    disp('三次样条插值函数的每段的系数');
    disp(pp.coefs);
    y_spline_1 = ppval(pp, x_1);
    y_spline_2 = ppval(pp, x_2);
    
    y_stand_1 = sqrt(x_1);
    y_stand_2 = sqrt(x_2);
     
    subplot(2,1,2);
    plot(x_1,y_stand_1,'r',x_1, y_newton_1,'m--',x_1,y_spline_1,'k-.');
    xlabel('x');
    ylabel('y');
    title('平方根函数和它的插值函数(0-->1)');
    legend('开方函数','牛顿插值','样条插值','location','southeast');
    
    subplot(2,1,1);
    plot(x_2,y_stand_2,'k',x_2, y_newton_2,'r:',x_2,y_spline_2,'m-.');
    xlabel('x');
    ylabel('y');
    title('平方根函数和它的插值函数(0-->64)');
    legend('开方函数','牛顿插值','样条插值','location','northwest');
    
    f = table(n, n) * (t - x(n-1));
    for i = 8:-1:2
        f = (f + table(i, i)) * (t - x(i-1));
        f = simplify(f);
    end
    f = expand(f);
    disp('牛顿插值函数表达式L8(x)：');
    pretty(f);
end
    
    