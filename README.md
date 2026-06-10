# Transcriptomicsanalyse van Reumatoïde Artritis (RA)

Reumatoïde (RA) is een chronische, systematische auto-immuunziekte die voornamelijk gewrichten en omliggend weefsel aantast. RA bedraagt ​​ongeveer 1% in de volwassen bevolking. Vrouwen worden vaker getroffen dan mannen, met een verhouding van 2,45. Patiënten wie leven met RA ervaren een aanzienlijke negatieve impact op hun kwaliteit van leven. Zonder behandeling kan de systemische ontsteking zich via de bloedbaan door het lichaam verspreiden. Dit leidt bij RA tot onomkeerbare gewrichtsschade, de ontwikkeling van extra-articulaire manifestaties, invaliditeit en een verhoogd mortaliteitsrisico (Sahin et al., 2025).

In dit project is een transcriptomicsanalyse van Reumatoïde Artritis (RA) uitgevoerd met behulp van RNA-seq data. Het doel van deze analyse is om verschillen in genexpressie tussen gezonde controlemonsters en RA-monsters te onderzoeken. De data is verkregen 

Sahin, D., Di Matteo, A., & Emery, P. (2025). Biomarkers in the diagnosis, prognosis and management of rheumatoid arthritis: A comprehensive review. Annals of clinical biochemistry, 62(1), 3–21. https://doi.org/10.1177/00045632241285843

Platzer, A., Nussbaumer, T., Karonitsch, T., Smolen, J. S., & Aletaha, D. (2019). Analysis of gene expression in rheumatoid arthritis and related conditions offers insights into sex-bias, gene biotypes and co-expression patterns. PloS one, 14(7), e0219698. https://doi.org/10.1371/journal.pone.0219698

Jang S, Kwon EJ, Lee JJ. Rheumatoid Arthritis: Pathogenic Roles of Diverse Immune Cells. Int J Mol Sci. 2022 Jan 14;23(2):905. doi: 10.3390/ijms23020905. PMID: 35055087; PMCID: PMC8780115.

<img width="300" alt="RA afbeelding" src="https://github.com/user-attachments/assets/ee56e535-eb47-4598-b042-ed42fb8944ed" />



Deze repository is opgezet om de workflow van een bio-informatica analyse **transparant, reproduceerbaar en overzichtelijk** weer te geven.

---

# 📂 Structuur van de repository

```text
.
├── README.md
├── scripts/
│   └── J2P4_LBM2C_Geeske_de_Boer_Casus_RA.R
│
├── data/
│   ├── count_matrix_RA.txt
│   └── CasusRA_countmatrix.csv
│
├── results/
│   ├── ResultatenCasusRA.csv
│   ├── GO_Enrichment_RA.csv
│   ├── VolcanoplotRA.png
│   ├── GO_plot.png
│   ├── KEGG_plot.png
│   └── hsa05323.pathview.png
│
├── bronnen/
│   └── gebruikte_literatuur.txt
```

---

# 🔬 Inleiding

Reumatoïde Artritis (RA) is een chronische auto-immuunziekte waarbij ontstekingsreacties leiden tot schade aan gewrichten en omliggende weefsels. Door veranderingen in genexpressie te analyseren kan beter inzicht verkregen worden in biologische processen en pathways die betrokken zijn bij het ontstaan en de progressie van de ziekte.

In dit project wordt transcriptomics toegepast om verschillen in genexpressie tussen gezonde controlemonsters en RA-monsters te onderzoeken. Daarnaast wordt gekeken welke biologische processen en pathways mogelijk betrokken zijn bij ziekteontwikkeling.

### Onderzoeksvraag

**Welke genen en biologische pathways verschillen in expressie tussen gezonde controlemonsters en patiënten met Reumatoïde Artritis?**

**[VOEG TOE]**
Onderbouw deze introductie met minimaal **2 wetenschappelijke bronnen**.

---

# ⚙️ Methoden

De analyse werd uitgevoerd in **RStudio** met behulp van packages uit **Bioconductor**.

### 1. Mapping

RNA-seq reads werden gemapt tegen het humane referentiegenoom (**GRCh38**) met behulp van `Rsubread`.

