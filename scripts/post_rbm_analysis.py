#!/usr/bin/env python

__author__ = 'danielcarlin'
import pandas
import scipy.stats
import numpy.random
from optparse import OptionParser
from theano_maskedRBM import makeMatricesAgree
import operator
from math import fabs

def corr_matrices(data_in,rbm_out,spearman=True):
    """Take two matrices and return the correlation of their corresponding columns. Defaults to Spearman."""
    entities_x=list(data_in.columns.values)[1:]
    sample_names=list(data_in[data_in.columns[0]])

    entities_out=list(rbm_out.columns.values)[1:]
    out_names=list(rbm_out[rbm_out.columns[0]])

    [m1,m2,entities_agree]=makeMatricesAgree(rbm_out,entities_out,data_in,entities_x)

    spr={}
    null_model={}

    for i in xrange(m1.shape[1]):
        if spearman:
            spr[i]=scipy.stats.spearmanr(m1[:,i],m2[:,i])
            null_model[i]=scipy.stats.spearmanr(m1[:,i],m2[:,numpy.random.randint(low=0,high=m2.shape[1])])
        else:
            spr[i]=scipy.stats.pearsonr(m1[:,i],m2[:,i])
            null_model[i]=scipy.stats.pearsonr(m1[:,i],m2[:,numpy.random.randint(low=0,high=m2.shape[1])])

    return spr,entities_agree, null_model

def write_regulators_table(rbm_w,table_file='targets_table.txt',giveN=5):
    """Outputs a table of top N targets for each TF"""

    fh=open(table_file,'w')

    for tf in list(rbm_w.columns.values)[1:]:
        targets=list(rbm_w.loc[rbm_w[tf] !=0][rbm_w.columns[0]])
        weights=list(rbm_w.loc[rbm_w[tf] !=0][tf])
        to_sort=zip(targets,weights)
        sorted_values = sorted(to_sort, key=lambda target:fabs(target[1]),reverse=True)
        sorted_targets=[l[0] for l in sorted_values[0:giveN]]
        sorted_weights=[str(l[1]) for l in sorted_values[0:giveN]]
        fh.write(tf+'\t'+','.join(sorted_targets)+'\t'+','.join(sorted_weights)+'\n')

if __name__ == '__main__':
    parser = OptionParser()
    parser.add_option("-d", "--data", dest="train_data_file", action="store", type="string", default='/Users/danielcarlin/projects/regulator_RBM/test_data/all_data.tab',
                      help="File containining a samples (rows) by genes (columns), tab delimited data")
    parser.add_option('-r', "--rbm-output", dest="rbm_output_file", action="store", type="string", default='output.txt',help ="output file of hidden layer probabilities")
    parser.add_option('-w',"--rbm-weights",dest="rbm_weights_file",action="store",type="string",default=None,help="weights composing the hidden layer ofr the RBM")
    parser.add_option('-c', "--correlation-file", dest="corr_file", action='store', type='string', default=None, help="file for correlation between expression and regulon")
    parser.add_option('-n', "--null-model", dest="null_file", action='store', type='string', default=None, help="file for null model output")
    parser.add_option('-p', "--pearson", dest="pearson", action='store_true', default=False, help="Pearson rather than Spearman correlation")
    parser.add_option('-t','--target-table', dest="target_table",default=None, help="table for learned targets")

    (opts, args) = parser.parse_args()

    data_in = pandas.read_table(opts.train_data_file)
    rbm_out = pandas.read_table(opts.rbm_output_file)

    if opts.pearson:
        spr,ent,nm=corr_matrices(data_in,rbm_out,spearman=False)
    else:
        spr,ent,nm=corr_matrices(data_in,rbm_out)

    fh=open(opts.corr_file,'w')

    for k in spr.keys():
        fh.write(ent[k]+'\t'+str(spr[k][0])+'\t'+str(spr[k][1])+'\n')

    fh.close()

    fh2=open(opts.null_file,'w')

    for k in spr.keys():
        fh2.write(ent[k]+'\t'+str(nm[k][0])+'\t'+str(nm[k][1])+'\n')

    fh2.close()
    
    if opts.target_table is not None:
        rbm_w = pandas.read_table(opts.rbm_weights_file)
        write_regulators_table(rbm_w,table_file=opts.target_table,giveN=5)
