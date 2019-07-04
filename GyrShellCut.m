%%% ADDS UP ALL THE Pts(x,y) at set z  
%%% if (x,y,z) is in the double gyroid matrix,
%%% send in z value at which to evaluate the function
%%% at all x & y value at set z: 1 if in matrix, 0 i
%%% set direction for x-y plane normal (or lab z direction)
% 
%

function area_dens_or_2Dmap = GyrShellCut( zconst, direction, addZtogif)
    
   %xval = 0:0.025:40; %8 * 6.3 makes lots of cells
   %yval = 0:0.025:40;
   xval = 0:0.1:100; %8 * 6.3 makes lots of cells
   yval = 0:0.1:100;
   
   sumZvals = 0;
   sum2D = zeros(length(xval),length(yval));
   
        % Coordinate ranform [T] is calcuated
        % then A = [T]a
        a = [1 0 0]; b = [0 1 0]; c = [0 0 1]; % Lab frame.... Integrating on c
        
        if sum(direction == [2 1 1])==3
            A = [0 1 -1]; B = [-1 1 1]; C = [2 1 1];end
        if sum(direction == [1 1 1])==3 
            A = [2 1 1]; B = [0 1 -1]; C = [-1 1 1];end
        if sum(direction == [1 1 0])==3 
            A = [-1 1 1]; B = [2 1 1]; C = [0 1 -1];end
        if sum(direction == [1 0 0])==3
            A = [1 0 0]; B = [0 1 0]; C = [0 0 1];end
        if sum(direction == [5 2 2])==3 
            A = [0 1 -1]; B = [-4 5 5]; C = [5 2 2];end
        if sum(direction == [9 4 4])==3 
            A = [0 1 -1]; B = [-1 9/8 9/8]; C = [9 4 4];end
        if sum(direction == [9 5 5])==3 
            A = [0 1 -1]; B = [-1 9/10 9/10]; C = [9 5 5];end
        if sum(direction == [3 2 2])==3 
            A = [0 1 -1]; B = [-1 0.75 0.75]; C = [3 2 2];end
        if sum(direction == [2 1 0])==3 
            A = [0 0 1]; B = [-1 2 0]; C = [2 1 0];end
         if sum(direction == [3 1 0])==3 
            A = [0 0 1]; B = [-1 3 0]; C = [3 1 0];end
        if sum(direction == [2 2 1])==3 
            A = [0 1 -1]; B = [-4 1 1]; C = [1 2 2];end
        if sum(direction == [9 4 2])==3 
            A = [0 1 -2]; B = [-10/9 2 1]; C = [9 4 2];end
        if sum(direction == [9 6 4])==3 
            A = [0 4 -6]; B = [-52/9 6 4]; C = [9 6 4];end
%         if sum(direction == [3 2 1])==3 
%             A = [0 1 -1]; B = [-4 -1 2]; C = [1 2 3];end
        if sum(direction == [3 1 1])==3 
            A = [0 1 -1]; B = [-1 1.5 1.5]; C = [3 1 1];end
        if sum(direction == [3 2 0])==3 
            A = [0 0 1]; B = [-2 3 0]; C = [3 2 0];end

        a11 = atan2(norm(cross(a,A)),dot(a,A));
        a12 = atan2(norm(cross(a,B)),dot(a,B));
        a13 = atan2(norm(cross(a,C)),dot(a,C));
        a21 = atan2(norm(cross(b,A)),dot(b,A));
        a22 = atan2(norm(cross(b,B)),dot(b,B));
        a23 = atan2(norm(cross(b,C)),dot(b,C));
        a31 = atan2(norm(cross(c,A)),dot(c,A));
        a32 = atan2(norm(cross(c,B)),dot(c,B));
        a33 = atan2(norm(cross(c,C)),dot(c,C));
        %%And the trasnformation is...
        
        for nX = 1:length(xval)
            for nY = 1:length(yval)
            x = xval(nX);
            y = yval(nY);
            z = zconst;
            tv = [cos(a11) cos(a12) cos(a13); cos(a21) cos(a22) cos(a23); cos(a31) cos(a32) cos(a33)]*[x;y;z];
        
            % Goal: switch to a 3 component system... try graphing the
            % middle component (shell around struts) instead of matrix
                if 1.042 <= abs(cos(tv(1))*sin(tv(2))+cos(tv(2))*sin(tv(3))+ cos(tv(3))*sin(tv(1))-0.05*(cos(2*tv(1))*cos(2*tv(2))+cos(2*tv(2))*cos(2*tv(3))+cos(2*tv(3))*cos(2*tv(1))) ) ...
                        && 1.314 >= abs(cos(tv(1))*sin(tv(2))+cos(tv(2))*sin(tv(3))+ cos(tv(3))*sin(tv(1))-0.05*(cos(2*tv(1))*cos(2*tv(2))+cos(2*tv(2))*cos(2*tv(3))+cos(2*tv(3))*cos(2*tv(1)))  )
                       sumZvals = sumZvals + 1; 
                     if addZtogif == 1
                           sum2D(nX,nY) = 1;
                     end
                end
            end
        end
                % Below if gif of map is desired
        if addZtogif == 1
            area_dens_or_2Dmap = sum2D;
        end
      
        if addZtogif == 0
            area_dens_or_2Dmap = sumZvals/(length(xval)*length(yval));
        end
          