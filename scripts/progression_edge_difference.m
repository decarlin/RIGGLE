function [diff]=progression_edge_difference(betas, parent, child, phenotypes)
                    
parentRow=find(strcmp(parent,phenotypes));
childRow=find(strcmp(child,phenotypes));

diff=betas(:,childRow)-betas(:,parentRow);
if isempty(diff)
diff=zeros(size(betas,1) ,1);
end
end
