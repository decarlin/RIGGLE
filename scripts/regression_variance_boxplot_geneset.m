addpath('/cellar/users/decarlin/projects/progenitor_inference/utility/gsea2/')

%pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1.mat'
%posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1_post_run.mat'
%ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt'

%pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1expression.mat'
%posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1expression_post_run.mat'

%figure_location='/dir/for/figures/'

  load(pretrial_mat);
load(posttrial_mat);

  refFH=fopen(ref_file);
  refTFs= textscan(refFH, '%s');
fclose(refFH);

refTFs=refTFs{1};

gene_var=var(beta');
[b_gv,ix_gv]=sort(gene_var,'descend');

label=ismember(genes,refTFs);
str_lab = strread(num2str(label),'%s');

[h,p]=kstest2(gene_var(ismember(genes,refTFs)),gene_var(~ismember(genes,refTFs)),'Tail','smaller')

disp('Enrichment p-value with development penalty')
disp(p)

fi=figure;
s1=log(gene_var(ismember(genes,refTFs))+1e-25);
s2=log(gene_var(~ismember(genes,refTFs))+1e-25);
grp=[zeros(1,sum(ismember(genes,refTFs))),ones(1,sum(~ismember(genes,refTFs)))];
lb=max(prctile(log(gene_var),25)-5,min(log(gene_var)));
boxplot([s1 s2],grp,'notch','on','labels',{'Gold Standard TFs','Other TFs'},'DataLim',[lb,Inf])
ylabel('Global TF importance')
print(fi,strcat(figure_location,'TF_variance_with_tree_penalty_boxplot'),'-dpng')

gene_lasso_var=var(beta_init');
fi2=figure;
s1=log(gene_lasso_var(ismember(genes,refTFs))+1e-25);
s2=log(gene_lasso_var(~ismember(genes,refTFs))+1e-25);
grp=[zeros(1,sum(ismember(genes,refTFs))),ones(1,sum(~ismember(genes,refTFs)))];
lb=max(prctile(log(gene_lasso_var),25)-5,min(log(gene_lasso_var)));
       boxplot([s1 s2],grp,'notch','on','labels',{'Gold Standard TFs','Other TFs'},'DataLim',[lb,Inf]);
ylabel('Global TF importance')
print(fi2,strcat(figure_location,'TF_variance_without_tree_penalty_boxplot'),'-dpng')

[h_lasso,p_lasso]=kstest2(gene_lasso_var(ismember(genes,refTFs)),gene_lasso_var(~ismember(genes,refTFs)),'Tail','smaller')

  disp('Enrichment p-value without penalty')
  disp(p_lasso)
