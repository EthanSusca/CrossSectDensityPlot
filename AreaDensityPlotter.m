%
%
%   Makes and holds indivdual graph fluctions along z direction for an
%   array of z directions
%
function  vol_fract = AreaDensityPlotter(m_or_s)

% INPUT: do you want to see the cross sectional volume fraction for the
% matrix or the shell? 'matrix' or 'shell' write 'm' or 's'

% Don't forget to change legend below!
   dirs = [2 1 1; 5 2 2; 9 5 5; 9 4 2; 9 6 4];%[ 2 1 1; 1 1 0; 1 1 1; 1 0 0];%5 2 2; 9 5 5; 3 1 1; 1 0 0; 2 1 0; 3 1 0; 3 2 0 ];%;[5 2 2; 2 1 1; 1 1 1; 1 1 0; 1 0 0];
   zcuts = 0:0.1:5;  %This is also the resolution you achieve in final graph
   fillfract = zeros(size(dirs,1),length(zcuts));  %if nothinh happens, zeros
    
    for d = 1:size(dirs,1)
        for z = 1: length(zcuts)
        fillfract(d,z) = GyrCut(zcuts(z),dirs(d,:),m_or_s,0);
        end
    end
   
  %{
  %calculate fractional cross-section changes for shell
    for d = 1:size(dirs,1)
        for z = 1: length(zcuts)
        fillfract(d,z) = GyrCut(zcuts(z),dirs(d,:),m_or_s,0);
        end
    end
   %}
   
    volumefract = zeros(1,size(dirs,1)); % This is the volume fraction
    figure(16)
    hold on
    for d = 1:size(dirs,1)
        plot(zcuts,fillfract(d,:))
        fluct = max(fillfract(d,:)) - min(fillfract(d,:));
        volumefract(d) = sum(fillfract(d,:))/size(fillfract,2);
    end
    %legend('[2 1 1]','[1 1 0]','[1 1 1]','[1 0 0]')
    legend('[2 1 1]','[5 2 2]','[9 5 5]','[9 4 2]','[9 6 4]')
    legend({},'FontSize',18)
    legend('Location','southeast')
    
    hold off
   
    vol_fract = volumefract;
    pubgraph(16,18,3,'white')
end
