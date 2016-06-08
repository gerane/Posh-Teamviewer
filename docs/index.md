# Posh-TeamViewer Docs

Posh-TeamViewer Documentation is using a combination of [PlatyPS](https://github.com/PowerShell/platyPS) and [ReadTheDocs](https://readthedocs.org/). This let's you right the command help once and it will create External Help, Github Markdown Help, and Help hosted on ReathTheDocs. 

- Help is written in Markdown in [the docs folder](https://github.com/gerane/Posh-Teamviewer/tree/Dev/docs) following a PlatyPS schema.
- It then gets exported into an External Help file [Posh-Teamviewer-help.xml](https://github.com/gerane/Posh-Teamviewer/blob/Dev/Posh-Teamviewer/en-US/Posh-Teamviewer-help.xml). 
- When committed, ReadTheDocs then uses the [mkdocs.yml](https://github.com/gerane/Posh-Teamviewer/blob/Dev/mkdoc.yml) file to build the Documentation based on the mkdoc.yml layout.