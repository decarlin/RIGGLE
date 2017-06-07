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


gene_lasso_var=var(beta');
fi2=figure;
[f1,xi1]=ksdensity(log(gene_lasso_var(ismember(genes,refTFs))));
plot(xi1,f1);
hold on;
[f2,xi2]=ksdensity(log(gene_lasso_var(~ismember(genes,refTFs))));
  plot(xi2,f2);
xlabel('Log variance of regression coeffecient');
ylabel('Density');
legend({'Known Participating TFs','Other TFs'}, 'Location','northwest');
title('PDF of regression coeffecient variance without development graph');
print(fi2,strcat(figure_location,'TF_variance_tree_penalty_density_pdf'),'-dpng');
hold off;

[h_lasso,p_lasso]=kstest2(gene_lasso_var(ismember(genes,refTFs)),gene_lasso_var(~ismember(genes,refTFs)),'Tail','smaller')

  disp('Enrichment p-value with penalty')
  disp(p_lasso)
