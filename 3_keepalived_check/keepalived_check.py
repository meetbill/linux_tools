#!/usr/bin/python
#coding=utf8
"""
# Author: Bill
# Created Time : 2016年05月28日 星期六 12时22分00秒

# File Name: keepalived_check.py
# Description:

"""
import os, sys, re
import glob
import optparse
version = "0.1.0"

def_conf_path = '/etc/keepalived/keepalived.conf'

regex_confline = re.compile(r'''^(?P<param>[^!#]+)(.*)$''', flags=re.IGNORECASE)
regex_include = re.compile(r'''^\s*include\s+(?P<path>[^\s]+).*$''', flags=re.IGNORECASE)
# config regex
regex_vrid = re.compile(r'''^\s*virtual_router_id\s+(?P<vrid>\d+).*$''', flags=re.IGNORECASE)
regex_vip = re.compile(r'''^\s*(?P<vip>(\d{1,3}\.){3}\d{1,3}).*$''', flags=re.IGNORECASE)
regex_vs = re.compile(r'''^\s*virtual_server\s+(?P<vip>(\d{1,3}\.){3}\d{1,3})\s+(?P<port>\d+).*$''', flags=re.IGNORECASE)


def read_config(path=""):
    '''
    read_config read configs with support include stetement,
    and remove comments or blank lines.
    returns:
        list of tupple(parameter, filename:index)
    '''
    conf_dir = os.path.dirname(path)

    try:
        config = list()
        num = 0
        for line in open(path):
            num += 1
            m = regex_confline.match(line)
            if m is None :
                continue
            ### parse
            param = m.group('param').rstrip()
            m_include = regex_include.match(param)
            if m_include :
                include_path = m_include.group('path')
                for p in glob.glob('/'.join([conf_dir, include_path])):
                    config.extend(read_config(p))
            else :
                index = "%s:%i" % (path, num)
                config.append((param, index))

        return config
    except:
        raise IOError("conffile '%s' not found" % path)

def parse_config(config=[]):
    vrids = list()
    vips = list()
    virtual_servers = list()

    for line, index in config:
        # vrid
        m = regex_vrid.match(line)
        if m :
            vrids.append((m.group('vrid'), index))
            continue
        # virtual_server
        m = regex_vs.match(line)
        if m :
            virtual_servers.append(((m.group('vip'),m.group('port')), index))
            continue
        # vip
        m = regex_vip.match(line)
        if m :
            vips.append((m.group('vip'), index))
            continue

    return vrids, vips, virtual_servers


def check_vrids(vrids):
    dups = __check_vrids_dup(vrids)
    return len(dups) == 0

def __check_vrids_dup(vrids):
    vrid_list = list( map(lambda x: x[0], vrids) )
    unique_list = list(set( map(lambda x: x[0], vrids) ))

    for ele in unique_list:
        vrid_list.remove(ele)

    if len(vrid_list) > 0 :
        print("'virtual_router_id' duplications found:")
        for ele in vrid_list:
            print("\t" + ele)
            for vrid, index in vrids:
                if vrid == ele :
                    print("\t\t- %s" % index)
        print
    return vrid_list



def check_vips(vips, virtual_servers):
    dups_vip = __check_vips_dup(vips)
    dups_vs = __check_vs_dup(virtual_servers)
    ng_vips = __check_vips_unmanaged(vips, virtual_servers)
    if (len(dups_vip) + len(dups_vs) + len(ng_vips)) == 0 :
        return True
    else:
        return False

def __check_vips_dup(vips):
    vip_list = map(lambda x: x[0], vips)
    unique_list = list(set(vip_list))

    for ele in unique_list:
        vip_list.remove(ele)

    if len(vip_list) > 0 :
        print("'virtual_ipaddress' duplications found:")
        for ele in vip_list:
            print("\t" + ele)
            for vip, index in vips:
                if vip == ele :
                    print("\t\t- %s" % index)
        print

    return vip_list

def __check_vs_dup(virtual_servers):
    vs_list = map(lambda x: x[0], virtual_servers)
    unique_list = list(set(vs_list))

    for ele in unique_list:
        vs_list.remove(ele)

    if len(vs_list) > 0 :
        print("'virtual_server' duplications found:")
        for ele in vs_list:
            print("\t" + ':'.join(ele))
            for vs, index in virtual_servers:
                if vs == ele :
                    print("\t\t- %s" % index)
        print

    return vs_list


def __check_vips_unmanaged(vips, virtual_servers):
    managed_list = map(lambda x: x[0], vips)
    unmanaged_list = list()

    for (vip, port) in map(lambda x: x[0], virtual_servers):
        if vip not in managed_list :
            unmanaged_list.append((vip, port))

    if len(unmanaged_list) > 0 :
        print("'virtual_server' uses unmanaged VIP:")
        for ele in unmanaged_list:
            print("\t" + ':'.join(ele))
            for vs, index in virtual_servers:
                if vs == ele :
                    print("\t\t- %s" % index)
        print

    return unmanaged_list



if __name__ == "__main__":
    import optparse
    usage = """usage: %prog [options]"""

    parser = optparse.OptionParser(usage=usage, version=version)
    parser.add_option(
        "-f", "--file",
        action="store",
        dest="conf_path",
        default=def_conf_path,
        help="set keepalived config file path. (default:%s)" % def_conf_path
    )
    (options, args) = parser.parse_args()
    if len(args) != 0 :
        parser.print_help()
        sys.exit(3)

    config = read_config(options.conf_path)
    vrids, vips, virtual_servers = parse_config(config)

    ret = 0
    if check_vrids(vrids) != True :
        ret = 1
    if check_vips(vips, virtual_servers) != True :
        ret = 1

    if ret == 0 :
        print("OK")
    sys.exit(ret)
