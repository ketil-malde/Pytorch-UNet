#!/usr/bin/python3

# Script to wrap the U-Net model

import os
import pwd

IMAGENAME='pytorch-unet'

USERID=os.getuid()
GROUPID=os.getgid()
CWD=os.getcwd()
USERNAME=pwd.getpwuid(USERID).pw_name
RUNTIME='' # '--gpus device=0'

# print(USERID, GROUPID, USERNAME)

def docker_run(args=''):
    os.system(f'docker run {RUNTIME} --rm --user {USERID}:{GROUPID} -v {CWD}:/project -it {USERNAME}-{IMAGENAME} {args}')

def docker_build():
    os.system(f'docker build --build-arg user={USERNAME} --build-arg uid={USERID} --build-arg gid={GROUPID} -t {USERNAME}-{IMAGENAME} .')

class Model:

    def build(self):
        '''Build the docker container'''
        docker_build()

    def train(self):
        '''Train the network'''
        # if no initial weights: python3 /src/download_weights.py
        docker_run('python3 train.py')

    def check(self):
        '''Verify that data is in place and that the output doesn't exist'''
        pass

    def predict(self, target, output):
        '''Run a trained network on the data in target'''
        pass

    def test(self):
        '''Run tests'''
        docker_run('python3 /src/test.py')

    def status(self):
        '''Print the current training status'''
        # check if docker exists
        # check if network is trained (and validation accuracy?)
        # check if data is present for training
        # check if test data is present
        # check if test output is present (and report)
        pass

if __name__ == '__main__':
    import argparse
    import sys

    if sys.argv[1] == 'train':
        # p = argparse.ArgumentParser(description='Train Mask R-CNN')
        train()
    elif sys.argv[1] == 'test':
        test()
    elif sys.argv[1] == 'predict':
        predict()
    elif sys.argv[1] == 'check':
        check()
    elif sys.argv[1] == 'status':
        status()
    elif sys.argv[1] == 'build':
        docker_build()
    else:
        error('Usage: {sys.argv[0]} [check,status,train,predict] ...')
