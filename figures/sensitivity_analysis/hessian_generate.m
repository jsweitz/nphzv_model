function [H, Hlog] = hessian_generate(pars,vars)

dydp_mat = dydp(pars);  %unnormalized sensitivity matrix. i,jth element is
                        %dy_i/dp_j, where y is variable and p is parameter.

senspars = pars([1:19 23:end]);
parsmat = senspars'*senspars;   %prefactor for log space p calculations



ystar_vec = vars;    %solution to system, output is row vector

ystar_vec = ystar_vec';     %transpose

ystar_mat = repmat(ystar_vec,1,size(dydp_mat,2));    %normalizing matrix

gamma = dydp_mat./ystar_mat; %normalize sensitivity matrix for relative
                            %changes in variable. i,jth element is
                            %(1/y_i)*(dy_i/dp_j)

H = gamma'*gamma;       %Hessian following gutenkunst
                        %H_{i,j} = Sum_s (1/y_s)^2*(d^2y_s/dp_i dp_j)

Hlog = H.*parsmat;