function condalist -d 'List conda environments.'
  for dir in (ls $HOME/miniconda3/envs)
    echo $dir
  end
end
