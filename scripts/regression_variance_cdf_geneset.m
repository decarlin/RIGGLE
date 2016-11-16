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
h1=cdfplot(log(gene_var(ismember(genes,refTFs))));
hold on;
h2=cdfplot(log(gene_var(~ismember(genes,refTFs))));
xlabel('Log variance of regression coeffecient');
ylabel('Cumulative Density');
legend({'Known Participating TFs','Other TFs'},'Location','northwest');
title('CDF of regression coeffecient variance with development graph');
print(fi,strcat(figure_location,'TF_variance_with_tree_penalty'),'-dpng');

hold off


gene_lasso_var=var(beta_init');
fi2=figure;
h1=cdfplot(log(gene_lasso_var(ismember(genes,refTFs))));
hold on;
h2=cdfplot(log(gene_lasso_var(~ismember(genes,refTFs))));
xlabel('Log variance of regression coeffecient');
ylabel('Cumulative Density');
legend({'Known Participating TFs','Other TFs'}, 'Location','northwest');
title('CDF of regression coeffecient variance without development graph');
print(fi2,strcat(figure_location,'TF_variance_without_tree_penalty'),'-dpng');
hold off;

[h_lasso,p_lasso]=kstest2(gene_lasso_var(ismember(genes,refTFs)),gene_lasso_var(~ismember(genes,refTFs)),'Tail','smaller')

  disp('Enrichment p-value without penalty')
  disp(p_lasso)
