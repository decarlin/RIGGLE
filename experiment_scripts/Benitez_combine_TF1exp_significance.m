ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/pancreas_tfs.txt';

refFH=fopen(ref_file);
refTFs= textscan(refFH, '%s');
fclose(refFH);
refTFs=refTFs{1};

pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1_TFexpOnly.mat';
posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_TFexpOnly_post_run.mat';
load(pretrial_mat);
load(posttrial_mat);
gene_var_exp=var(beta_init');
genes_w_exp=genes;

pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1.mat';
posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_post_run.mat';
load(pretrial_mat);
load(posttrial_mat);
gene_var_infer=var(beta');
genes_infer=genes;

input_path='/cellar/users/decarlin/Data/Benitez/results_TF1';
TF_vars_file=sprintf('%s/TF_table_raw_infer_only.txt',input_path);
[b_gv,ix_gv]=sort(gene_var_infer,'descend');
gold_std_tfs=ismember(genes_infer,refTFs);
T=table(genes(ix_gv)',(gene_var_infer(ix_gv)/max(gene_var_infer))',gold_std_tfs(ix_gv)')                                                                     
writetable(T,TF_vars_file,'Delimiter','\t')


gene_var_infer_common=gene_var_infer(ismember(genes_infer,genes_w_exp));

gene_var_sum=(gene_var_infer_common/max(gene_var_infer_common))+(gene_var_exp/max(gene_var_exp))

[h,p]=kstest2(gene_var_sum(ismember(genes_w_exp,refTFs)),gene_var_sum(~ismember(genes_w_exp,refTFs)),'Tail','smaller');

pearson=corrcoef(gene_var_infer_common,gene_var_exp);

sz = 25;

fi=figure;
[s1,r_infer]=sort(gene_var_infer_common);
  [s2,r_expr]=sort(gene_var_exp);

%p=scatter(r_infer,r_expr,sz,ismember(genes_w_exp,refTFs));
%input_path='/cellar/users/decarlin/Data/Benitez/results_TF1';
%plot_name=sprintf('%s/figures/infer_v_expr',input_path);
%  xlabel('Rank Infered TF activity importance')
%  ylabel('Rank TF expression importance')
%print(fi,plot_name,'-dpng')

fi2=figure;
plot_name=sprintf('%s/figures/combined_expr_infer_pdf',input_path);
h1=histogram(log(gene_var_sum(ismember(genes_w_exp,refTFs))));
h1.Normalization='probability';
h1.BinWidth=0.25;
hold on;
h2=histogram(log(gene_var_sum(~ismember(genes_w_exp,refTFs))));
h2.Normalization = 'probability';
h2.BinWidth=0.25;
xlabel('Log variance of regression coeffecient');
ylabel('Density');
legend({'Known Participating TFs','Other TFs'}, 'Location','northwest');
title('PDF of combined TF expression and inferred activity');
print(fi2,plot_name,'-dpng');
hold off;
