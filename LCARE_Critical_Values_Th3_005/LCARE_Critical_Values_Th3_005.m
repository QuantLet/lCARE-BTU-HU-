
clear all; clc;

% Input
K                       = 11;                                     
rho                     = 0.25;                                 
CARE_RB_Th3_005         = load('CARE_RB_Th3_005'); 
T_k_Th3_005             = load('T_k_Th3_005');          
y_t_005_Th3             = load('y_t_005_Th3');
V                       = size(y_t_005_Th3, 2);
CARE_risk_bound_Th3_005 = load('CARE_risk_bound_Th3_005.mat');
CARE_LR_c_Th3_005       = CARE_risk_bound_Th3_005.CARE_LR_c_Th3_005;
CARE_LR_d_Th3_005       = CARE_risk_bound_Th3_005.CARE_LR_d_Th3_005;

% Programme Code
z_k_c_Th3_005 = zeros(K - 1, K - 1); 
z_k_d_Th3_005 = zeros(K - 1, K - 1);
for s = 1 : 1 : (K - 1)
  for s_step = 1 : 1 : K - 1
      
      z_k_c_Th3_005(s, s_step) = LCARE_Propagation_Condition(s, s_step, ...
                                  V, T_k_Th3_005, CARE_LR_c_Th3_005, 1)...
                                 + CARE_RB_Th3_005(1);
      z_k_d_Th3_005(s, s_step) = LCARE_Propagation_Condition(s, s_step, ...
                                  V, T_k_Th3_005, CARE_LR_d_Th3_005, 2)...
                                 + CARE_RB_Th3_005(2);
                             
  end
end
z_k_c_Th3_005 = diag(z_k_c_Th3_005); 
z_k_d_Th3_005 = diag(z_k_d_Th3_005);
z_k_Th3_005   = [z_k_c_Th3_005, z_k_d_Th3_005];

for i = 1 : 1 : 2
  for s = 2 : 1 : length(z_k_Th3_005)
      
    if z_k_Th3_005(s, i) > z_k_Th3_005(s - 1, i)
        z_k_Th3_005(s, i) = z_k_Th3_005(s - 1, i);
    else
        z_k_Th3_005(s, i) = z_k_Th3_005(s, i);
    end
    
  end
end

% Output
Out.z_k_Th3_005 = z_k_Th3_005;
save('z_k_Th3_005', 'z_k_Th3_005', '-ascii');

