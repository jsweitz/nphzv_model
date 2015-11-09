function stabType = what_type_stability(maxEig);
%function stabType = what_type_stability(maxEig);
% returns 1-4 depending on stability criteria
% returns:
 %1 if maxEig is real and negative
 %2 if maxEig is imaginary with negative real part
 %3 if maxEig is positive
 %4 if maxEig is imaginary with positive real part
 %5 if neutral
 
 stabType = zeros(size(maxEig));
 for i =1:(size(maxEig,1)*size(maxEig,2))
     if isreal(maxEig(i))
         if maxEig(i) < 0
             stabType(i) = 1;
         elseif maxEig(i) > 0
             stabType(i) = 3;
         elseif maxEig(i) == 0
             stabType(i) = 5;
         end
     else
         if real(maxEig(i)) < 0
             stabType(i) = 2;
         elseif real(maxEig(i)) > 0
             stabType(i) = 4;
         elseif real(maxEig(i)) == 0
             stabType(i) = 5;
         end
     end
 end