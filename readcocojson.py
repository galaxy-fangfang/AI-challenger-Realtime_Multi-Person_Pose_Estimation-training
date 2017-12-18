#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Author: fangfang

from __future__import print_function
import os
import argparse
import json
from PIL import Image

dataset = json.load(open('','r'))
print('annos', len(annos))