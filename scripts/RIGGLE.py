#!/usr/bin/env python

from optparse import OptionParser
import pandas
import ndex
#sys.path.append('/Users/danielcarlin/projects/ndex-networkn')
#from networkn import NdexGraph
import networkx as nx
import itertools
import ndex.client as nc
import ndex.networkn as netn
import ndex.beta.toolbox as netb
import sys
import os
#dumb hack to get python to handle unicode
reload(sys)
sys.setdefaultencoding('utf8')
import subprocess

if __name__=='__main__':
    parser=OptionParser()
    parser.add_option("-s", "--study-name", dest="study_name", type='string', default="Unnamed_study")
    parser.add_option("-d", "--data", dest="train_data_file", action="store", type="string", default='/Users/danielcarlin/projects/regulator_RBM/test_data/all_data.tab',
                      help="File containining a samples (rows) by genes (columns), tab delimited data")
    parser.add_option("-r", "--regulators", dest="regulator_list_file", action="store", type="string", default=None, help="File containining a list of lists (in list_t format), first column is the list name, subsequent columns are genes associated with that list")
    parser.add_option("-m", "--cell-fate-map", dest="map", type='string', default='/Users/Dan/projects/ndex-progenitor-nets/output_nets/Novershtern_cell_map.txt')
    parser.add_option("-D", "--directory", dest="run_directory", type='string', default=None)
    parser.add_option("-M", "--sample-metadata", dest='metadata_file', type='string', default=None)
    parser.add_option("-R", "--reference-TF-file", dest="reference_file", type='string', default=None)
    (opts,args)=parser.parse_args()

    if not os.path.exists(opts.run_directory):
        subprocess.call(['mkdir '+opts.run_directory], shell=True)

    dir_path = os.path.dirname(os.path.realpath(__file__))
    sys.path.append(dir_path)

    print('Added path'+dir_path)

    if opts.regulator_list_file is not None:

        #here we run train the RBM
        subprocess.check_call([dir_path+'/theano_maskedRBM.py -d '+opts.train_data_file +' -r '+opts.regulator_list_file+' -o '+opts.run_directory+'/'+opts.study_name+'.tab'+' -m '+opts.run_directory+'/'+opts.study_name+'_connections.tab'],shell=True)
        regression_input=opts.run_directory+opts.study_name+'.tab'
    else:
        regression_input=opts.train_data_file


        #regression in MATLAB

    subprocess.call(['matlab -r \"addpath(\''+dir_path+'\'); \
    addpath(\''+dir_path+'/SPG_Multi_Graph\'); \
    addpath(\''+dir_path+'/SPG_singletask\'); \
    indata=\''+regression_input+'\'; \
    indesc=\''+opts.metadata_file+'\'; \
    devgraph=\''+opts.map+'\';\
    run_name=\''+opts.study_name+'\'; \
    output_path=\''+opts.run_directory+'\';\
    blank_GGFL;\
    pretrial_mat=\''+opts.run_directory+'/all_pretrial_'+opts.study_name+'.mat\'; \
    posttrial_mat=\''+opts.run_directory+'/'+opts.study_name+'_post_run.mat\'; \
    output_file=\''+opts.run_directory+'/'+opts.study_name+'_delta_betas.txt\'; \
    extract_full_regulators_matrix; \
    TF_vars_file=\''+opts.run_directory+'/'+opts.study_name+'_beta_vars.txt\'; \
    beta_variance_extraction; \
    quit;\"'],shell=True)
    
    if opts.reference_file is not None:
        subprocess.call(['matlab -r \"addpath(\''+dir_path+'\'); \
        pretrial_mat=\''+opts.run_directory+'/all_pretrial_'+opts.study_name+'.mat\'; \
        posttrial_mat=\''+opts.run_directory+'/'+opts.study_name+'_post_run.mat\'; \
        ref_file=\''+opts.reference_file+'\'; \
        figure_location=\''+opts.run_directory+'/figures\'; \
        regression_variance_cdf_geneset; \
        quit;\"'],shell=True)

