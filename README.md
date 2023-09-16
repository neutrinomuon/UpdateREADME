### TreeHue
email: [antineutrinomuon@gmail.com](mailto:antineutrinomuon@gmail.com), [jean@astro.up.pt](mailto:jean@astro.up.pt)

last stable version: 0.0.1

github repository: <a href='https://github.com/neutrinomuon/TreeHue/'>TreeHue</a>

© Copyright ®

J.G. - Jean Gomes

<hr>

<img src='https://img.shields.io/pypi/pyversions/TreeHue'>

<hr>

#### <b>RESUME</b>

<img src="https://raw.githubusercontent.com/neutrinomuon/TreeHue/main/figures/Kinematics.png" width=120>

Enhance your directory tree visualization with colorful representations using
TreeHue, a Python package that brings vibrancy to your file system structure.

<hr>

#### <b>INSTALLATION</b>

You can easily install <a href='https://pypi.org/project/TreeHue/'>TreeHue</a> by using pip - <a href='https://pypi.org/'>PyPI - The Python Package Index</a>:

<pre>
pip install TreeHue
</pre>

<br>or by using a generated conda repository <a href='https://anaconda.org/neutrinomuon/TreeHue'>https://anaconda.org/neutrinomuon/TreeHue</a>:

<img src='https://anaconda.org/neutrinomuon/TreeHue/badges/version.svg'><img src='https://anaconda.org/neutrinomuon/TreeHue/badges/latest_release_date.svg'><img src='https://anaconda.org/neutrinomuon/TreeHue/badges/platforms.svg'>

<pre>
conda install -c neutrinomuon TreeHue
</pre>

<br>OBS.: Linux, OS-X ad Windows pre-compilations available in conda.

You can also clone the repository and install by yourself in your machine:

<pre>
git clone https://github.com/neutrinomuon/TreeHue
python setup.py install
</pre>

<hr>

#### <b>EXAMPLE</b>

Example of the TreeHue script in python

<img src="https://github.com/neutrinomuon/TreeHue/blob/main/figures/TreeHue_Screenshot.png?raw=true" width="90%">

<hr>

#### <b>STRUCTURE OF TreeHue (Created with TreeHue)</b>

