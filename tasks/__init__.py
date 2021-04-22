#!/usr/bin/env python
import contextlib
import os
import re
import tempfile

from invoke import Collection, task


@contextlib.contextmanager
def cd(path):
   old_path = os.getcwd()
   os.chdir(path)
   try:
       yield
   finally:
       os.chdir(old_path)

ns = Collection()


def parse_repos(filename: str) -> list[str]:
    with open(filename) as fh:
        projects = [ line for line in fh.readlines() if re.search(r'^\s*-', line) ]
    repos = []
    for project in projects:
        if matches := re.search(r'https://github.com/(?P<repo>RideReport/.*)\W', project):
            if repo := matches.group('repo'):
                repos.append(repo)
    return repos


def patch_dockerfile(filename, base_tag):
    with open(filename) as file:
        edited_lines = []
        for line in file.readlines():
            if re.search(r'^ARG base_tag=', line):
                edited_lines.append(f"ARG base_tag={base_tag}\n")
            else:
                edited_lines.append(line)
    with open(filename, 'w') as file:
        file.writelines(edited_lines)


@task
def update_repos(c, base_tag):
    repos = parse_repos('./README.md')
    with tempfile.TemporaryDirectory() as tmpdir:
        with cd(tmpdir):
            for repo in repos:
                c.run(f'gh repo clone {repo}')
                with cd(os.path.basename(repo)):
                    if not os.path.isfile("Dockerfile"):
                        continue

                    branch = c.run("date +%Y%m%d-%H%M%S", hide=True).stdout.strip() + "-base-image"
                    c.run(f"git checkout -b {branch}")
                    patch_dockerfile('Dockerfile', base_tag)

                    c.run("git commit -am 'Update Base Image'")
                    c.run(f"git push -u origin {branch}:{branch}")
                    c.run("gh pr create --title 'Base Docker Image Update' --body 'Latest Base Image'")
