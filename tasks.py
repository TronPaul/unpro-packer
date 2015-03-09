import json, urllib, boto.sts, boto.vpc
from functools import partial
from invoke import run, task

UBUNTU_AMI_LIST_URL='http://cloud-images.ubuntu.com/releases/streams/v1/com.ubuntu.cloud:released:aws.json'


def match_type(root_store, virt, region, ami_def):
    return ami_def['root_store'] == root_store and ami_def['virt'] == virt and ami_def['crsn'] == region


def ubuntu_ami_base(region, version, arch, root_store, virt):
    product_name = 'com.ubuntu.cloud:server:{}:{}'.format(version, arch)
    product = json.load(urllib.urlopen(UBUNTU_AMI_LIST_URL))['products'][product_name]
    latest = product['versions'][sorted(product['versions'].keys(), reverse=True)[0]]
    return filter(partial(match_type, root_store, virt, region), latest['items'].values())[0]['id']


def aws_creds(owner):
    role_arn = "arn:aws:iam::{}:role/Packer".format(owner)
    sts = boto.sts.STSConnection()
    assumed_role = sts.assume_role(role_arn, 'unpro_packer', duration_seconds=1800)
    return assumed_role.credentials


def get_vpc(creds, cidr):
    vpc = boto.vpc.VPCConnection(aws_access_key_id=creds.access_key,
            aws_secret_access_key=creds.secret_key, security_token=creds.session_token)
    return vpc.get_all_vpcs(filters={'cidr':cidr, 'state':'available'})[0]


def get_subnet(creds, vpc_id, cidr):
    vpc = boto.vpc.VPCConnection(aws_access_key_id=creds.access_key,
            aws_secret_access_key=creds.secret_key, security_token=creds.session_token)
    return vpc.get_all_subnets(filters={'cidrBlock':[cidr], 'vpcId':vpc_id, 'state':'available'})[0]


def packer(creds, template, vars_=None):
    cmd = ['AWS_ACCESS_KEY_ID={}'.format(creds.access_key),
           'AWS_SECRET_KEY={}'.format(creds.secret_key), 
           'AWS_SECURITY_TOKEN={}'.format(creds.session_token),
           'packer',
           'build']
    if vars_ and len(vars_) > 0:
        for l in [['-var', '{}={}'.format(*i)] for i in vars_.items()]:
            cmd.extend(l)
    cmd.append(template)
    run(' '.join(cmd))


@task
def build(region='us-east-1', s3_bucket='unpro-ami', owner='767126526297', vpc_cidr='10.0.0.0/16', subnet_cidr='10.0.1.0/24'):
    source_ami = ubuntu_ami_base(region, '14.04', 'amd64', 'ebs', 'hvm')
    creds = aws_creds(owner)
    vpc_id = get_vpc(creds, vpc_cidr).id
    subnet_id = get_subnet(creds, vpc_id, subnet_cidr).id
    packer(creds, 'unpro-amazon-ubuntu-14.04-x64-ebs-hvm.json', {'region':region, 'source_ami':source_ami, 'vpc_id':vpc_id, 'subnet_id':subnet_id})
