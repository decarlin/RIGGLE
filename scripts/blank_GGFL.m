%addpath(strcat(pwd,'/SPG_Multi_Graph'))
%addpath(strcat(pwd,'/SPG_singletask'))

%Here are the things to specify from command line:
%indata='/cellar/data/Kriegstein/rbm_output/Kriegstein_multinetTF.tab';
%indesc='/cellar/data/Kriegstein/Kreigstien_info_clean.txt';
%devgraph='/cellar/data/Kriegstein/Kriegstein_development_graph.sif.txt';
%samples_file='/cellar/data/Kriegstein/samples.tab';
%genes_file='/cellar/data/Kriegstein/genes.tab';
%run_name='Kreigstein_multinetTF'
%output_path='/cellar/users/decarlin/projects/progenitor_inference/results/Kriegstein_results'

%in standard ML, X is the input data
%

import bioma.data.*
D=DataMatrix('File', indata);
X = D.Matrix';
samples=D.RowNames;
genes=D.ColNames;

%parse descriptions
  
desID=fopen(indesc);
D=textscan(desID,'%s %s %s', 'Delimiter', '\t');
  fclose(desID);

%parse development graph

graphID=fopen(devgraph);
g=textscan(graphID,'%s %s %s', 'Delimiter', '\t');
fclose(graphID);

%here are all categories
designRows=unique(D{2});

design_matrix=zeros(length(designRows),length(samples));

%C is the node-edge incidence graph

C = zeros(length(designRows),length(g{1}));

  for j=1:length(g{1})
	  parent=find(strcmp(g{1}(j),designRows));
child=find(strcmp(g{3}(j),designRows));
C(parent,j)=1;
C(child,j)=-1;
end

%shortest paths calculation
L=C*C';                                                                                                                      
A=-(L-diag(diag(L)));                                                                                                        
Dist=graphallshortestpaths(sparse(A));

  for i = 1:length(designRows)
	    these_samples=D{1}(strcmp(designRows{i},D{2}));
design_matrix(i,ismember(samples,these_samples))=1;
end

CNorm=2*max(sum(C.^2,1));

%execute regression task

option.cortype=2;
%option.nE=5*J

option.maxiter=10000;
option.tol=1e-8;  
option.verbose=true;
option.display_iter=50;
option.mu=1e-4;  % smaller mu leads more accurate solution
gamma=1;

% get initial betas from vanilla regression

for k=1:size(design_matrix,1)
	[beta_lasso fit_info] = lasso(X',design_matrix(k,:)','CV',5);
beta_init(:,k)=beta_lasso(:,fit_info.IndexMinMSE);

end

  lambda=fit_info.Lambda(fit_info.IndexMinMSE);

  option.b_init=beta_init;

%[beta, obj, density, iter, time]=SPG_multi(design_matrix',X',gamma, lambda, C', CNorm, option);

%err=sum(sum((X'*beta-design_matrix').^2)');

save(sprintf('%s/all_pretrial_%s.mat',output_path,run_name));

% 5-fold xval

indices = crossvalind('Kfold',D{2},5);

  for i = 1:5
	    test = (indices == i); train = ~test;
null_err(i)=sum(sum((design_matrix(:,test)').^2)');

end

%gamma_seq=[0,0.5,1,5,10,50,100];
gamma_seq=[0,0.001,0.01,0.05,0.075,0.1,0.25,0.5,0.75,1,5,10];

best_gamma=-1;
best_acc=-1;

for gamma = gamma_seq
  for i = 1:5
	    test = (indices == i); train = ~test;
	    [beta, obj, density, iter, time]=SPG_multi(design_matrix(:,train)',X(:,train)',gamma, lambda, C', CNorm, option);
test_err(i)=sum(sum((X(:,test)'*beta-design_matrix(:,test)').^2)');
acc(i)=sum(min(best_guess(beta'*X(:,test),1)-design_matrix(:,test))~=-1)/size(design_matrix(:,test),2);
ge=shortest_path_error(best_guess(beta'*X(:,test),1), design_matrix(:,test) ,Dist);
mean_ge(i)=mean(ge);
std_ge(i)=std(ge);
end
	   if mean(acc)>best_acc
	   best_acc=mean(acc);
	   best_gamma=gamma;
	   end

  save(sprintf('%s/%s_test_err_gamma_%.3f.mat',output_path,run_name,gamma),'test_err','acc','mean_ge','std_ge')
	   clear('test_err','acc','mean_ge','std_ge')
end

%train an overall model for downstream analysis

	   [beta, obj, density, iter, time]=SPG_multi(design_matrix',X',best_gamma, lambda, C', CNorm, option);

	   save(sprintf('%s/%s_post_run.mat',output_path,run_name),'best_acc','best_gamma','beta','lambda')
