%run_name='Novershtern_TF1';
%input_path='/cellar/users/decarlin/projects/progenitor_inference/results/Novershtern_results_TF1'

%gamma_seq matches blank_GGFL
gamma_seq=[0,0.001,0.01,0.1,0.5,1,5,10]


load(sprintf('%s/all_pretrial_%s.mat',input_path,run_name))
load(sprintf('%s/%s_post_run.mat',input_path,run_name));

j=1                                                                                                                               
for gamma = gamma_seq
  load(sprintf('%s/%s_test_err_gamma_%.3f.mat',input_path,run_name,gamma))
  toplot_test_acc(j)=mean(acc);
toplot_std_acc(j)=std(acc);
  j=j+1;
end

j=1

h=figure;

  %plot(gamma_seq,toplot_test_acc)
 % plot(log(gamma_seq+1e-5), toplot_test_acc)
      hold on
  %     plot(log(gamma_seq+1e-5), toplot_test_acc_gene)
  %errorbar(gamma_seq, toplot_test_acc, toplot_std_acc)
  errorbar(log(gamma_seq+1e-5), toplot_test_acc,toplot_std_acc)
%errorbar(log(gamma_seq+1e-5), toplot_test_acc_gene,toplot_std_acc_gene)
  legend('TF regulons')

  set(gca,'XTickLabel',{' '})
  xlabel('Gamma [in logspace] (strength of development graph regularization)')
  %xlabel('Gamma')
  ylabel('XVal accuracy')

  plot_name=sprintf('%s/figures/regulon_accuracy_sweep',input_path)
  print(h,plot_name,'-dpng')
