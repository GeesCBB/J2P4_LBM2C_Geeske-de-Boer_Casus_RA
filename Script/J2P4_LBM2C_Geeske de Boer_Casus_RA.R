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
  "pathview",
  "viridis",   
  "stringr",
  "ggplot2"
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
library(viridis)
library(stringr)
library(ggplot2)

# 0.4 Controle ----
sessionInfo()

# 0.5 Kleurenpallete ----
# Basiskleuren
col_neutral <- "grey90"
col_up      <- "purple"
col_down    <- "hotpink"

# Statistische categorieën
stat_colors <- c(
  "grey30",  # niet significant
  "hotpink", # log2FC
  "plum3",   # p-value
  "purple"   # beide
)

# Expressie
expr_colors <- c(
  down = col_down,
  mid  = col_neutral,
  up   = col_up
)

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
# 3.1 Metadata ---- 
treatment <- c("Normal", "Normal", "Normal", "Normal", "RA", "RA", "RA", "RA") 
treatment_table <- data.frame(treatment)
rownames(treatment_table) <- c('31.1_norm', '15_norm', '31.2_norm', '42_norm', '54_RA', '66_RA', '60_RA', '59_RA')
head(treatment_table, n=16)

# 3.2 Countmatrix Blackboard data ----
count_Matrix_BB <- read.table("count_matrix_RA.txt",
                              header = TRUE,
                              row.names = 1,
                              check.names = FALSE)
colnames(count_Matrix_BB) <- c('31.1_norm', '15_norm', '31.2_norm', '42_norm', '54_RA', '66_RA', '60_RA', '59_RA')

# 3.3 DESeqDataSet ----
dds <- DESeqDataSetFromMatrix(countData = count_Matrix_BB,
                              colData = treatment_table,
                              design = ~ treatment)

# 3.4 Analyse ----
dds <- DESeq(dds)
resultaten <- results(dds)

# 3.5 Resultaat ----
write.csv(resultaten, file = 'ResultatenCasusRA.csv', row.names = TRUE)
head(resultaten)

sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

# 4.0 ===================================== PCA ========================================================================================================
# 4.1 PCA plot maken ----
colData(dds)$Group <- factor(colData(dds)$treatment)

vsd <- vst(dds, blind = FALSE)

pcaData <- plotPCA(vsd, intgroup = "Group", returnData = TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))

pca_plot <- ggplot(pcaData, aes(PC1, PC2, color = Group)) +
  geom_point(size = 4, alpha = 0.8) +
  scale_color_manual(values = c(
    "Normal" = col_neutral,   
    "RA"     = col_up         
  )) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  ggtitle("PCA van genexpressie (RA vs Normal)") +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.title = element_text(face = "bold")
  )

print(pca_plot)

# 4.2 PCA Opslaan (Consistent met plot hierboven)
ggsave("PCA_RA_Resultaat.png", 
       plot = pca_plot, 
       width = 8, 
       height = 6, 
       units = "in", 
       dpi = 300)

# 5.0 ===================================== Volcano plot ========================================================================================================
# 5.1 Selectie van genen ----
top_up <- rownames(head(hoogste_fold_change, 5))   # Top 5 hoogste fold change
top_down <- rownames(head(laagste_fold_change, 5)) # Top 5 laagste fold change
top_p <- rownames(head(laagste_p_waarde, 5))       # Top 5 laagste adjusted p-waarden

# 5.2 Biologisch relevante RA-genen ----
ra_genen <- c(
  "HLA-DRB1",    # Antigeenpresentatie: bepaalt welk eiwit het immuunsysteem als doelwit ziet
  "HLA-B",       # MHC-I functie: essentieel voor de herkenning van 'eigen' versus 'vreemd'
  "PTPN22",      # T-cel signalering: beïnvloedt de drempelwaarde voor het activeren van afweercellen
  "STAT4",       # Cytokine-respons: reguleert de gevoeligheid voor signalen die ontsteking aanjagen
  "TNFAIP3"      # Ontstekingsremming: fungeert als biologische schakelaar om immuunreacties te sussen
) 

# 5.3 Combineren en verwijderen van dubbele genen ----
genen_van_interesse <- unique(c(
  top_up,
  top_down,
  top_p,
  ra_genen
))

