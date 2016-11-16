function [out]=best_guess(X, topN)

  Xrank=tiedrank(X);

out= (Xrank>(size(X,1)-topN));

end
