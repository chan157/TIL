# Git

> Git은 분산형버전관리시스템(DVCS)이다.
>
> 소스코드 형상 관리 도구로, 코드의 이력을 관리 할수 있다.

## Git 로컬 저장소 활용하기

> git은 `repository(저장소)`로 각각 프로젝트를 관리 한다.

### 0. 기본설정

Git에서 이력을 남기기 위해 작성자(author) 정보를 추가한다. 내 컴퓨터에서 최초로 한 번만 설정 하면 된다.

```bash
$ git config --global user.name {유저네임}
$ git config --global user.email {이메일}
```

* 일반적으로 `{유저네임}`, `{이메일}` 에서 github 정보를 넣는다.

```bash
$ git config --global -l
```

* 유저네임과 이름이 들어갔는지 확인할 수 있다.

```bash
$ git status
```

* 현재 상태를 알 수 있다.

```bash
student@M130326 MINGW64 ~/Desktop/TIL (master)
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        "Git\354\227\220 \353\214\200\355\225\264.md"
        images/
        "\353\247\210\355\201\254\353\213\244\354\232\264 \355\231\234\354\232\251\353\262\225.md"

nothing added to commit but untracked files present (use "git add" to track)

```

* 위와 같은 상태가 발생되면 commit 할 수 있도록 아래의 명령어를 시행한다.

```bash
$ git add .
```

* 현재 폴더에 있는 파일을 git에 올려준다.
* Commit이 된다.



### 1.저장소 생성

```bash
student@M130326 MINGW64 ~/Desktop/새 폴더
$ git init
Initialized empty Git repository in C:/Users/student/Desktop/새 폴더/.git/

student@M130326 MINGW64 ~/Desktop/새 폴더 (master)

```



### 2. add

> commit 대상 파일을 `staging area`으로 이동 시킨다.
>
> 즉, 이력을 남길 파일을담아 놓는 것이다.

`.` 은 현재 디렉토리(폴더)를 뜻한다.

```bash
$ git add .			## 디렉토리 전체
$ git add git.md    ## 특정 파일만 stage 
$ git add images/   ## 특정 폴더만 stage
```

항상 `git status`명령어를 통해 상태를 확인한다.

```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   "Git\354\227\220 \353\214\200\355\225\264.md"
        new file:   "images/\353\213\244\354\232\264\353\241\234\353\223\234.png"
        new file:   "\353\247\210\355\201\254\353\213\244\354\232\264 \355\231\234\354\232\251\353\262\225.md"
```



### 3.`commit`

* git에서 이력을 남기기 위해 이력을 남긴다.

```bash
$ git commit -m 'Git 기초'
[master (root-commit) e0760c3] Git 기초
 3 files changed, 143 insertions(+)
 create mode 100644 "Git\354\227\220 \353\214\200\355\225\264.md"
 create mode 100644 "images/\353\213\244\354\232\264\353\241\234\353\223\234.png"
 create mode 100644 "\353\247\210\355\201\254\353\213\244\354\232\264 \355\231\234\354\232\251\353\262\225.md"
```

* 이력을 확인하기 위해서는 `git log`를 활용한다.

```bash
$ git log
commit e0760c378b7cfc3f2f84b081b72546dc8602c337 (HEAD -> master)
Author: chan157 <chan157@naver.com>
Date:   Thu Dec 5 12:39:09 2019 +0900

    Git 기초
```



## Git 원격 저장소 활용하기

### 0. 기본 설정

> 원격 저장소를 생성한다. (예 - github)

### 1. 원격 저장소를 생성한다.

* `origin` 이라는 이름으로 해당 url을 원격 저장소로 등록

* 최초에 한번만 하면 된다.

```bash
$ git remote add origin https://github.com/chan157/TIL.git
```

```bash
$ git remote -v  ## 원격 저장소 목록 보기
origin  https://github.com/chan157/TIL.git (fetch)
origin  https://github.com/chan157/TIL.git (push)
```



## 2. 원격 저장소 push

* 앞으로 변경되는 사항이 있으면 항상 `add`, `commit`, `push`를 진행한다.

```bash
$ git push -u origin master

cEnumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 4 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 5.22 KiB | 2.61 MiB/s, done.
Total 6 (delta 0), reused 0 (delta 0)
To https://github.com/chan157/TIL.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.

```





