from pathlib import Path
from itertools import islice

import numpy as np

space =  '    '
branch = '│   '
tee =    '├── '
last =   '└── '

def tree(dir_path: Path, level: int=-1, limit_to_directories: bool=False,
         length_limit: int=1000, exclude_files: str=''):
    """Given a directory Path object print a visual tree structure"""
    dir_path = Path(dir_path) # accept string coerceable to Path
    files = 0
    directories = 0
    
    if type(exclude_files) != list:
        if type(exclude_files) == str:
            exclude_files = [ exclude_files ]
        else:
            exclude_files = list(exclude_files)
        
    def inner(dir_path: Path, prefix: str='', level=-1):

        nonlocal files, directories

        #print(dir_path)

        if not level: 
            return # 0, stop iterating
        if limit_to_directories:
            contents = [d for d in dir_path.iterdir() if d.is_dir()]
        else: 
            contents = list(dir_path.iterdir())
            
        contents_list = np.array(contents, dtype=str)
        #print(contents_list)
        logical = False
        indices = []
        for i_ in enumerate(contents_list):
            logical_aux = False
            for k_ in exclude_files:
                
                l = k_ in i_[1]
                
                if l == True:
                    logical_aux = True 
                
            if logical_aux == True:
                logical = True
            else:
                indices.append( i_[0] )
        
        if logical == True and np.size(indices) > 0:
            indices = np.array(indices, dtype=int)
            contents_aux = []
            for i_ in indices:
                contents_aux.append( contents[ i_ ] )
            contents = contents_aux
            #print(contents)
            #print("logical",logical)
            
        pointers = [tee] * (len(contents) - 1) + [last]
        for pointer, path in zip(pointers, contents):
            if path.is_dir():
                yield prefix + pointer + path.name
                directories += 1
                extension = branch if pointer == tee else space 
                yield from inner(path, prefix=prefix+extension, level=level-1)
            elif not limit_to_directories:
                yield prefix + pointer + path.name
                files += 1
             
    print(dir_path.name)
    iterator = inner(dir_path, level=level)
    #print(iterator)
    for line in islice(iterator, length_limit):
        
        print(line)
        
        # logical = False
        # for k in exclude_files:
        #     b = k in line
        #     if b:
        #         logical=True
        # #print(b)
        
        # if logical==False:
        #     #print("line",b, line)
        #     print(line)
        # #else:
        # #    print(b,line)
    if next(iterator, None):
        print(f'... length_limit, {length_limit}, reached, counted:')
    print(f'\n{directories} directories' + (f', {files} files' if files else ''))

    print("TEST",exclude_files)
            
