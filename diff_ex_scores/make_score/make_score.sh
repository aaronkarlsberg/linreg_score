. /u/local/Modules/default/init/modules.sh
module load R/3.6.0
module load plink/1.90b3.45


export PATH=$PATH:/u/home/a/akarlsbe/scratch/ANIL/TWAS/fusion_twas-master/

ls *.RDat | awk -F ".wgt.RDat" '{print $1}' | awk -F "anypards_" '{print $2}' > weight_generated_genes.txt

while read line
do

# gene_name=$(echo ${line} | awk -F ',' '{print $1}')

gene_name=$line

BFILE="../bfiles_count/${gene_name}_GSAMD.secondld.pruned.anypards"

SCORE_FILE="${gene_name}.score"

OUT="${gene_name}.plink"

Rscript /u/home/a/akarlsbe/scratch/ANIL/TWAS/fusion_twas-master/utils/make_score.R "/u/home/a/akarlsbe/scratch/ANIL/TWAS/anypards_genotype_data/plinks_by_gene/WEIGHTS/anypards_${gene_name}.wgt.RDat" > "${gene_name}.score"

plink --bfile $BFILE --score $SCORE_FILE 1 2 4 --out $OUT

done<weight_generated_genes.txt



# qsub -cwd -V -N make_score -l h_data=16G,highp,time=24:00:00 make_score.sh

