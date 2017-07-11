$RBM_HOME='/cellar/users/decarlin/projects/DomainRegulation'
$MATLAB_HOME='/cellar/users/decarlin/projects/progenitor_inference'

Benitez_TF3_noMirs_combined:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Benitez_TF3_noMirs_combined \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_3_regulatory_noMirs_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF3_noMirs_combined \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.sif \
	-M /cellar/users/decarlin/Data/Benitez/cell_type.tab \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/pancreas_combined.txt

Benitez_TF2_combined:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Benitez_TF2_combined \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_2_regulatory_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_combined \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.sif \
	-M /cellar/users/decarlin/Data/Benitez/cell_type.tab \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/pancreas_combined.txt

Benitez_TF2_GO:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Benitez_TF2_GO \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_2_regulatory_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_GO \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.sif \
	-M /cellar/users/decarlin/Data/Benitez/cell_type.tab \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/pancreas_development_go.txt

Benitez_TF2_selfLoops_class_betas:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops/all_pretrial_Benitez_TF2_selfLoops.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_test_post_run.mat'; \
	output_file='/cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_complete_betas.txt'; \
	extract_full_regulators_by_class_matrix; \
	quit;"

Benitez_TF2_selfLoops_push_ndex_0.4_filter:
	python /cellar/users/decarlin/projects/ndex-progenitor-nets/progenitor_nets.py \
	-s Benitez_TF2_selfLoops \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.txt \
	-c ~/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_connections.tab \
	-b ~/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_delta_betas.txt \
	-n Benitez_TF2_withLoops_cell_fate_map \
	-d /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops/networks_filter_0.4/ \
	-C 0.4

Benitez_TF2_selfLoops_push_ndex_0.2_filter:
	python /cellar/users/decarlin/projects/ndex-progenitor-nets/progenitor_nets.py \
	-s Benitez_TF2_selfLoops \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.txt \
	-c ~/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_connections.tab \
	-b ~/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_delta_betas.txt \
	-n Benitez_TF2_withLoops_cell_fate_map \
	-d /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops/networks_filter_0.2/ \
	-C 0.2

Benitez_TF2_selfLoops_push_ndex:
	python /cellar/users/decarlin/projects/ndex-progenitor-nets/progenitor_nets.py \
	-s Benitez_TF2_selfLoops \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.txt \
	-c ~/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_connections.tab \
	-b ~/projects/RIGGLE_results/Benitez_TF2_selfLoops/Benitez_TF2_selfLoops_delta_betas.txt \
	-n Benitez_TF2_withLoops_cell_fate_map \
	-d /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops/networks/

Benitez_TF2_selfLoops:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Benitez_TF2_selfLoops \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_2_regulatory_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Benitez_TF2_selfLoops \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.sif \
	-M /cellar/users/decarlin/Data/Benitez/cell_type.tab \
	-R /cellar/users/decarlin/Data/Benitez/pancreas_tfs.txt \

Benitez_TF2:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Benitez_TF2 \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_2_regulatory_filtlered5.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Benitez_tf2 \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.sif \
	-M /cellar/users/decarlin/Data/Benitez/cell_type.tab \
	-R /cellar/users/decarlin/Data/Benitez/pancreas_tfs.txt \

Benitez_PDX1_experiment:
	../scripts/RIGGLE.py \
	-s Benitez_PDX1 \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5_withPDX1supp.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Benitez_PDX1 \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.sif \
	-M /cellar/users/decarlin/Data/Benitez/cell_type.tab \
	-R /cellar/users/decarlin/Data/Benitez/pancreas_tfs.txt

Benitez_TF1: Benitez_TF1_post Benitez_TF1_regression  Benitez_significance_test Benitez_extract_regulators

Ben_TF1_master_table:
	join.pl /cellar/users/decarlin/Data/Benitez/results_TF1/TF_table_raw_infer_only.txt /cellar/users/decarlin/projects/TF_collections/TF1_target_count.txt \
	| join.pl - /cellar/users/decarlin/Data/Benitez/results_TF1/top_regulators_table.tab \
	> /cellar/users/decarlin/Data/Benitez/results_TF1/master_table.tab

Ben_post_rbm:
	../scripts/post_rbm_analysis.py -d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/Data/Benitez/rbm_output/Benitez_TF1.tab \
	-w /cellar/users/decarlin/Data/Benitez/rbm_output/Benitez_TF1_connections.tab \
	-c /cellar/users/decarlin/Data/Benitez/results_TF1/Expression_inferered_corr.tab \
	-n /cellar/users/decarlin/Data/Benitez/results_TF1/null_corr.tab \
	-t /cellar/users/decarlin/Data/Benitez/results_TF1/top_regulators_table.tab;

