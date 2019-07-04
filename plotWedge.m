%
%
% Trying to plot my own "wedge"
% 
h = 1;%0:0.1:1; 
k =  0:0.1:1;%ones(1,11)*10;% 0:10;%ones(1,11)*10;%10; 
l =  0:0.1:1;%0:0.1:1;%0.1:0.1:1;%ones(1,11)*10;%0:10; 10:-1:0;  % define orientation space
x_list = zeros( 1,length(k) );
y_list = zeros( 1,length(l) );


for lind = 1:length(l)
    for kind  = 1:length(k)
        for hind = 1:length(h)
    %phi1 = asin( (h^2+k(kind)^2+l(lind)^2)^0.5/(h^2+k(kind)^2)^0.5 ) *180/pi - 90
    phi2 =  acos( k(kind)/(h(hind)^2+k(kind)^2)^0.5 )*180/pi   % Length from center point [100]
    PHI =  90- acos( l(lind)/(h(hind)^2+k(kind)^2+l(lind)^2)^0.5 )*180/pi   %Angle from [100]-[110] arc)
    %%{
    if phi2 > 45 && phi2 <= 90
        phi2 = 45 - (phi2 - 45) 
    end
    %if PHI > acos( 1/3^0.5)*180/pi  %<=90
       % PHI = acos(1/3^0.5)*180/pi -  (PHI-  acos( 1/3^0.5)*180/pi ) 
    %end
    %}
    x_list = [  x_list  phi2*cos(PHI*pi/180)  ];  % (45/54.736)   45/55 = conversion for wedge coords
    y_list = [  y_list  phi2*sin(PHI*pi/180)  ];
    

        end
    end
end
figure()
%xylist = [x_list; y_list]
plot(x_list, y_list);
axis image;
%xlim([0 45]);ylim([0 45]);
%surf(x_list,y_list, ones(length(y_list),length(x_list)));

