# 0.0 ===================================== Setup =============================================================================================================
# 0.1 Working directory en file lijst ----
setwd("C:/Users/equii/OneDrive - NHL Stenden/Leerjaar 2/25-26 J2P4_BM Innovatieve Diagnostiek/Transcriptomics/Casus")
getwd()
list.files()

# 0.2 Packages installeren ----
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

packages <- c(
  "clusterProfiler",
  "org.Hs.eg.db",
  "enrichplot",
  "goseq",
  "Rsubread",
  "Rsamtools",
  "DESeq2",
  "KEGGREST",
  "EnhancedVolcano",
  "pathview"
)

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg)}}

# 0.3 Libraries laden ----
library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(goseq)
library(Rsubread)
library(Rsamtools)
library(DESeq2)
library(KEGGREST)
library(EnhancedVolcano)
library(pathview)

# 0.4 Controle ----
sessionInfo()

# 1.0 ===================================== Mapping =============================================================================================================
# 1.1 Working directory ----
setwd("C:/Users/equii/OneDrive - NHL Stenden/Leerjaar 2/25-26 J2P4_BM Innovatieve Diagnostiek/Transcriptomics/Casus")
getwd()

# 1.2 Packages ----
library(Rsubread)

# 1.3 Index ----
buildindex(
  basename = 'Casus_RA',
  reference = 'GCF_000001405.40_GRCh38.p14_genomic.fna',
  memory = 4000,
  indexSplit = TRUE)

# 1.4 Mapping ----
align.31.1_norm <- align(index = "Casus_RA", readfile1 = "SRR4785819_1_subset40k.fastq", readfile2 = "SRR4785819_2_subset40k.fastq", output_file = "31.1_norm.BAM")
align.15_norm <- align(index = "Casus_RA", readfile1 = "SRR4785820_1_subset40k.fastq", readfile2 = "SRR4785820_2_subset40k.fastq", output_file = "15_norm.BAM")
align.31.2_norm <- align(index = "Casus_RA", readfile1 = "SRR4785828_1_subset40k.fastq", readfile2 = "SRR4785828_2_subset40k.fastq", output_file = "31.2_norm.BAM")
align.42_norm <- align(index = "Casus_RA", readfile1 = "SRR4785831_1_subset40k.fastq", readfile2 = "SRR4785831_2_subset40k.fastq", output_file = "42_norm.BAM")
align.54_RA <- align(index = "Casus_RA", readfile1 = "SRR4785979_1_subset40k.fastq", readfile2 = "SRR4785979_2_subset40k.fastq", output_file = "54_RA.BAM")
align.66_RA <- align(index = "Casus_RA", readfile1 = "SRR4785980_1_subset40k.fastq", readfile2 = "SRR4785980_2_subset40k.fastq", output_file = "66_RA.BAM")
align.60_RA <- align(index = "Casus_RA", readfile1 = "SRR4785986_1_subset40k.fastq", readfile2 = "SRR4785986_2_subset40k.fastq", output_file = "60_RA.BAM")
align.59_RA <- align(index = "Casus_RA", readfile1 = "SRR4785988_1_subset40k.fastq", readfile2 = "SRR4785988_2_subset40k.fastq", output_file = "59_RA.BAM")

# 1.5 Gemapte reads visualiseren ----
library(Rsamtools)

# 1.6 Bestandsnamen van de monsters ----
samplesRA <- c('31.1_norm', '15_norm', '31.2_norm', '42_norm', '54_RA', '66_RA', '60_RA', '59_RA')

# 1.7 Sorteer BAM-bestanden ----
lapply(samplesRA, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))})

# 1.8 Indexeer de gesorteerde BAM-file ----
lapply(samplesRA, function(s) {indexBam(file = paste0(s, '.sorted.bam'))})

# 2.0 ===================================== Count matrix ========================================================================================================
# 2.1 Alle samples ----
AllsamplesRA <- c('31.1_norm.BAM', '15_norm.BAM', '31.2_norm.BAM', '42_norm.BAM', '54_RA.BAM', '66_RA.BAM', '60_RA.BAM', '59_RA.BAM')

count_matrix <- featureCounts(
  files = AllsamplesRA,
  annot.ext = "genomic.gtf",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE)

# 2.2 Matrix inzien ----
str(count_matrix)
counts <- count_matrix$counts
head(counts)
colnames(counts) <- c('31.1_norm', '15_norm', '31.2_norm', '42_norm', '54_RA', '66_RA', '60_RA', '59_RA')
head(counts)

# 2.3 Countmatrix opslaan ----
write.csv(counts, "CasusRA_countmatrix.csv", row.names = TRUE)

