import swift

from Initializer d
where
  d.getLocation().getFile().getBaseName() != "Package.swift" and
  exists(d.getLocation().getFile().getRelativePath())
select d
