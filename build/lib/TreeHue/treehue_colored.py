#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul 22 13:26:49 2021

@author: jean
"""

# Import necessary libraries
from pathlib import Path
from itertools import islice
from colorama import Fore, Style  # Import colorama for colored output

import os
import numpy as np

# file_extensions_colors = {
#     '.py': Fore.RED,
#     '.pyx': Fore.BLUE,
#     '.f90': Fore.LIGHTMAGENTA_EX,
# }

space = '    '
branch = '│   '
tee = '├── '
last = '└── '

# Define a mapping of color strings to colorama color codes
color_mapping = {
    'Fore.BLACK': Fore.BLACK,
    'Fore.RED': Fore.RED,
    'Fore.GREEN': Fore.GREEN,
    'Fore.YELLOW': Fore.YELLOW,
    'Fore.BLUE': Fore.BLUE,
    'Fore.MAGENTA': Fore.MAGENTA,
    'Fore.CYAN': Fore.CYAN,
    'Fore.WHITE': Fore.WHITE,
    'Fore.LIGHTBLACK_EX': Fore.LIGHTBLACK_EX,
    'Fore.LIGHTRED_EX': Fore.LIGHTRED_EX,
    'Fore.LIGHTGREEN_EX': Fore.LIGHTGREEN_EX,
    'Fore.LIGHTYELLOW_EX': Fore.LIGHTYELLOW_EX,
    'Fore.LIGHTBLUE_EX': Fore.LIGHTBLUE_EX,
    'Fore.LIGHTMAGENTA_EX': Fore.LIGHTMAGENTA_EX,
    'Fore.LIGHTCYAN_EX': Fore.LIGHTCYAN_EX,
    'Fore.LIGHTWHITE_EX': Fore.LIGHTWHITE_EX,
}

def convert_color_string_or_keep_color(color):
    if isinstance(color, str):
        if color.startswith('Fore.'):
            try:
                # Look up the color code in the mapping
                color_code = color_mapping[color]
                #print(color_code)
                return color_code
            except KeyError:
                print(f"Error: Invalid color string '{color}'")
                return Fore.WHITE  # Default to white on error
        else:
            # It's already a color code string, return it as is
            return color
    else:
        return color  # If it's not a string, assume it's already a color code
    
def tree(dir_path: Path, level: int = -1, limit_to_directories: bool = False,
         length_limit: int = 1000, exclude_files: str = '', colors: dict = None, save_to_file: str = None, file_extensions_colors: dict = None):
    """Given a directory Path - Print a visual tree structure"""
    dir_path = Path(dir_path)  # Accept string coerceable to Path

    # Check if dir_path is '.' or './' and replace it with the current directory
    if dir_path == Path('.') or dir_path == Path('./'):
        dir_path = Path(os.getcwd())

    files = 0
    directories = 0

    if type(exclude_files) != list:
        if type(exclude_files) == str:
            exclude_files = [exclude_files]
        else:
            exclude_files = list(exclude_files)

    # Define colors based on user input or use default colors
    tree_dir_color    = colors.get('tree_dir', Fore.RED) if colors else Fore.RED
    main_dir_color    = colors.get('main', Fore.RED) if colors else Fore.RED
    dir_color         = colors.get('directory', Fore.BLUE) if colors else Fore.BLUE
    dir_symlink_color = colors.get('directory symlink', Fore.LIGHTCYAN_EX) if colors else Fore.LIGHTCYAN_EX
    file_color        = colors.get('file', Fore.GREEN) if colors else Fore.GREEN
    symlink_color     = colors.get('symlink', Fore.CYAN) if colors else Fore.CYAN
    out_stats         = colors.get('statistics', Fore.LIGHTYELLOW_EX) if colors else Fore.LIGHTYELLOW_EX
    out_code          = colors.get('code', Fore.LIGHTRED_EX) if colors else Fore.LIGHTRED_EX

    #print(file_extensions_colors)
    #for file_extension, color_string in file_extensions_colors.items():
    #    file_extension_color = convert_color_string_or_keep_color(color_string)
        #print(f"File Extension: {file_extension}, Color: {file_extension_color}{color_string}{Style.RESET_ALL}")
    #print('HERE:',file_extensions_colors)

    if file_extensions_colors is not None:
        for file_extension, color_string in file_extensions_colors.items():
            file_extensions_colors[file_extension] = convert_color_string_or_keep_color(color_string)
            #print(f"File Extension: {file_extension}, Color: {file_extensions_colors}{color_string}{Style.RESET_ALL}")
            #print(file_extensions_colors)
    
    def inner(dir_path: Path, prefix: str = '', level=-1):

        nonlocal files, directories

        if not level:
            return  # 0, stop iterating
        if limit_to_directories:
            contents = [d for d in dir_path.iterdir() if d.is_dir()]
        else:
            contents = list(dir_path.iterdir())

        contents_list = np.array(contents, dtype=str)

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
                indices.append(i_[0])

        if logical == True and np.size(indices) > 0:
            indices = np.array(indices, dtype=int)
            contents_aux = []
            for i_ in indices:
                contents_aux.append(contents[i_])
            contents = contents_aux

        # print( dir_path )
        # print( contents )
        # print( contents_list )

        pointers = [tee] * (len(contents) - 1) + [last]
        lines = [] if save_to_file is not None else None
        
        for pointer, path in zip(pointers, contents):
            if path.is_dir():
                if path.is_symlink():
                    yield tree_dir_color + prefix + pointer + dir_symlink_color + path.name + Style.RESET_ALL
                    lines.append(tree_dir_color + prefix + pointer + dir_symlink_color + path.name + Style.RESET_ALL) if save_to_file is not None else None
                else:
                    yield tree_dir_color + prefix + pointer + dir_color + path.name + Style.RESET_ALL
                    lines.append(tree_dir_color + prefix + pointer + dir_color + path.name + Style.RESET_ALL) if save_to_file is not None else None
                directories += 1
                extension = branch if pointer == tee else space
                yield from inner(path, prefix=prefix + extension, level=level - 1)
                lines.extend(inner(path, prefix=prefix + extension, level=level - 1)) if save_to_file is not None else None
            elif not limit_to_directories:
                file_extension =  path.suffix.lower()
                if path.is_symlink():  # Check if it's a symbolic link
                    yield tree_dir_color + prefix + pointer + symlink_color + path.name + Style.RESET_ALL
                    lines.append(tree_dir_color + prefix + pointer + symlink_color + path.name + Style.RESET_ALL) if save_to_file is not None else None

                elif file_extensions_colors and file_extension in file_extensions_colors:
                    file_extension_color = file_extensions_colors[file_extension]
                    yield tree_dir_color + prefix + pointer + file_extension_color + path.name + Style.RESET_ALL
                    lines.append(tree_dir_color + prefix + pointer + file_extension_color + path.name + Style.RESET_ALL) if save_to_file is not None else None
                #elif path.suffix == '.py':
                #    yield tree_dir_color + prefix + pointer + Fore.LIGHTYELLOW_EX + path.name + Style.RESET_ALL
                #    lines.append(tree_dir_color + prefix + pointer + Fore.LIGHTYELLOW_EX + path.name + Style.RESET_ALL) if save_to_file is not None else None

                else:
                    yield tree_dir_color + prefix + pointer + file_color + path.name + Style.RESET_ALL
                    lines.append(tree_dir_color + prefix + pointer + file_color + path.name + Style.RESET_ALL) if save_to_file is not None else None
                files += 1

        # Save structure of your package to file
        if save_to_file is not None:
            if isinstance(save_to_file, str):
                with open(save_to_file, 'w', encoding='utf-8') as file:
                    file.write(Fore.LIGHTRED_EX + f'#################################################\n' + Style.RESET_ALL)                    
                    file.write(Fore.RED + dir_path.name + Style.RESET_ALL + '\n')
                    file.writelines([line + '\n' for line in lines])
                    if directories + files > length_limit:
                        file.write(f'... length_limit, {length_limit}, reached, counted:\n')
                    file.write(Fore.YELLOW + f'\n{directories} directories' + (f', {files} files' if files else '') + '\n' + Style.RESET_ALL)
                    file.write(Fore.LIGHTRED_EX + f'#################################################\n' + Style.RESET_ALL)
                    file.write(Fore.LIGHTRED_EX + f'Generated with tree_colored @ 2023 - © Jean Gomes\n' + Style.RESET_ALL)
                    file.write(Fore.LIGHTRED_EX + f'#################################################\n' + Style.RESET_ALL)
                    
    # Print the directory name specified by dir_path
    #print("Directory Name:", dir_path.name)
    print(out_code + '#################################################' + Style.RESET_ALL)    
    print(out_code + dir_path.name + Style.RESET_ALL)

    iterator = inner(dir_path, level=level)
    for line in islice(iterator, length_limit):
        print(line)
    if next(iterator, None):
        print(f'... length_limit, {length_limit}, reached, counted:')
    print(out_stats + f'\n{directories} directories' + (f', {files} files' if files else '') + Style.RESET_ALL)
    print(out_code  + '#################################################' + Style.RESET_ALL)    
    print(out_code  + 'Generated with tree_colored @ 2023 - © Jean Gomes' + Style.RESET_ALL)
    print(out_code  + '#################################################' + Style.RESET_ALL)
    #print("TEST", exclude_files)