### 2. Count matrix

Na mapping werden reads toegewezen aan genen met `featureCounts`, waarna een count matrix werd gegenereerd.

### 3. Differentiële genexpressie

Met `DESeq2` werd onderzocht welke genen significant verschillend tot expressie kwamen tussen gezonde controlemonsters en RA-monsters.

### 4. Visualisatie

Een **Volcano plot** werd gebruikt om significante up- en downregulatie van genen visueel weer te geven.

### 5. GO-analyse

Met behulp van **Gene Ontology (GO)-analyse** werden verrijkte biologische processen onderzocht.

### 6. KEGG pathway-analyse

Met behulp van `KEGG` en `pathview` werden relevante ziektepathways gevisualiseerd.

---

# 📊 Resultaten

## Volcano plot

De volcano plot laat zien welke genen significant up- of downgereguleerd zijn tussen RA- en gezonde monsters.

![Volcano plot](results/VolcanoplotRA.png)

**[VOEG TOE]**
Beschrijf kort:

* Hoeveel significante genen gevonden zijn
* Welke genen opvallend waren
* Of up- of downregulatie overheerste

---

## GO-analyse

De GO-analyse identificeerde biologische processen die significant verrijkt waren in de dataset.

![GO analyse](results/GO_plot.png)

**[VOEG TOE]**
Beschrijf:

* Welke biologische processen gevonden werden
* Waarom deze relevant zijn voor RA

---

## KEGG-analyse

De KEGG-analyse identificeerde pathways die mogelijk betrokken zijn bij ziekteprocessen van Reumatoïde Artritis.

![KEGG analyse](results/KEGG_plot.png)

**[VOEG TOE]**
Beschrijf:

* Welke pathways verrijkt waren
* Waarom deze biologisch relevant zijn

---

## KEGG Rheumatoid Arthritis pathway (hsa05323)

De pathway **hsa05323 (Rheumatoid Arthritis)** werd gevisualiseerd om te onderzoeken welke genen betrokken zijn bij RA-gerelateerde ontstekingsmechanismen.

![RA pathway](results/hsa05323.pathview.png)

**[VOEG TOE]**
Beschrijf kort:

* Welke genen opvielen
* Welke onderdelen van de pathway actief leken

---

# 💭 Discussie

Deze analyse geeft inzicht in verschillen in genexpressie tussen gezonde controlemonsters en RA-monsters. Toch zijn er enkele beperkingen waarmee rekening gehouden moet worden.

Een beperking van deze analyse is de relatief kleine dataset (**n = 4 per groep**), waardoor statistische kracht beperkt kan zijn. Daarnaast is gewerkt met een **gefilterde count matrix** om rekentijd te verkorten, wat invloed kan hebben op de hoeveelheid geanalyseerde genen.

Verder zijn de resultaten afhankelijk van gekozen filters, zoals de significatiedrempel en fold-change cutoff. Toekomstig onderzoek met grotere datasets kan aanvullende inzichten geven in relevante pathways en biomarkers voor RA.

---

# 🧾 Conclusie

**[VOEG TOE – ongeveer 5–8 zinnen]**

Beschrijf:

* belangrijkste bevindingen
* relevante pathways/processen
* relatie met literatuur
* biologische betekenis van de resultaten

---

# 🤖 AI-disclaimer

Bij dit project is gebruikgemaakt van **kunstmatige intelligentie (AI)** ter ondersteuning van programmeerwerk, debugging, structuur van de GitHub repository en tekstuele ondersteuning. Alle analyses, interpretaties en eindcontrole zijn zelfstandig uitgevoerd en gecontroleerd.

---

# 📚 Bronnen

**[VOEG TOE – minimaal 2 wetenschappelijke bronnen]**

1. Smolen JS, et al. *Rheumatoid arthritis.* The Lancet. 2016.
2. Firestein GS, McInnes IB. *Immunopathogenesis of Rheumatoid Arthritis.* Immunity. 2017.

**Geeske de Boer**
NHL Stenden Hogeschool
Biomedisch Laboratoriumonderzoek (BLO)
J2P4 – Innovatieve Diagnostiek
