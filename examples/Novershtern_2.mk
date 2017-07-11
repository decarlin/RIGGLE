Nov_TF3_noMirs:
	../scripts/RIGGLE.py \
        -l 0.01 \
        -s Novershtern_TF3_noMirs \
        -d /cellar/users/decarlin/Data/Novershtern/data_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_3_regulatory_noMirs_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF3_noMirs \
	-m /cellar/users/decarlin/Data/Novershtern/cell_type_graph.sif \
        -M /cellar/users/decarlin/Data/Novershtern/sample_descriptions.txt \
        -R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemopoiesis_go.txt

Nov_TF2_self_loops_filter20:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Novershtern_TF2_filter20 \
	-d /cellar/users/decarlin/Data/Novershtern/data_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_2_regulatory_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF2_self_loops_filter20 \
	-m /cellar/users/decarlin/Data/Novershtern/cell_type_graph.sif \
	-M /cellar/users/decarlin/Data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

Nov_TF2:
	../scripts/RIGGLE.py \
	-l 0.01 \
	-s Novershtern_TF2 \
	-d /cellar/users/decarlin/Data/Novershtern/data_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_2_regulatory_filtlered5_selfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF2 \
	-m /cellar/users/decarlin/Data/Novershtern/cell_type_graph.sif \
	-M /cellar/users/decarlin/Data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

Nov:
	../scripts/RIGGLE.py \
	-s Novershtern_TF1_1 \
	-d /cellar/data/Novershtern/data_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5_withSelfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1 \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-M /cellar/data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

Nov_pdfs:
	../scripts/plot_pdfs.py \
	-d /cellar/users/decarlin/projects/RIGGLE_results/NovershternExpNorm_TF1/NovershternExpNorm_TF1_beta_vars.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt \
	-o /cellar/users/decarlin/projects/RIGGLE_results/NovershternExpNorm_TF1/NovershternExpNorm_violin.png

Nov_noRBM:
	../scripts/RIGGLE.py \
	-s Novershtern_TF1_1 \
	-d /cellar/data/Novershtern/data_standard_t.tab \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1 \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-M /cellar/data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

NovExpNorm_TF1_1:
	../scripts/RIGGLE.py \
	-s NovershternExpNorm_TF1_1 \
	-d /cellar/data/Novershtern/exp_norm_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5_withSelfLoops.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/NovershternExpNorm_TF1_1 \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-M /cellar/data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

NovExpNorm_TF1:
	../scripts/RIGGLE.py \
	-s NovershternExpNorm_TF1 \
	-d /cellar/data/Novershtern/exp_norm_standard_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/NovershternExpNorm_TF1 \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-M /cellar/data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

NovExpNorm_TF1_noRBM:
	../scripts/RIGGLE.py \
	-s NovershternExpNorm_TF1 \
	-d /cellar/data/Novershtern/exp_norm_standard_t.tab \
	-D /cellar/users/decarlin/projects/RIGGLE_results/NovershternExpNorm_TF1 \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-M /cellar/data/Novershtern/sample_descriptions.txt \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt

Nov_TF1_withExp_noRBM:
	../scripts/RIGGLE.py \
	-s Novershtern_TF1_withExp \
	-d /cellar/users/decarlin/projects/RIGGLE_results/Nov_cat_TF1_expr/data.tab \
	-D /cellar/users/decarlin/projects/RIGGLE_results/Nov_cat_TF1_expr/ \
	-m /cellar/data/Novershtern/cell_type_graph.sif \
	-M /cellar/data/Novershtern/sample_descriptions.txt \

Nov_1_1_sig:
	matlab -r "addpath('/cellar/users/decarlin/projects/progenitor_inference'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1/all_pretrial_Novershtern_TF1_1.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1/Novershtern_TF1_1_post_run.mat'; \
	ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt'; \
	figure_location='/cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1/figures/'; \
	regression_variance_cdf_geneset; \
	quit;"

Nov_1_1_pdf:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1/all_pretrial_Novershtern_TF1_1.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1/Novershtern_TF1_1_post_run.mat'; \
	ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/hemo_tfs.txt'; \
	figure_location='/cellar/users/decarlin/projects/RIGGLE_results/Novershtern_TF1_1/figures/'; \
	regression_variance_ksdensity_geneset; \
	quit;"

QKF:
	../scripts/RIGGLE.py \
	-s QKF_TF1 \
	-d /cellar/users/decarlin/projects/QKF_joint/data/data_centered_scaled_hugo_t.tab \
	-r /cellar/users/decarlin/projects/TF_collections/TF_collection_1_regulatory_filtlered5.list_t \
	-D /cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1 \
	-m /cellar/users/decarlin/projects/QKF_joint/data/scimitar_output_graph.sif \
	-M /cellar/users/decarlin/projects/QKF_joint/data/metastable_graph_20_states_memberships.csv \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/neural_tfs.txt

QKF_sig:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1/all_pretrial_QKF_TF1.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1/QKF_TF1_post_run.mat'; \
	ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/neural_tfs.txt'; \
	figure_location='/cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1/figures/'; \
	regression_variance_pdf_geneset; \
	quit;"

QKF_expression:
	../scripts/RIGGLE.py \
	-s QKF_TF1_expression \
	-d /cellar/users/decarlin/projects/QKF_joint/data/data_centered_scaled_hugo_t.tab \
	-D /cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1_expression/ \
	-m /cellar/users/decarlin/projects/QKF_joint/data/scimitar_output_graph.sif \
	-M /cellar/users/decarlin/projects/QKF_joint/data/metastable_graph_20_states_memberships.csv \
	-R /cellar/users/decarlin/projects/progenitor_inference/reference_genesets/neural_tfs.txt

QKF_expression_sig:
	matlab -r "addpath('/cellar/users/decarlin/projects/RIGGLE/scripts'); \
	pretrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1_expression/all_pretrial_QKF_TF1_expression.mat'; \
	posttrial_mat='/cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1_expression/QKF_TF1_expression_post_run.mat'; \
	ref_file='/cellar/users/decarlin/projects/progenitor_inference/reference_genesets/neural_tfs.txt'; \
	figure_location='/cellar/users/decarlin/projects/RIGGLE_results/QKF_TF1_expression/figures/'; \
	regression_variance_pdf_geneset; \
	quit;"
