import os

#VERSION = open(os.path.join( os.path.dirname(__file__), 'version.txt.py'), 'r').read().rstrip()
VERSION = open(os.path.join( os.path.dirname(__file__) + "/..", 'version'), 'r').read().rstrip()
