%input_path='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/';



TF_vars_file=sprintf('%s/figures/TF_table_raw.txt',input_path);
[b_gv,ix_gv]=sort(gene_var_sum,'descend');
gold_std_tfs=ismember(genes,refTFs)
  T=table(genes_w_exp(ix_gv)',log(gene_var_sum(ix_gv))',log(gene_var_infer_common(ix_gv))',log(gene_var_exp(ix_gv))',gold_std_tfs(ix_gv)')
writetable(T,TF_vars_file,'Delimiter','\t')
