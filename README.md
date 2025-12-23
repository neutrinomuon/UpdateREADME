<p align="left">
  <img src="https://raw.githubusercontent.com/neutrinomuon/UpdateREADME/main/figures/Logo.jpeg" alt="UpdateREADME" width="120px">
</p>

### UpdateREADME

####  An action to update automatically README.md file
email: [antineutrinomuon@gmail.com](mailto:antineutrinomuon@gmail.com)

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
├── .git
│   ├── HEAD
│   ├── shallow
│   ├── refs
│   │   ├── remotes
│   │   │   └── origin
│   │   │       └── main
│   │   ├── tags
│   │   └── heads
│   │       └── main
│   ├── index
│   ├── info
│   │   └── exclude
│   ├── hooks
│   │   ├── pre-push.sample
│   │   ├── pre-merge-commit.sample
│   │   ├── prepare-commit-msg.sample
│   │   ├── fsmonitor-watchman.sample
│   │   ├── push-to-checkout.sample
│   │   ├── pre-commit.sample
│   │   ├── post-update.sample
│   │   ├── update.sample
│   │   ├── pre-applypatch.sample
│   │   ├── sendemail-validate.sample
│   │   ├── commit-msg.sample
│   │   ├── pre-receive.sample
│   │   ├── pre-rebase.sample
│   │   └── applypatch-msg.sample
│   ├── logs
│   │   ├── HEAD
│   │   └── refs
│   │       ├── remotes
│   │       │   └── origin
│   │       │       └── main
│   │       └── heads
│   │           └── main
│   ├── objects
│   │   ├── 35
│   │   │   └── 9b3b16f16801cb3d6c3651ed1f6d739bc43a9d
│   │   ├── 63
│   │   │   └── 74f0bffeb2f5c83258123f8765f1553e44a735
│   │   ├── cf
│   │   │   └── 4067ea8975bc2f250ff7e1b51a7ded7f2f33ca
│   │   ├── f8
│   │   │   └── 789c371e46e8af51885e87f5ae6c2cf5b12d51
│   │   ├── 26
│   │   │   └── 3d8a4dffb34f50660aa473e6cfdca0388b7d53
│   │   ├── 33
│   │   │   └── 2b9f9cb2e1130091d7f120c78d32953c86c5fc
│   │   ├── 0f
│   │   │   └── 8971bd9942a347ea402b0b5e5979b0405e1e30
│   │   ├── pack
│   │   ├── 1f
│   │   │   └── acfbac556f8e938d75ba6e53d8be00eb5c2ae6
│   │   ├── 81
│   │   │   └── 355384737b29bb848689e0183fd6337e35f6e1
│   │   ├── b6
│   │   │   └── 6607787c07b33ec570244059c8c20dc7a81459
│   │   ├── 3b
│   │   │   └── d3b5a80009b500e3e466ba237cbd6b49c60ec5
│   │   ├── info
│   │   ├── fe
│   │   │   └── 75a5971829e02f8342b7b3d77f2ba41a830dbc
│   │   ├── 6b
│   │   │   └── 235cfec2aa3378fa28a0c3f0b53bf2799e0a33
│   │   ├── a5
│   │   │   └── 7eabd82582b9a9aa08541e88b4ff1d8b877a1a
│   │   ├── 65
│   │   │   └── 6d24ca1e89491c43bf7ec618909474c8ec669d
│   │   ├── 24
│   │   │   └── 4c0ac7e25abaa36364c5b9b327a154b876f84b
│   │   ├── 7c
│   │   │   └── 3db650fe62519e9e00c9fbf588db1939f33a3f
│   │   ├── ed
│   │   │   └── 34b76a4b6e27bf7fdaf69f139bac8ddcd1875b
│   │   ├── 71
│   │   │   └── 5dde02a154e818b07a5c7f14604e55dbdd9d93
│   │   ├── bc
│   │   │   └── ab45af15a0f1b0166daf8cbf18b17cd8649277
│   │   ├── f3
│   │   │   └── 2dd6014840c8f54144074f1c569e2717fe2b8c
│   │   ├── a6
│   │   │   └── 82eae88c50e0a470638e4eb838a742f84be58f
│   │   └── 37
│   │       └── 4808bdd64b167c234345a05a8e94fb0a79cf31
│   ├── config.worktree
│   ├── config
│   ├── description
│   └── FETCH_HEAD
├── .github
│   ├── workflows
│   │   └── update-readme.yml
│   └── actions
│       └── update-readme
│           ├── action.yml
│           ├── entrypoint.sh
│           └── dockerfile
├── action.yml
├── figures
│   ├── Logo.jpeg
│   ├── Education_black_background-removebg.png
│   ├── PEP8-StyleGuide.jpg
│   ├── Education_white_background.png
│   ├── Education_black_background.png
│   └── Education,_Studying,_University,_Alumni_-_icon.png
├── tree.out
├── version.txt
├── README.md
├── entrypoint.sh
├── LICENSE.txt
└── dockerfile

44 directories (0 symlink), 67 files (0 symlink)
#################################################
Generated: treehue_colored @2025 - © Jean Gomes -
#################################################
</pre>

<hr>
