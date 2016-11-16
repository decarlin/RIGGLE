ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt';

refFH=fopen(ref_file);
refTFs= textscan(refFH, '%s');
fclose(refFH);
refTFs=refTFs{1};

pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1expression.mat';
posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1expression_post_run.mat';
load(pretrial_mat);
load(posttrial_mat);
gene_var_exp=var(beta_init');
genes_w_exp=genes;

pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1.mat';
posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1_post_run.mat';
load(pretrial_mat);
load(posttrial_mat);
gene_var_infer=var(beta');
genes_infer=genes;

gene_var_infer_common=gene_var_infer(ismember(genes_infer,genes_w_exp));

gene_var_sum=(gene_var_infer_common/max(gene_var_infer_common))+(gene_var_exp/max(gene_var_exp))

[h,p]=kstest2(gene_var_sum(ismember(genes_w_exp,refTFs)),gene_var_sum(~ismember(genes_w_exp,refTFs)),'Tail','smaller');

pearson=corrcoef(gene_var_infer_common,gene_var_exp);

sz = 25;

input_path='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/';
figure_location=sprintf('%s/figures/',input_path);

fi=figure;
s1=log(gene_var_sum(ismember(genes_w_exp,refTFs)));
s2=log(gene_var_sum(~ismember(genes_w_exp,refTFs)));
grp=[zeros(1,sum(ismember(genes_w_exp,refTFs))),ones(1,sum(~ismember(genes_w_exp,refTFs)))];
lb=max(prctile(log(gene_var_sum),25)-5,min(log(gene_var_sum)));
boxplot([s1 s2],grp,'notch','on','labels',{'Gold Standard TFs','Other TFs'},'DataLim',[lb,Inf]);
ylabel('Global TF importance')
print(fi,strcat(figure_location,'Nov_TF_combined_boxplot'),'-dpng')


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


input_path='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/';
TF_vars_file=sprintf('%s/figures/TF_table_raw.txt',input_path);
genes_w_exp(gene_var_sum==max(gene_var_sum))
[b_gv,ix_gv]=sort(gene_var_sum,'descend');
gold_std_tfs=ismember(genes_w_exp,refTFs)
  T=table(genes_w_exp(ix_gv)',gene_var_sum(ix_gv)',(gene_var_infer_common(ix_gv)/max(gene_var_infer_common))',(gene_var_exp(ix_gv)/max(gene_var_exp))',gold_std_tfs(ix_gv)')
writetable(T,TF_vars_file,'Delimiter','\t')