# 3.0 ===================================== Statistiek en analyse =====================================================================================================
# 3.1 DESeqDataSet ----
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = treatment_table,
                              design = ~ treatment)

# 3.2 Countmatrix Blackboard data ----
count_Matrix_BB <- read.table("count_matrix_RA.txt",
                              header = TRUE,
                              row.names = 1,
                              check.names = FALSE)
colnames(count_Matrix_BB) <- c('31.1_norm', '15_norm', '31.2_norm', '42_norm', '54_RA', '66_RA', '60_RA', '59_RA')

# 3.3 Metadata ----
treatment <- c("Normal", "Normal", "Normal", "Normal", "RA", "RA", "RA", "RA") 
treatment_table <- data.frame(treatment)
rownames(treatment_table) <- c('31.1_norm', '15_norm', '31.2_norm', '42_norm', '54_RA', '66_RA', '60_RA', '59_RA')
head(treatment_table, n=16)

# 3.4 DESeqDataSet ----
dds <- DESeqDataSetFromMatrix(countData = count_Matrix_BB,
                              colData = treatment_table,
                              design = ~ treatment)

# 3.5 Analyse ----
dds <- DESeq(dds)
resultaten <- results(dds)

# 3.6 Resultaat ----
write.csv(resultaten, file = 'ResultatenCasusRA.csv', row.names = TRUE)
head(resultaten)

sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

# 4.0 ===================================== Visualisatie ========================================================================================================
# 4.1 Volcano Plot ----
# De Volcano plot laat direct zien welke genen de sterkste up- of downregulatie hebben.
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj',
                title = 'Differential Expression: RA vs Normal',
                col = c('grey', 'lightblue', 'pink', 'purple'),
                colAlpha = 0.8)

# 4.2 Opslaan van de plot ----
# We slaan de plot op met een hoge resolutie (500 dpi) voor publicatiekwaliteit.
dev.copy(png, 'VolcanoplotRA.png', width = 8, height = 10, units = 'in', res = 500)
dev.off()

# 5.0 ===================================== Go analyse ========================================================================================================
# 5.1 Library ----
library(goseq)

# 5.2 Data Opschonen ----
# Vanwege de eerdere import-fouten extraheren we hier de schone SYMBOLS.
gene_names_clean <- sub(" .*", "", rownames(resultaten))
rownames(resultaten) <- gene_names_clean

# 5.3 Binaire vector maken ----
# 1 voor significante genen (padj < 0.05 en abs(LFC) > 1), 0 voor de rest.
all_genes <- rownames(resultaten)
sig_genes_names <- rownames(resultaten[which(resultaten$padj < 0.05 & abs(resultaten$log2FoldChange) > 1), ])
gene_vector <- as.integer(all_genes %in% sig_genes_names)
names(gene_vector) <- all_genes

# 5.4 PWF & Verrijking ----
# We berekenen de Probability Weighting Function (PWF) en daarna de GO-termen.
pwf <- nullp(gene_vector, "hg38", "geneSymbol")
enriched_GO <- goseq(pwf, "hg38", "geneSymbol")

# 5.5 Resultaten filteren en opslaan ----
# We behouden alleen termen met een p-waarde < 0.05.
top_enriched <- enriched_GO[enriched_GO$over_represented_pvalue < 0.05, ]
write.csv(top_enriched, "GO_Enrichment_RA.csv", row.names = TRUE)

# 6.0 ===================================== Pathway visualisatie (KEGG) ========================================================================================================
# 6.1 Library ----
library(pathview)
library(clusterProfiler)
library(org.Hs.eg.db)

# 6.2 ID Conversie ----
# KEGG werkt alleen met Entrez ID's, niet met Gene Symbols.
gene_conv <- bitr(rownames(resultaten), 
                  fromType = "SYMBOL", 
                  toType = "ENTREZID", 
                  OrgDb = org.Hs.eg.db)

# 6.3 Data Mapping ----
# We koppelen de log2FoldChange aan de Entrez ID's voor de inkleuring (rood/groen).
foldchanges <- resultaten$log2FoldChange
names(foldchanges) <- rownames(resultaten)
kegg_input <- foldchanges[gene_conv$SYMBOL]
names(kegg_input) <- gene_conv$ENTREZID

# 6.4 Genereer de Pathway Afbeelding ----
# Dit maakt een .png bestand aan in de werkmap voor de specifieke RA pathway (hsa05323).
pathview(gene.data  = kegg_input, 
         pathway.id = "hsa05323", 
         species    = "hsa")














