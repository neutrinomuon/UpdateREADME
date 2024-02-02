<p align="left">
  <img src="https://raw.githubusercontent.com/neutrinomuon/UpdateREADME/main/figures/Logo.jpeg" alt="UpdateREADME" width="120px">
</p>

### UpdateREADME

####  An action to update automatically README.md file
email: [antineutrinomuon@gmail.com](mailto:antineutrinomuon@gmail.com), [jean@astro.up.pt](mailto:jean@astro.up.pt)

© Copyright ®

J.G. - Jean Gomes

last stable version: 0.0.3

RESUME: Automatically updates the README.md file with the latest version number and dynamically adds the directory structure section to your repository upon each new push. This workflow enhances project documentation by showcasing the directory structure in an automated and organized manner.

<hr>

![My Skills](https://skillicons.dev/icons?i=python,bash,numpy&theme=light)<br>

<hr>

#### <b>Example of yaml file</b>

<pre>
- name: Use custom action in update readme
  uses: 'neutrinomuon/UpdateREADME@v0.0.3'  # Replace with the actual repository and version
  with:
    TOKEN: ${{ secrets.TOKENACTION }}
    BRANCH: ${{ env.BRANCH }}
    REPOSITORY: ${{ env.GITHUB_REPOSITORY }}
    LENGTH_LIMIT: 100000
    FILE: 'README.md'
    COMMIT_MESSAGE: 'Update README with new version'
</pre>

<hr>

#### <b>STRUCTURE of UpdateREADME</b>
<pre>
#################################################
workspace
├── entrypoint.sh
├── README.md
├── LICENSE.txt
├── dockerfile
├── version.txt
├── figures
│   ├── Education,_Studying,_University,_Alumni_-_icon.png
│   ├── Education_black_background.png
│   ├── Education_black_background-removebg.png
│   ├── PEP8-StyleGuide.jpg
│   ├── Education_white_background.png
│   └── Logo.jpeg
├── action.yml
├── .github
│   ├── actions
│   │   └── update-readme
│   │       ├── entrypoint.sh
│   │       ├── dockerfile
│   │       └── action.yml
│   └── workflows
│       └── update-readme.yml
└── .git
    ├── logs
    │   ├── HEAD
    │   └── refs
    │       ├── heads
    │       │   └── main
    │       └── remotes
    │           └── origin
    │               └── main
    ├── hooks
    │   ├── pre-commit.sample
    │   ├── pre-merge-commit.sample
    │   ├── commit-msg.sample
    │   ├── pre-push.sample
    │   ├── update.sample
    │   ├── sendemail-validate.sample
    │   ├── post-update.sample
    │   ├── fsmonitor-watchman.sample
    │   ├── applypatch-msg.sample
    │   ├── prepare-commit-msg.sample
    │   ├── pre-rebase.sample
    │   ├── pre-receive.sample
    │   ├── pre-applypatch.sample
    │   └── push-to-checkout.sample
    ├── config
    ├── shallow
    ├── info
    │   └── exclude
    ├── index
    ├── FETCH_HEAD
    ├── HEAD
    ├── description
    ├── objects
    │   ├── b6
    │   │   └── 6607787c07b33ec570244059c8c20dc7a81459
    │   ├── 35
    │   │   └── 9b3b16f16801cb3d6c3651ed1f6d739bc43a9d
    │   ├── a5
    │   │   └── 7eabd82582b9a9aa08541e88b4ff1d8b877a1a
    │   ├── fe
    │   │   └── 75a5971829e02f8342b7b3d77f2ba41a830dbc
    │   ├── 24
    │   │   └── 4c0ac7e25abaa36364c5b9b327a154b876f84b
    │   ├── 9b
    │   │   └── f137dfc2d6d33091c7b991135a58034ded7aeb
    │   ├── pack
    │   ├── c9
    │   │   └── f8a5162c53b5e56214534a80b19a7e846f3d12
    │   ├── info
    │   ├── a6
    │   │   └── 82eae88c50e0a470638e4eb838a742f84be58f
    │   ├── a0
    │   │   └── 3f5e5369566115996ec577e25be82f9467905a
    │   ├── ed
    │   │   └── 34b76a4b6e27bf7fdaf69f139bac8ddcd1875b
    │   ├── 71
    │   │   └── 5dde02a154e818b07a5c7f14604e55dbdd9d93
    │   ├── 33
    │   │   └── c0a8db6df6ab9b12f758f31ee83d50d6a1aff0
    │   ├── bc
    │   │   └── ab45af15a0f1b0166daf8cbf18b17cd8649277
    │   ├── 6b
    │   │   └── 235cfec2aa3378fa28a0c3f0b53bf2799e0a33
    │   ├── 26
    │   │   └── 3d8a4dffb34f50660aa473e6cfdca0388b7d53
    │   ├── f8
    │   │   └── 789c371e46e8af51885e87f5ae6c2cf5b12d51
    │   ├── 37
    │   │   ├── 4808bdd64b167c234345a05a8e94fb0a79cf31
    │   │   └── e1db7535a67ab57ddeb8ae7f5a73d176293e92
    │   ├── 0f
    │   │   └── 8971bd9942a347ea402b0b5e5979b0405e1e30
    │   ├── 49
    │   │   └── 1be850c2f05dcaea0c6691b890a0a0faa60c52
    │   ├── 1f
    │   │   └── acfbac556f8e938d75ba6e53d8be00eb5c2ae6
    │   └── 3b
    │       └── d3b5a80009b500e3e466ba237cbd6b49c60ec5
    ├── branches
    └── refs
        ├── tags
        ├── heads
        │   └── main
        └── remotes
            └── origin
                └── main

43 directories, 64 files
#################################################
Generated with tree_colored @ 2024 - © Jean Gomes
#################################################
</pre>

<hr>
