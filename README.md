# 🧬 Transcriptomicsanalyse van Reumatoïde Artritis (RA)

## <img width="625" height="625" alt="image" src="https://github.com/user-attachments/assets/ee56e535-eb47-4598-b042-ed42fb8944ed" />
 Projectoverzicht

In dit project is een transcriptomicsanalyse van Reumatoïde Artritis (RA) uitgevoerd en vergeleken met gezonde controles. Met behulp van RNA-seq data is onderzocht welke genen verschillend tot expressie komen tussen gezonde en RA-monsters.

De analyse omvat:

* Mapping van sequencing reads naar het humane referentiegenoom
* Opstellen van een count matrix
* Differentiele genexpressieanalyse met **DESeq2**
* Visualisatie van genexpressie met een **Volcano plot**
* **Gene Ontology (GO)-analyse** voor biologische processen
* **KEGG pathway-analyse** en pathwayvisualisatie

Het doel van deze analyse is om inzicht te krijgen in biologische processen en pathways die mogelijk betrokken zijn bij **Reumatoïde Artritis**.

---

## 🧪 Workflow van de analyse

De volgende bioinformatische workflow is toegepast:

```text
FASTQ-bestanden
        ↓
Read Mapping (Rsubread)
        ↓
BAM-bestanden
        ↓
Feature Counting (featureCounts)
        ↓
Count Matrix
        ↓
Differentiële Genexpressie (DESeq2)
        ↓
Volcano Plot
        ↓
GO-analyse
        ↓
KEGG Pathway Analyse & Visualisatie
```

---

## 📂 Structuur van de repository

```text
.
├── README.md
├── J2P4_LBM2C_Geeske_de_Boer_Casus_RA.R
│
├── data/
│   ├── count_matrix_RA.txt
│   └── CasusRA_countmatrix.csv
│
├── results/
│   ├── ResultatenCasusRA.csv
│   ├── GO_Enrichment_RA.csv
│   ├── VolcanoplotRA.png
│   └── hsa05323.pathview.png
```

---

## 🧰 Gebruikte software en packages

De analyse is uitgevoerd in **RStudio** met behulp van verschillende packages uit R/Bioconductor:

* `Rsubread`
* `Rsamtools`
* `DESeq2`
* `EnhancedVolcano`
* `clusterProfiler`
* `goseq`
* `pathview`
* `KEGGREST`
* `org.Hs.eg.db`

Alle benodigde packages worden automatisch geïnstalleerd via de setup-sectie van het R-script.

---

## 📊 Resultaten

### Volcano plot

De volcano plot visualiseert welke genen significant up- of downgereguleerd zijn tussen RA- en gezonde monsters.

### GO-analyse

Met behulp van **Gene Ontology (GO)-analyse** zijn verrijkte biologische processen geïdentificeerd die mogelijk betrokken zijn bij ziekteprocessen van RA.

### KEGG pathway-analyse

De **KEGG pathway-analyse** en pathwayvisualisatie geven inzicht in pathways die geassocieerd zijn met Reumatoïde Artritis.

---

## 🔬 Dataset

De dataset bestaat uit:

* **4 gezonde controlemonsters**
* **4 Reumatoïde Artritis (RA)-monsters**

De analyse is uitgevoerd op een gefilterde count matrix om rekentijd te verkorten en de analyse efficiënter uit te voeren.

---

## 👩‍🔬 Auteur

**Geeske de Boer**
NHL Stenden Hogeschool
Biomedisch Laboratoriumonderzoek (BLO)
