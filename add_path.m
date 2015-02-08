% add toolbox path

directory = pwd;

path(path, directory)
path(path, strcat(directory, '/revision_protocols') )
path(path, strcat(directory, '/graphs') )
path(path, strcat(directory, '/dynamics') )