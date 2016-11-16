function [out]=shortest_path_error(pred,true_Y,D)

  [r_pred,c_pred]=find(pred);
[r_Y,c_Y]=find(true_Y);

out=diag(D(r_pred,r_Y));

end
