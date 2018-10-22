#!/usr/bin/env python

path =r'/user/cloudera/2pd/data' # use your path
allFiles = glob.glob(os.path.join(path, "*.csv"))
frame = pd.DataFrame()
list_ = []
for file_ in allFiles:
    df = pd.concat((pd.read_csv(f) for f in all_files))
    list_.append(df)
frame = pd.concat(list_)

for line in 