addpath('/cellar/users/decarlin/projects/progenitor_inference/utility/gsea2/')

%pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1.mat'
%posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1_post_run.mat'
%ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt'

%pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1expression.mat'
%posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1expression_post_run.mat'

%TF_vars_file='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/TF_beta_vars.txt'

  load(pretrial_mat);
load(posttrial_mat);

gene_var=var(beta');
[b_gv,ix_gv]=sort(gene_var,'descend');

T=table(genes(ix_gv)',b_gv')

writetable(T,TF_vars_file,'Delimiter','\t')
