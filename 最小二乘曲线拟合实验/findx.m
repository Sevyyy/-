function findx(x,y,e)
    e = e + 1;
    a = zeros(e,e);
    b = zeros(e,1);
    for j = 1:e
        for k = 1:e
            a(j,k) = fijk(x,j,k);
        end
    end
    
    for k = 1:e
        b(k,1) = fifk(x,y,k);
    end
    
    out = a\b;
    x0 = linspace(0,1);
    y0 = linspace(0,0);
    for i = 1:e
        y0 = y0 + out(i) * x0.^(i-1);
    end
    
    plot(x0,y0);
    
    %{
    out = a\b;
    s = [0 0 0 0 0 0];
    for i = 1:6
        for k = 1:length(out)
            s(i) = s(i) + out(k) * x(i)^(k-1);
        end
    end
    
    delta = (s - y) .* (s - y);
    disp(sum(delta));
    %}
    
end