Benitez_expression_only_controls:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	indata='/cellar/users/decarlin/Data/Benitez/TFonly_exp_data_max_min_hugo_t.tab'; \
	indesc='/cellar/users/decarlin/Data/Benitez/cell_type.tab'; \
	devgraph='/cellar/users/decarlin/Data/Benitez/cell_fate_map.sif';\
	run_name='Benitez_TF1_TFexpOnly'; \
	output_path='/cellar/users/decarlin/Data/Benitez/results_TF1';\
	blank_GGFL;\
	quit;"

Benitez_exp_only_significance_test:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1_TFexpOnly.mat'; \
	posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_TFexpOnly_post_run.mat'; \
	ref_file='/cellar/users/decarlin/Data/Benitez/pancreas_tfs.txt'; \
	figure_location='/cellar/users/decarlin/Data/Benitez/results_TF1/figures/exp_controls/'; \
	regression_variance_boxplot_geneset; \
	quit;"

Benitez_extract_betas:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_post_run.mat'; \
	TF_vars_file='/cellar/users/decarlin/Data/Benitez/results_TF1/TF_beta_vars.txt'; \
	beta_variance_extraction; \
	quit;"

Benitez_significance_test:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_post_run.mat'; \
	ref_file='/cellar/users/decarlin/Data/Benitez/pancreas_tfs.txt'; \
	figure_location='/cellar/users/decarlin/Data/Benitez/results_TF1/figures/'; \
	regression_variance_boxplot_geneset; \
	quit;"

Benitez_pdf:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_post_run.mat'; \
	ref_file='/cellar/users/decarlin/Data/Benitez/pancreas_tfs.txt'; \
	figure_location='/cellar/users/decarlin/Data/Benitez/results_TF1/figures/'; \
	regression_variance_ksdensity_geneset; \
	quit;"

Benitez_push_ndex: Benitez_regression
	python /cellar/users/decarlin/projects/ndex-progenitor-nets/progenitor_nets.py \
	-s Benitez \
	-m /cellar/users/decarlin/Data/Benitez/cell_fate_map.txt \
	-c ~/Data/Benitez/rbm_output/Benitez_TF1_connections.tab \
	-b ~/Data/Benitez/results_TF1/Benitez_TF1_complete_betas.txt \
	-n Benitez_cell_fate_map \
	-d /cellar/users/decarlin/Data/Benitez/results_TF1/

Benitez_plot_regression_sweep: Benitez_regression
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	input_path='/cellar/users/decarlin/Data/Benitez/results_TF1'; \
	run_name='Benitez_TF1'; \
	plot_accuracy_blank; \
	quit;"

Benitez_extract_regulators: Benitez_regression
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	pretrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/all_pretrial_Benitez_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_post_run.mat'; \
	output_file='/cellar/users/decarlin/Data/Benitez/results_TF1/Benitez_TF1_complete_betas.txt'; \
	extract_full_regulators_matrix; \
	quit;"

Benitez_regression:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	indata='/cellar/users/decarlin/Data/Benitez/rbm_output/Benitez_TF1.tab'; \
	indesc='/cellar/users/decarlin/Data/Benitez/cell_type.tab'; \
	devgraph='/cellar/users/decarlin/Data/Benitez/cell_fate_map.sif';\
	run_name='Benitez_TF1'; \
	output_path='/cellar/users/decarlin/Data/Benitez/results_TF1';\
	blank_GGFL;\
	quit;"

Benitez_TF1_post: Benitez_TF1_RBM
	/cellar/users/decarlin/projects/DomainRegulation/post_rbm_analysis.py -d /Users/danielcarlin/Data/Benitez/data_standard_t.tab -r rbm_output/Benitez_TF1.tab -c post_rbm_corr/Benitez_TF1_corr.tab -n post_rbm_corr/Benitez_TF1_null.tab

Benitez_TF1_RBM:
	/cellar/users/decarlin/projects/DomainRegulation/theano_maskedRBM.py \
	-d /cellar/users/decarlin/Data/Benitez/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5.list_t \
	-o /cellar/users/decarlin/Data/Benitez/rbm_output/Benitez_TF1.tab \
	-m /cellar/users/decarlin/Data/Benitez/rbm_output/Benitez_TF1_connections.tab
