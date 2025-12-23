<p align="left">
  <img src="https://raw.githubusercontent.com/neutrinomuon/UpdateREADME/main/figures/Logo.jpeg" alt="UpdateREADME" width="120px">
</p>

### UpdateREADME

####  An action to update automatically README.md file
email: [antineutrinomuon@gmail.com](mailto:antineutrinomuon@gmail.com)

© Copyright ®

J.G. - Jean Gomes

last stable version: 0.0.4

RESUME: Automatically updates the README.md file with the latest version number and dynamically adds the directory structure section to your repository upon each new push. This workflow enhances project documentation by showcasing the directory structure in an automated and organized manner.

<hr>

![My Skills](https://skillicons.dev/icons?i=python,bash,numpy&theme=light)<br>

<hr>

#### <b>Example of yaml file</b>

<pre>
- name: Use custom action in update readme
  uses: 'neutrinomuon/UpdateREADME@vmain'  # Replace with the actual repository and version
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
├── version.txt
├── .github
│   ├── workflows
│   │   └── update-readme.yml
│   └── actions
│       └── update-readme
│           ├── entrypoint.sh
│           ├── action.yml
│           └── dockerfile
├── entrypoint.sh
├── action.yml
├── README.md
├── figures
│   ├── Education_black_background.png
│   ├── Logo.jpeg
│   ├── Education,_Studying,_University,_Alumni_-_icon.png
│   ├── PEP8-StyleGuide.jpg
│   ├── Education_black_background-removebg.png
│   └── Education_white_background.png
├── LICENSE.txt
├── .git
│   ├── logs
│   │   ├── HEAD
│   │   └── refs
│   │       ├── remotes
│   │       │   └── origin
│   │       │       └── main
│   │       └── heads
│   │           └── main
│   ├── config
│   ├── HEAD
│   ├── refs
│   │   ├── remotes
│   │   │   └── origin
│   │   │       └── main
│   │   ├── heads
│   │   │   └── main
│   │   └── tags
│   ├── config.worktree
│   ├── FETCH_HEAD
│   ├── description
│   ├── hooks
│   │   ├── sendemail-validate.sample
│   │   ├── pre-receive.sample
│   │   ├── fsmonitor-watchman.sample
│   │   ├── prepare-commit-msg.sample
│   │   ├── post-update.sample
│   │   ├── pre-rebase.sample
│   │   ├── push-to-checkout.sample
│   │   ├── pre-merge-commit.sample
│   │   ├── pre-applypatch.sample
│   │   ├── pre-commit.sample
│   │   ├── commit-msg.sample
│   │   ├── applypatch-msg.sample
│   │   ├── pre-push.sample
│   │   └── update.sample
│   ├── index
│   ├── objects
│   │   ├── ff
│   │   │   └── 1feab4a07d7737cc82553a08aa9a9d83cf861e
│   │   ├── bd
│   │   │   └── 4e6e0f03e94ebeac192bb72cd09a42d5692704
│   │   ├── fe
│   │   │   └── 75a5971829e02f8342b7b3d77f2ba41a830dbc
│   │   ├── eb
│   │   │   └── d887322949b1a74a459bae99cb816a34e94abd
│   │   ├── 7c
│   │   │   └── 3db650fe62519e9e00c9fbf588db1939f33a3f
│   │   ├── b6
│   │   │   └── 6607787c07b33ec570244059c8c20dc7a81459
│   │   ├── a5
│   │   │   └── 7eabd82582b9a9aa08541e88b4ff1d8b877a1a
│   │   ├── 1f
│   │   │   └── acfbac556f8e938d75ba6e53d8be00eb5c2ae6
│   │   ├── f8
│   │   │   └── 789c371e46e8af51885e87f5ae6c2cf5b12d51
│   │   ├── 81
│   │   │   └── 340c7e72d5c852585d0faea06985a720d4c2df
│   │   ├── 37
│   │   │   └── 4808bdd64b167c234345a05a8e94fb0a79cf31
│   │   ├── f3
│   │   │   └── 0a9bcff4c33f91bab0cf3d3cbd1803b7f8e8bd
│   │   ├── a6
│   │   │   └── 82eae88c50e0a470638e4eb838a742f84be58f
│   │   ├── 7a
│   │   │   └── 3eece57dd9b57a5f93f9fa8f05d256a8876d7b
│   │   ├── ed
│   │   │   └── 34b76a4b6e27bf7fdaf69f139bac8ddcd1875b
│   │   ├── pack
│   │   ├── 71
│   │   │   └── 5dde02a154e818b07a5c7f14604e55dbdd9d93
│   │   ├── 6b
│   │   │   └── 235cfec2aa3378fa28a0c3f0b53bf2799e0a33
│   │   ├── 35
│   │   │   └── 9b3b16f16801cb3d6c3651ed1f6d739bc43a9d
│   │   ├── 26
│   │   │   └── 3d8a4dffb34f50660aa473e6cfdca0388b7d53
│   │   ├── 0f
│   │   │   └── 8971bd9942a347ea402b0b5e5979b0405e1e30
│   │   ├── 3b
│   │   │   └── d3b5a80009b500e3e466ba237cbd6b49c60ec5
│   │   ├── info
│   │   ├── 24
│   │   │   └── 4c0ac7e25abaa36364c5b9b327a154b876f84b
│   │   └── e9
│   │       └── 4eb5fbc0001c367179c00bf7ad185e0d893127
│   ├── shallow
│   └── info
│       └── exclude
├── dockerfile
└── tree.out

44 directories (0 symlink), 67 files (0 symlink)
#################################################
Generated: treehue_colored @2025 - © Jean Gomes -
#################################################
</pre>

<hr>
