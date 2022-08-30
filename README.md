# Static Git Binaries

## What is this?

**Statically compiled** builds of [git](https://github.com/git/git/) for **64bit Linux.**\
(PRs for Windows build support are welcome!)

In other words, zero dependencies on system libs. Extract somewhere, add folder to your PATH and you're good to go!

Each repository git tag in this repo corresponds to its official corresponding release version of Git.

## Deployment

Simply extract the latest binaries from the latest release tag:

```bash
wget -c https://github.com/darkvertex/static-git/releases/latest/download/git-binaries.linux-64bit.tar.gz -O - | tar -xz
```

## FAQ

### What if I wanna compile it myself? Is it easy?

Yes!

1. Install Docker for Linux (or Docker Desktop for Windows but in Linux mode under WSL2.)
2. Grab a binary of [Earthly](https://earthly.dev)
3. `earthly +build --GIT_VERSION=2.37.3`
4. Look in `./dist` for the static binaries.

### Why not just install git from my OS package manager?

Sure, you can do that, assuming your OS packages have a recent enough build and you have sudo rights and a compiler toolchain already installed.

In my case my employer was using an old CentOS install that did not have modern versions, so I made this.

### git said `warning: templates not found` when I ran `git clone`, what gives?

This is because I am only bundling the binaries alone and nothing else.\
The "templates" in question are just [sample files](https://github.com/git/git/tree/master/templates) for hooks and such.

To silence the warning, you can make an empty folder and configure it as your template dir:

```bash
mkdir $HOME/.git-template
git config --global init.templatedir $HOME/.git-template
```

## Special Thanks

Special thanks to https://github.com/justcompile/git-static/ for the Linux build recipe.
