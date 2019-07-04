
h = 1;
k = 0:0.05:1;
l = 0:0.05:1;
x_vals = [];
y_vals = [];
dirs = [];

for hind = 1:length(h)
    for kind  = 1:length(k)
        for lind = 1:length(l)
            if k(kind) >= l(lind)
                magnitude = ( h(hind)^2 +k(kind)^2+l(lind)^2 )^0.5;
                x = h(hind)/ magnitude;
                y = k(kind)/ magnitude;
                z = l(lind)/ magnitude;
                x^2+z^2+y^2;% new x y and z are on unit sphere

                Xv = y;  %
                Yv = z;  % MAX: 0.
                %[h(hind) k(kind) l(lind)]
                %Xv = k(kind)/h(hind)*(45/54.736)*2^0.5;
                %Yv = l(lind)/h(hind);
                dirs = [dirs; [x, y, z]];
                x_vals = [ x_vals Xv ] ;
                y_vals = [ y_vals Yv ] ;
            end
        end
    end
end

% dirs is now created from above
   zcuts = 0:0.1:2.6;%5;  %This is also the resolution you achieve in final graph
   fillfract = zeros(size(dirs,1),length(zcuts));  %if nothinh happens, zeros
    m_or_s = 'm';
   % Find the fluctation data (Y = fillfract, X = zcut)
    
       
fluct = [];
   for d = 1:size(dirs,1)
        for z = 1: length(zcuts)
            fillfract(d,z) = GyrCut(zcuts(z),dirs(d,:),m_or_s,0);
        end
        progress = d/size(dirs,1)
        %plot(zcuts,fillfract(d,:))
        fluct = [fluct  max(fillfract(d,:)) - min(fillfract(d,:))]; % Find the max fluctuation (max - min Xsection fraction)
        %volumefract(d) = sum(fillfract(d,:))/size(fillfract,2);
   end
fluct
x_vals
y_vals

    figure()
    scatter3(x_vals, y_vals, fluct, 100, fluct, 'marker', 'o');
    view([0 0 1])
    colormap('jet')
    view([0 0 1])
    colorbar
    figure()
    scatter3(x_vals, y_vals, -1/log10(fluct), 100, -1/log10(fluct),'marker', '.');
    view([0 0 1])

gx=0:0.01:0.71;%max(x_vals);
gy=0:0.01:0.58;
g=  gridfit(x_vals,y_vals,fluct,gx,gy);
for x = 1:length(gx)
    for y = 1:length(gy)
        if gy(y) > gx(x)  % define conditions to replace data with 0
            g(y,x) = NaN;
        end
        for last21 = length(fluct)-20 : length(fluct)
            if gx(x) > x_vals(last21) && gy(y) > y_vals(last21)
                g(y,x) = NaN;
            end
        end
        if g(y,x) <= 0
            g(y,x) = 10^-6;
        end
    end
end          
h = -1./log10(g);

figure();colormap(jet(256));   surf(gx,gy,g);
figure(); surf(gx,gy,h); 
view([
%camlight right;
%lighting phong;
%shading interp
view([0 0 1]);  
axis image
%{
function [X, Y] = getStereo(h , k ,l)

ma

end
%}