# 5.4 Volcano Plot ----
EnhancedVolcano(
  resultaten,
  lab = rownames(resultaten),
  x = "log2FoldChange",
  y = "padj",
  title = 'Significante genexpressie-verschillen in RA patiënten', 
  subtitle = 'RA vs Gezonde controles',
  
  col = stat_colors,
  
  FCcutoff = 1,
  pCutoff = 0.05,
  
  max.overlaps = Inf,
  labSize = 3,
  selectLab = genen_van_interesse,
  drawConnectors = TRUE,
  boxedLabels = TRUE,
  colAlpha = 0.8
)

# 5.5 Opslaan ----
dev.copy(
  png,
  'VolcanoplotRA.png',
  width = 8,
  height = 10,
  units = 'in',
  res = 500
)
dev.off()

# 6.0 ===================================== Go analyse ========================================================================================================
# 6.1 Library ----
library(goseq)

# 6.2 Data Opschonen ----
gene_names_clean <- sub(" .*", "", rownames(resultaten))
rownames(resultaten) <- gene_names_clean

# 6.3 Binaire vector maken ----
all_genes <- rownames(resultaten)
sig_genes_names <- rownames(resultaten[which(resultaten$padj < 0.05 & abs(resultaten$log2FoldChange) > 1), ])
gene_vector <- as.integer(all_genes %in% sig_genes_names)
names(gene_vector) <- all_genes

# 6.4 PWF & Verrijking ----
pwf <- nullp(gene_vector, "hg19", "geneSymbol")
enriched_GO <- goseq(pwf, "hg19", "geneSymbol")

# 6.5 Resultaten filteren en opslaan ----
top_enriched <- enriched_GO[enriched_GO$over_represented_pvalue < 0.05, ]
write.csv(top_enriched, "GO_Enrichment_RA.csv", row.names = FALSE)

# 7.0 ===================================== Pathway visualisatie (KEGG) ========================================================================================================
# 7.1 Library ----
library(pathview)
library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(stringr)

# 7.2 ID conversie ----
gene_conv <- bitr(rownames(resultaten), 
                  fromType = "SYMBOL", 
                  toType = "ENTREZID", 
                  OrgDb = org.Hs.eg.db)

# 7.3 Data mapping ----
foldchanges <- resultaten$log2FoldChange
names(foldchanges) <- rownames(resultaten)
kegg_input <- foldchanges[gene_conv$SYMBOL]
names(kegg_input) <- gene_conv$ENTREZID

# 7.4 Aanmaken object voor Dotplot ----
go_results <- enrichGO(gene = gene_conv$ENTREZID, OrgDb = org.Hs.eg.db, ont = "BP", readable = TRUE)
go_bp_simplified <- simplify(go_results)

# 8.0 ===================================== EXPORT VISUALISATIES & RESULTATEN ========================================================================================================
# 8.1 GO_Enrichment_RA.csv opslaan ----
write.csv(top_enriched, "GO_Enrichment_RA.csv", row.names = FALSE)

# 8.2 GO_plot.png (Barplot van de top resultaten) ----
png("GO_plot.png", width = 1000, height = 800, res = 120)
par(mar=c(5, 20, 4, 2)) 
top10_go <- head(top_enriched, 10) 
barplot(-log10(top10_go$over_represented_pvalue), 
        names.arg = top10_go$term, 
        las = 2, 
        horiz = TRUE, 
        col = col_up,
        main = "Top 10 Enriched GO Terms (goseq)",
        xlab = "-log10(p-value)")
dev.off()

# 8.3 KEGG_plot.png ----
pathview(
  gene.data  = kegg_input,
  pathway.id = "hsa05323",
  species    = "hsa",
  
  low  = expr_colors["down"],
  mid  = expr_colors["mid"],
  high = expr_colors["up"],
  
  limit = list(gene = 2, cpd = 1),
  kegg.native = TRUE
)

if (file.exists("KEGG_plot.png")) file.remove("KEGG_plot.png")
file.rename("hsa05323.pathview.png", "KEGG_plot.png")

# 8.4 GO_dotplot_clean.png (De nette Dotplot) ----
p <- dotplot(go_bp_simplified, showCategory = 12) + 
  scale_y_discrete(labels = function(x) str_wrap(x, width = 30)) + 
  ggtitle("GO Biological Process Enrichment Analysis") +
  theme_bw() + 
  theme(
    axis.text.y = element_text(size = 10),      
    plot.title = element_text(face = "bold"),   
    panel.grid.minor = element_blank()          
  )

ggsave("GO_dotplot_clean.png", plot = p, width = 10, height = 8, dpi = 300)

print(p)