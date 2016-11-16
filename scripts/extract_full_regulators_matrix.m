import bioma.data.*

%example input:
%pretrial_mat='results/Novershtern_results_TF1/all_pretrial_Novershtern_TF1.mat';
%posttrial_mat='results/Novershtern_results_TF1/Novershtern_TF1_post_run.mat';
%output_file='Novershtern_TF1_complete_betas.txt';

load(pretrial_mat)
load(posttrial_mat)

  beta_delta_matrix=[];
  colnames={};

for j=1:length(g{1})
  parent=g{1}(j);
  child=g{3}(j);
diff=progression_edge_difference(beta,parent,child,designRows);
beta_delta_matrix(:,j)=diff;

colnames(j)=strcat(parent,'_to_',child);
end

  rownames=genes;

%D=DataMatrix(beta_delta_matrix, rownames, colnames);
%dmwrite(D,output_file);

fid=fopen(output_file,'wt');
[rows,cols]=size(beta_delta_matrix);

%first,print the header

  fprintf(fid,'\t');
for i=1:cols-1
	fprintf(fid,'%s\t',colnames{i});
end
fprintf(fid,'%s\n',colnames{end});

for j=1:rows
	fprintf(fid,'%s\t',rownames{j});
  for i=1:cols-1
	  fprintf(fid,'%s\t',num2str(beta_delta_matrix(j,i)));
	  end
	  fprintf(fid,'%s\n',num2str(beta_delta_matrix(j,end)));
end

fclose(fid);