<pre>
#################################################
TreeHue
├── dist
│   ├── TreeHue-0.0.1.tar.gz
│   ├── TreeHue-0.0.1-py3.9.egg
│   └── TreeHue-0.0.1-py3-none-any.whl
├── TreeHue.egg-info
│   ├── PKG-INFO
│   ├── dependency_links.txt
│   ├── SOURCES.txt
│   ├── top_level.txt
│   └── requires.txt
├── README.md
├── __pycache__
│   ├── tree_colored.cpython-39.pyc
│   └── tree.cpython-39.pyc
├── .#README.md
├── showdown.min.js
├── index.html
├── setup.py
├── tutorial
├── src
│   └── python
│       ├── __pycache__
│       │   └── tree_colored.cpython-39.pyc
│       ├── __init__.py
│       ├── treehue_colored.py
│       ├── treehue.py
│       └── example.out
├── version.txt
├── build
│   ├── bdist.linux-x86_64
│   └── lib
│       └── TreeHue
│           ├── __init__.py
│           ├── treehue_colored.py
│           └── treehue.py
├── .git
│   ├── branches
│   ├── logs
│   │   ├── HEAD
│   │   └── refs
│   │       ├── heads
│   │       │   └── main
│   │       └── remotes
│   │           └── origin
│   │               └── HEAD
│   ├── info
│   │   └── exclude
│   ├── index
│   ├── description
│   ├── HEAD
│   ├── objects
│   │   ├── 8b
│   │   │   └── 137891791fe96927ad78e64b0aad7bded08bdc
│   │   ├── aa
│   │   │   └── 094d9f64a7cc9debc3bc069b28f8398a62508f
│   │   ├── 83
│   │   │   └── ddc65be8ce7833828d957d3adb596ce2de53d3
│   │   ├── 24
│   │   │   └── 383799794006af3df30e14637c3af0982646e1
│   │   ├── 64
│   │   │   └── 9a6878aabb7f4754b5853993f1f5bf5243b1a2
│   │   ├── 06
│   │   │   └── 2f0a725eb826092af3c852e85a06240424d4ec
│   │   ├── info
│   │   ├── 07
│   │   │   └── c3f5f5faa7fdad4bf958ac15c26a570b438adb
│   │   ├── 9c
│   │   │   └── 0a68a9eb3fc5031e002674ebb5eb5eebdfc05c
│   │   ├── 7c
│   │   │   └── 12216a5c0363479297b9867bd1965645dc5bfd
│   │   ├── 40
│   │   │   └── 704d7c8669642d1c6e0c4f27ada867fc30ac61
│   │   ├── a3
│   │   │   └── 324cd6fcac465a8709fb4a0cfb5b4b0a2cebfc
│   │   ├── 15
│   │   │   └── 7c608eb247858a35a0df37aacfffae501cf395
│   │   ├── e6
│   │   │   └── 9de29bb2d1d6434b8b29ae775ad8c2e48c5391
│   │   ├── 36
│   │   │   └── 9cb49e2ecaa1bd2671557810519965e7d0172d
│   │   ├── 4e
│   │   │   └── 37a649258081fa017c0891423ad23e09b77668
│   │   ├── f1
│   │   │   └── 233fe1a082ef10f448ff9d378fb59b2e79b981
│   │   ├── ea
│   │   │   ├── 0d5de6beed610ae74388992752f913326edcfe
│   │   │   └── 5d19a06b197473b6c7a22180e85b41fec3ea86
│   │   ├── f7
│   │   │   └── 7d9627dbfc4c1f91e171230c1343d319b26bb6
│   │   ├── c5
│   │   │   └── 30d3b504890de341def7f2ccb7c7247b27580b
│   │   ├── fd
│   │   │   └── db5a41258a96bd099b7f15881de301a4b70fb8
│   │   ├── d3
│   │   │   └── 1637f0e0bef1066586aad6f204d78ad4ad619d
│   │   ├── 8a
│   │   │   └── cdd82b765e8e0b8cd8787f7f18c7fe2ec52493
│   │   ├── 45
│   │   │   └── 589cdff346b7c87a28172ae74c6a05a2a6823b
│   │   ├── be
│   │   │   └── a47255004edf807004776da74aa043579bd38f
│   │   ├── ef
│   │   │   └── ca27bf89ae9760ba5ea627193c772e729d94a4
│   │   ├── 6e
│   │   │   └── ce4fff8c816f1699f59ab10ffcf23152a3aece
│   │   ├── 26
│   │   │   └── 26fbcc2f3a0d269aeac81ce3e221a61c882a78
│   │   ├── 68
│   │   │   └── 04f51885c9eddf8fa0800a575537a574566b47
│   │   ├── pack
│   │   │   ├── pack-24df12763f486654874481832fadef48402685fe.pack
│   │   │   ├── pack-24df12763f486654874481832fadef48402685fe.idx
│   │   │   └── pack-24df12763f486654874481832fadef48402685fe.rev
│   │   ├── d0
│   │   │   └── 3ad4e41ecb4545372e25e6bb667f89bc432346
│   │   └── 6a
│   │       └── 8c8380a0f2662255056a7ac849d0af69cae8d3
│   ├── packed-refs
│   ├── hooks
│   │   ├── update.sample
│   │   ├── pre-applypatch.sample
│   │   ├── pre-receive.sample
│   │   ├── pre-rebase.sample
│   │   ├── applypatch-msg.sample
│   │   ├── commit-msg.sample
│   │   ├── post-update.sample
│   │   ├── push-to-checkout.sample
│   │   ├── pre-push.sample
│   │   ├── fsmonitor-watchman.sample
│   │   ├── sendemail-validate.sample
│   │   ├── prepare-commit-msg.sample
│   │   ├── pre-commit.sample
│   │   └── pre-merge-commit.sample
│   ├── COMMIT_EDITMSG
│   ├── refs
│   │   ├── tags
│   │   ├── heads
│   │   │   └── main
│   │   └── remotes
│   │       └── origin
│   │           └── HEAD
│   └── config
└── figure

59 directories, 84 files
#################################################
Generated with tree_colored @ 2023 - © Jean Gomes
#################################################
</pre>

<hr>

#### <b>LICENSE</b>

Attribution-NonCommercial-NoDerivatives 4.0 (CC BY-NC-ND 4.0)

<img src="https://github.com/neutrinomuon/TreeHUe/blob/main/figures/cc_logo.png?raw=true" width="10%">

<a href='https://creativecommons.org/licenses/by-nc-nd/4.0/'>Creative Commons Attribution-NonCommercial-NoDerivs (CC-BY-NC-ND)</a>

