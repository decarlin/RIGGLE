
posttrial_mat_1=''
psottrial_mat_2=''

load(posttrial_mat_1);

gene_var_1=var(beta');

load(posttrial_mat_2);

gene_var_2=var(beta');

fi=figure;
plot(gene_var_1,gene_var_2);
xlabel('TF Importance 1');
ylabel('TF Importance 2');
print(fi,strcat(figure_location,'TF_importance_comparison'),'-dpng');

ref_file=''
refFH=fopen(ref_file);
refTFs= textscan(refFH, '%s');
fclose(refFH);

refTFs=refTFs{1};

gene_var_prod=gene_var_1*gene_var_2

[h,p]=kstest2(gene_var_prod(ismember(genes,refTFs)),gene_var_prod(~ismember(genes,refTFs)),'Tail','smaller')

disp('Enrichment p-value of product of importance')
disp(p)
