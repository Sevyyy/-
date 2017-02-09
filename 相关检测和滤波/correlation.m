function gama = correlation(w,f,m,n,w_mean)
    %w->weight f->the image,m and n is the size
    f_mean = sum(sum(f)) / (m*n);
    w = w - w_mean;
    f = f - f_mean;
    temp1 = sum(sum(w .* f));
    temp2 = sum(sum(w .* w));
    temp3 = sum(sum(f .* f));
    gama = temp1 / sqrt(temp2 * temp3);
end

