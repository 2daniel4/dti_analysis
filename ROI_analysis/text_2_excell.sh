#!/Users/amos/anaconda3/bin/python

# Pythono3 code to rename multiple
# files in a directory or folder

# importing os module
import os
import pandas as pd
#set working directory to where files are stored

os.chdir("/Volumes/DANIEL/dti_freesurf/diffusion_recons")

df_master = pd.DataFrame()
for subj in os.listdir("/Volumes/DANIEL/dti_freesurf/diffusion_recons/"):
    print(subj)
    os.chdir("/Volumes/DANIEL/dti_freesurf/diffusion_recons/{0}/mri/".format(subj))
    df=pd.read_table('lh.hippoSfVolumes-T1.long.v21.txt', delim_whitespace=True,names=['loacation','volume'])
    df=df.drop([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20])
    df['subj']=subj
    df_master=pd.concat([df_master,df])
#df_master=df.append(df,ignore_index = False)
    print(df_master)


os.chdir("/Volumes/DANIEL/dti_freesurf/")
df_master=df_master.sort_values(by=['subj'])
df_master.to_excel('lhipp_vol.xlsx','LeftHipp_Vol')

df_master = pd.DataFrame()
for subj in os.listdir("/Volumes/DANIEL/dti_freesurf/diffusion_recons/"):
    print(subj)
    os.chdir("/Volumes/DANIEL/dti_freesurf/diffusion_recons/{0}/mri/".format(subj))
    df=pd.read_table('rh.hippoSfVolumes-T1.long.v21.txt', delim_whitespace=True,names=['loacation','volume'])
    df=df.drop([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20])
    df['subj']=subj
    df_master=pd.concat([df_master,df])
#df_master=df.append(df,ignore_index = False)
    print(df_master)


os.chdir("/Volumes/DANIEL/dti_freesurf/")
df_master=df_master.sort_values(by=['subj'])
df_master.to_excel('rhipp_vol.xlsx','RightHipp_Vol')
