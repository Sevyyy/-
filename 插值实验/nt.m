function f = nt(x, y)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    syms t;
    n=length(x);
    
    f = y(1);
    y1 = 0;
    l = 1;
    
    for i = 1:n-1
           for j = i+1:n
               y1(j) = (y(j)-y(i))/(x(j)-x(i));
           end
            c(i)=y1(i+1);
            disp(y1(i + 1));
            l=l*(t-x(i)); 
            f=f+c(i)*l; 
            y=y1;
    end
    f = simplify(f);
    
end

