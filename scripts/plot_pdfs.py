#!/usr/bin/env python

import seaborn as sns
import csv
import pandas
from optparse import OptionParser
import numpy as np
import matplotlib.pyplot as plt

def experimental_control_pdfs(df,list_of_exp, filename='plot.png',ylabel='Transcription Factor Importance'):

    df['Transcription Factor'] = pandas.Series(np.full(len(df),False), index=df.index)

    for l in list(df.index):
        if l in list_of_exp:
            df['Transcription Factor'][l]='Implicated from Prior Knowledge'
        else:
            df['Transcription Factor'][l]='Other TFs'

    g=sns.violinplot(x='Transcription Factor', y=df.columns[0], hue='Transcription Factor', data=df, split=True)
    g.get_figure()
    g.set_yscale('log')
    g.set(ylabel='Transcription Factor Importance')
    fig=g.get_figure()
    fig.savefig(filename)

if __name__ == '__main__':
    #parse input options
    parser = OptionParser()

    #files like /cellar/users/decarlin/projects/RIGGLE/results/Novershtern/Novershtern_beta_vars.txt
    parser.add_option("-d", "--data", dest="train_data_file", action="store", type="string", default=None, help="File containining regression coefficients (rows) by cell types (columns)")
    parser.add_option("-R", "--reference-TF-file", dest="reference_file", type='string', default=None)
    parser.add_option("-o", "--output-file", dest="out", type='string', default=None)

    (opts, args) = parser.parse_args()

    train_set_x_full_df = pandas.read_table(opts.train_data_file,index_col=0) 

    with open(opts.reference_file) as f:
        lines = f.read().splitlines()
    
    experimental_control_pdfs(train_set_x_full_df, lines, filename=opts.out)
