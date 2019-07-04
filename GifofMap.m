%
%
%  Make a gif of the cross section for some 3D binary matrix
%
%
function GifofMap(direction, zcuts, m_or_s, filename)
%
% IN: Plane in the form of (h k l) for the map you wish to view
%     zcuts: where along the direction [h k l] you would like to image it
%
% OUT: Just a gif of of all planes (h k l) at locations specified by zcuts


figure(1)

for z = 1: length(zcuts)
    gifpic = GyrCut(zcuts(z),direction, m_or_s,1);
        figure(1)
        colormap('gray');
        imagesc(gifpic)
        axis equal
        drawnow
          frame = getframe(1);
          im = frame2im(frame);
          [imind,cm] = rgb2ind(im,256);
          if z == 1
              imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
          else
              imwrite(imind,cm,filename,'gif','WriteMode','append');
          end
end

%%% BASED OFF OF THE FOLLOWING EXAMPLE CODE
%{
for n = 1:0.5:5
      y = x.^n;
      plot(x,y)
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if n == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end
%}