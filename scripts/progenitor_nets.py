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
reload(sys)
sys.setdefaultencoding('utf8')

def select_top_n_in_column_by_magnitude(df,n=5):
    col_lib={}
    for j in list(df.columns.values):
        sl=df[j]
        abs_sl=sl.abs()
        abs_sl.sort(ascending=False)

        col_lib[j]=list(abs_sl.index)[:n]
        del abs_sl
    return col_lib

def build_development_map(col_lib,edge_delim='_to_',fh=open('cell_fate_map.txt','w')):
    for k in col_lib.keys():
        k.split(string=edge_delim)

def build_networks_from_dict_and_mat(net_dict,con_mat,fh_stem,cutoff=0.1):
    file_list=[]
    for k in net_dict.keys():
        file_name=fh_stem+k.replace(' ','_').replace('cell_type:_','').replace('/','_')+'.txt'
        file_list.append(file_name)
        fh=open(file_name, 'w')
        fh.write('regulator\ttarget\tstrength\n')
        for reg in net_dict[k]:
            conns=con_mat[reg][(con_mat[reg].abs()>cutoff)]
            for tar in list(conns.index):
                fh.write(reg+'\t'+tar+'\t'+str(conns[tar])+'\n')
        fh.close()
    return file_list

def id_dict_to_net(id_dict,ndex,file_name,source_target_split='_to_'):
    fh=open(file_name,'w')
    fh.write('parent\tchild\tndex:internalLink\n')
    for k in id_dict.keys():
        ndex.make_network_public(id_dict[k])
        k_split=k.replace('transition_network_','').replace('.txt','').split(source_target_split)
        source=k_split[0].replace('_',' ')
        target=k_split[1].replace('_',' ')
        fh.write(source+'\t'+target+'\t[[Access Pathway]('+id_dict[k]+')]\n')
    return file_name

if __name__=='__main__':
    parser=OptionParser()
    parser.add_option("-s", "--study-name", dest="study", type='string', default="Novershtern")
    parser.add_option("-m", "--cell-fate-map", dest="map", type='string', default='/Users/Dan/projects/ndex-progenitor-nets/output_nets/Novershtern_cell_map.txt')
    parser.add_option("-c","--connections", dest="connections", type='string', default='/Users/Dan/projects/ndex-progenitor-nets/input_data/Novershtern_TF1_connections.tab')
    parser.add_option("-b", "--betas", dest="betas", type='string', default='/Users/Dan/projects/ndex-progenitor-nets/input_data/Novershtern_TF1_complete_betas.txt' )
    parser.add_option("-n", "--network-name", dest="network_name", type='string', default='cell_fate_map')
    parser.add_option("-d", "--network-directory", dest="network_directory", type='string', default='/Users/Dan/projects/ndex-progenitor-nets/input_data/networks')
    (opts,args)=parser.parse_args()
    #load connections matrix

    connections_matrix = pandas.read_table(opts.connections,index_col=0)

    #load regulators matrix

    trns_regs= pandas.read_table(opts.betas,index_col=0)

    #select regulators

    top_regulators=select_top_n_in_column_by_magnitude(trns_regs)

    #build edge networks

    fh_stem=opts.network_directory+'transition_network_'
    files=build_networks_from_dict_and_mat(top_regulators, connections_matrix,fh_stem=fh_stem)

    #push edge network to NDEx

    uuids={}

    for f in files:
        net=netn.NdexGraph()
        netb.load(net,f,edge_attributes=['strength'],header=True)
        net_name=f.replace(opts.network_directory,'')
        net.set_name(net_name)
        uuids[net_name]=net.upload_to('http://public.ndexbio.org','decarlin','perfect6')
    

    #retrieve edge networks uuids
    ndex=nc.Ndex(host='http://public.ndexbio.org', username='decarlin', password='perfect6')
    id_dict={}

    for nn in uuids.keys():
        ndex.make_network_public(uuids[nn])
    

        #assign uuids to development edges

    cell_map_file=id_dict_to_net(uuids,ndex,file_name=opts.map)

    #push development network to NDEx

    net=netn.NdexGraph()
    netb.load(net,cell_map_file,edge_attributes=['ndex:internalLink'],header=True)
    net.set_name(opts.study+' cell lineage map')
    net.upload_to('http://public.ndexbio.org','decarlin','perfect6')
