#!/usr/bin/bash

WorkDir=/media/peng/data/02_radiomics/chenquan/new3
RawPath=$WorkDir/results
TargetPath=$WorkDir/radiomics


sublist=($(ls $RawPath));
# sublist='sub_001';

for sub in ${sublist[@]};
# for sub in ${sublist};  
do   
    mkdir -p ${TargetPath}/image ${TargetPath}/mask ${TargetPath}/mask_bak;

    cd ${TargetPath};
    cp ${RawPath}/${sub}/*label.nii.gz ${TargetPath}/mask_bak/${sub}.nii.gz;
    cp ${RawPath}/${sub}/nnunet/*_0002.nii.gz ${TargetPath}/image/${sub}.nii.gz;

    if [ ! -f ${TargetPath}/mask_bak/${sub}.nii.gz ]; then
        echo "No mask file for ${sub}";
        continue;
    fi    
    if [ ! -f ${TargetPath}/image/${sub}.nii.gz ]; then
        echo "No image file for ${sub}";
        continue;
    fi


    # extract mask
    # 1. edema
    # ${FSLDIR}/bin/fslmaths ${TargetPath}/mask_bak/${sub}.nii.gz -thr 1 -uthr 1 -bin ${TargetPath}/mask_bak/${sub}_1.nii.gz;
    # 2. peritumoral
    # ${FSLDIR}/bin/fslmaths ${TargetPath}/mask_bak/${sub}.nii.gz -thr 2 -uthr 2 -bin ${TargetPath}/mask_bak/${sub}_2.nii.gz;
    # 3. core
    ${FSLDIR}/bin/fslmaths ${TargetPath}/mask_bak/${sub}.nii.gz -thr 3 -uthr 3 -bin ${TargetPath}/mask_bak/${sub}_3.nii.gz;
    # ${FSLDIR}/bin/fslmaths ${TargetPath}/mask_bak/${sub}.nii.gz -thr 1 -uthr 3 -bin ${TargetPath}/mask_bak/${sub}_4.nii.gz;
    # ${FSLDIR}/bin/fslmaths ${TargetPath}/mask_bak/${sub}.nii.gz -thr 2 -uthr 3 -bin ${TargetPath}/mask_bak/${sub}_5.nii.gz;


    # mv to mask dir
    # mv ${TargetPath}/mask_bak/${sub}_1.nii.gz ${TargetPath}/mask/${sub}.nii.gz; 
    # mv ${TargetPath}/mask_bak/${sub}_2.nii.gz ${TargetPath}/mask/${sub}.nii.gz;
    mv ${TargetPath}/mask_bak/${sub}_3.nii.gz ${TargetPath}/mask/${sub}.nii.gz; 
    # mv ${TargetPath}/mask_bak/${sub}_4.nii.gz ${TargetPath}/mask/${sub}.nii.gz; 
    # mv ${TargetPath}/mask_bak/${sub}_5.nii.gz ${TargetPath}/mask/${sub}.nii.gz; 

done