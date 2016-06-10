# Posh-TeamViewer Docs

Posh-TeamViewer Documentation is using a combination of [PlatyPS](https://github.com/PowerShell/platyPS) and [ReadTheDocs](https://readthedocs.org/). This let's you right the command help once and it will create External Help, Github Markdown Help, and Help hosted on ReadTheDocs. 

- Help is written in Markdown in [the docs folder](https://github.com/gerane/Posh-Teamviewer/tree/Dev/docs) following a PlatyPS schema.
- It then gets exported into an External Help file [Posh-Teamviewer-help.xml](https://github.com/gerane/Posh-Teamviewer/blob/Dev/Posh-Teamviewer/en-US/Posh-Teamviewer-help.xml). 
- When committed, ReadTheDocs then uses the [mkdocs.yml](https://github.com/gerane/Posh-Teamviewer/blob/Dev/mkdocs.yml) file to build the Documentation based on the mkdocs.yml layout.

## Contributing to Documentation

If you find any corrections, typos or would like to contribute to the Documentation, you can do the following:

- Clone the [Posh-Teamviewer Repo](https://github.com/gerane/Posh-Teamviewer)
- Edit the Documentation Markdown in the [the docs folder](https://github.com/gerane/Posh-Teamviewer/tree/Dev/docs)
- The structure of the Help Markdown Files is described in the [mkdocs.yml](https://github.com/gerane/Posh-Teamviewer/blob/Dev/mkdocs.yml)
- Commit changes and submit a Pull Request.
