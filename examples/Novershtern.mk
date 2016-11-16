$RBM_HOME='/cellar/users/decarlin/projects/DomainRegulation'
$MATLAB_HOME='/cellar/users/decarlin/projects/progenitor_inference'

Novershtern_TF1: Novershtern_TF1_RBM Novershtern_regression  Novershtern_significance_test Novershtern_extract_regulators

Nov_TF1_master_table:
	join.pl /cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/figures/TF_table_raw.txt /cellar/users/decarlin/projects/TF_collections/TF1_target_count.txt \
	| join.pl - /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/top_regulators_table.tab \
	> /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/master_table.txt

Nov_post_rbm:
	../scripts/post_rbm_analysis.py -d /cellar/data/Novershtern/data_standard_t.tab \
	-r /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/Novershtern_TF1.tab \
	-w /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/Novershtern_TF1_connections.tab \
	-c /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/Expression_inferered_corr.tab \
	-n /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/null_corr.tab \
	-t /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1/top_regulators_table.tab;

Novershtern_expression_only_controls:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	indata='/cellar/data/Novershtern/Novershtern_TF1expression_maxmin.tab'; \
	indesc='/cellar/data/Novershtern/sample_descriptions.txt'; \
	devgraph='/cellar/data/Novershtern/cell_type_graph.sif';\
	run_name='Novershtern_TF1_TFexpOnly'; \
	output_path='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern';\
	blank_GGFL;\
	quit;"

Novershtern_exp_only_significance_test:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1expression.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1expression_post_run.mat'; \
	ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt'; \
	figure_location='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/figures/exp_controls'; \
	regression_variance_boxplot_geneset; \
	quit;"

Novershtern_extract_betas:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/all_pretrial_Novershtern_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/Novershtern_TF1_post_run.mat'; \
	TF_vars_file='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/TF_beta_vars.txt'; \
	beta_variance_extraction; \
	quit;"

Novershtern_significance_test:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1/Novershtern_TF1_post_run.mat'; \
	ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt'; \
	figure_location='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/figures/'; \
	regression_variance_boxplot_geneset; \
	quit;"

Novershtern_push_ndex: Novershtern_regression
	python /cellar/users/decarlin/projects/ndex-progenitor-nets/progenitor_nets.py \
	-s Novershtern \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-c /cellar/users/decarlin/projects/RIGGLE/results/rbm_output/Novershtern_TF1_connections.tab \
	-b /cellar/users/decarlin/projects/RIGGLE/results/Novershtern_TF1_complete_betas.txt \
	-n Novershtern_cell_fate_map \
	-d /cellar/users/decarlin/projects/RIGGLE/results/Novershtern/nets

Novershtern_extract_regulators: Novershtern_regression
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/all_pretrial_Novershtern_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/Novershtern_TF1_post_run.mat'; \
	output_file='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/Novershtern_TF1_complete_betas.txt'; \
	extract_full_regulators_matrix; \
	quit;"

Novershtern_regression:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	indata='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern/rbm_output/Novershtern_TF1.tab'; \
	indesc='/cellar/data/Novershtern/sample_descriptions.txt'; \
	devgraph='/cellar/data/Novershtern/cell_type_graph.sif';\
	run_name='Novershtern_TF1'; \
	output_path='/cellar/users/decarlin/projects/RIGGLE/results/Novershtern';\
	blank_GGFL;\
	quit;"

#Novershtern_TF1_post: Novershtern_TF1_RBM
#	/cellar/users/decarlin/projects/DomainRegulation/post_rbm_analysis.py -d /Users/danielcarlin/Data/Novershtern/data_standard_t.tab -r rbm_output/Novershtern_TF1.tab -c post_rbm_corr/Novershtern_TF1_corr.tab -n post_rbm_corr/Novershtern_TF1_null.tab

Novershtern_TF1_RBM:
	/cellar/users/decarlin/projects/DomainRegulation/theano_maskedRBM.py \
	-d /cellar/data/Novershtern/data_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5.list_t \
	-o /cellar/users/decarlin/projects/RIGGLE/results/Novershtern/rbm_output/Novershtern_TF1.tab \
	-m /cellar/users/decarlin/projects/RIGGLE/results/Novershtern/rbm_output/Novershtern_TF1_connections.tab
