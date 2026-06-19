# Transcriptomicsanalyse toont sterke immuunactivatie en ontstekingssignatuur in reumatoïde artritis

**Geeske de Boer**
NHL Stenden Hogeschool
Biologie en Medisch Laboratoriumonderzoek
25-26 J2P4 – Innovatieve Diagnostiek
Transcriptomics

---

# Inhoud/Structuur

* [Data/](Data) - Ruwe en verwerkte datasets voor de analyse van de reuma casus.
* [Script/](Script) - Overzicht van de scripts gebruikt tijdens de data analyse in R.
* [Resultaten/](Resultaten) - Figuren van GO-analyse, KEGG-analyse en Pathview analyse.
* [Bronnen/](Bronnen) - Gebruikte bronnen voor de interpretatie en het maken van scripts in R.
* [Flowschema/](Flowschema) - Workflow-afbeeldingen en schema's van de R-pijplijn.
* [SessionInfo()/](SessionInfo\(\)) - Overige documenten en softwareversies gebruikt bij dit project voor de reproduceerbaarheid.
* [data_stewardship/](data_stewardship) - Beheren van de competentie voor data stewardship.

---

# Introductie

Reumatoïde (RA) is een chronische, systematische auto-immuunziekte die voornamelijk gewrichten en omliggend weefsel aantast. In 2019 leefde er wereldbreed 18 miljoen mensen met RA, dit bedraagt ​​ongeveer 1% in de volwassene bevolking. Vrouwen worden vaker getroffen dan mannen, ongveer 70% meer waarvan 55% ouder als 55 is. Patiënten wie leven met RA ervaren een aanzienlijke negatieve impact op hun kwaliteit van leven. Zonder behandeling kan de systemische ontsteking zich via de bloedbaan door het lichaam verspreiden. Dit leidt bij RA tot onomkeerbare gewrichtsschade, de ontwikkeling van extra-articulaire manifestaties, invaliditeit en een verhoogd mortaliteitsrisico (Sahin et al., 2025; World Health Organization, 2023).

Om meer inzicht te krijgen in de onderliggende mechanismen van deze ziekte, is in dit project een transcriptomicsanalyse uitgevoerd met behulp van RNA-seq data. Het hoofddoel van deze analyse is om de verschillen in genexpressie tussen gezonde controlemonsters en RA-monsters nauwkeurig te onderzoeken. Hierbij wordt gebruikgemaakt van een verzameling genexpressie-informatie uit gepubliceerde studies die verschillende klinische condities omvatten, waaronder vroege en gevestigde reumatoïde artritis (Platzer et al., 2019). Door deze data te vergelijken met gezonde controles, worden de specifieke biologische pathways en genen geïdentificeerd die verantwoordelijk zijn voor de pathologische processen en ziektemechanismen bij RA.

---

# Methode

## Dataset en monsters
De in dit project gebruikte RNA-seq data zijn afkomstig uit de studie van Platzer et al. (2019), beschikbaar via de NCBI Sequence Read Archive (SRA), bestaande uit acht synoviumbiopten van reumatoïde artritis (RA) patiënten en gezonde controles (SRR4785819–SRR4785988; tabel 1). De ruwe data (FASTQ) zijn oorspronkelijk gegenereerd na RNA-extractie uit synoviumweefsel, gevolgd door library preparation met TruSeq Stranded Total RNA RiboZero (Illumina) en sequencing op een Illumina HiSeq 2000 (paired-end 100 bp).

**Tabel 1.** *Overzicht van de gebruikte RNA-seq monsters uit de studie van Platzer et al. (2019).*

| Accessionnummer | Leeftijd | Gender | Groep |
| :--- | :--- | :--- | :--- |
| SRR4785819 | 31 | Vrouw | Normaal |
| SRR4785820 | 15 | Vrouw | Normaal |
| SRR4785828 | 31 | Vrouw | Normaal |
| SRR4785831 | 42 | Vrouw | Normaal |
| SRR4785979 | 54 | Vrouw | Reumatoïde artritis (vastgesteld) |
| SRR4785980 | 66 | Vrouw | Reumatoïde artritis (vastgesteld) |
| SRR4785986 | 60 | Vrouw | Reumatoïde artritis (vastgesteld) |
| SRR4785988 | 59 | Vrouw | Reumatoïde artritis (vastgesteld) |

## Gen-mapping en kwantificatie
Alle analyses hebben de workflow in R gevolgd (Figuur 1). Reads zijn gemapt tegen het humane referentiegenoom GRCh38.p14 (NCBI, 2026). Hiervoor is een genoomindex gebouwd met buildindex() en uitgelijnd met align() via Rsubread (v2.22.1). Na sortering met Rsamtools (v2.24.0) heeft featureCounts() de reads per gen geteld tot een countmatrix.

## Differentiële expressieanalyse en visualisatie
Expressieverschillen tussen RA en controle zijn berekend met DESeq2 (v1.48.1). Genen zijn significant gebleken bij een adjusted p-waarde < 0,05 en |log2FoldChange| > 1. Dit filter garandeert statistische en biologische relevantie (let op: deze zin staat in de tegenwoordige tijd omdat het een algemeen feit/logica beschrijft, dit is correct). De data zijn gevisualiseerd in een PCA-plot (ggplot2 v4.0.2) en volcano plot (EnhancedVolcano v1.26.0) **(Figuur 1)**.

<img width="2286" height="3851" alt="image" src="https://github.com/user-attachments/assets/db1694bd-2ecf-423a-a0b8-1cee15b1b81d" />

***Figuur 1. Workflow voor de RNA-seq data-analyse bij reumatoïde artritis (RA).*** *Deze afbeelding toont de stappen van ruwe data naar de resultaten. In het midden staan de processtappen (rechthoeken). De workflow begint met het voorbereiden van de data. Daarna zijn de reads gemapt op het referentiegenoom en geteld tot een countmatrix (bovenste blokken). Vervolgens is de metadata toegevoegd en is de differentiële expressieanalyse met DESeq2 gestart (middelste blokken). De resultaten zijn daarna gevisualiseerd met een PCA-plot en volcano plot (linksonder). Tot slot zijn de belangrijkste genen functioneel geïnterpreteerd met een GO-enrichment en een KEGG pathway-analyse (rechtsonder). De invoerbestanden staan links en de gemaakte tussenbestanden staan rechts (parallellogrammen). Het eindresultaat bestaat uit de grafieken en pathway-visualisaties onderaan.*

## Functionele interpretatie en software
De biologische betekenis is bepaald met GO-enrichment via goseq (v1.60.0) en clusterProfiler (v4.16.0) **(Figuur 1)**. Daarnaast heeft pathview (v1.48.0) de genexpressie in de relevante KEGG-pathway hsa05323 (Rheumatoid arthritis) getoond. Alle overige softwaregegevens staan in [SessionInfo()](SessionInfo()) in de bijlage voor de reproduceerbaarheid.

---

# Resultaten

## PCA en volcano plot: duidelijke scheiding en brede genexpressieverschillen tussen RA en controles

Het doel van deze analyses was het bepalen van verschillen in genexpressie tussen RA-patiënten en gezonde controles. De PCA laat een duidelijke scheiding zien tussen beide groepen, waarbij RA en controles apart clusteren **(Figuur 2A)**. Dit geeft aan dat de ziektetoestand de belangrijkste bron van variatie is in de data.
De volcano plot laat zien dat veel genen significant differentieel tot expressie komen **(Figuur 2B)**. Genen aan de rechterzijde zijn verhoogd in RA, terwijl genen aan de linkerzijde verlaagd zijn. Voorbeelden zijn STAT4 (upregulated) en MT-ND6 (downregulated).

<img width="1198" height="626" alt="image" src="https://github.com/user-attachments/assets/e2fae861-bf74-4260-9961-99c172743a9c" />

***Figuur 2. Genexpressieprofielen van reumatoïde artritis (RA) patiënten vergeleken met gezonde controles.***
***(A)*** *PCA-plot waarbij PC1 (74% variantie) en PC2 (10% variantie) de monsters van RA-patiënten (paars) volledig scheiden van de gezonde controles (grijs).*
***(B)*** *Volcano plot van 29.407 genen (RA versus gezonde controles). De paarse punten voldoen aan de drempelwaarden voor significantie ($-\log_{10} P$) en expressieverandering ($\log_2\text{fold change}$). Sterk veranderde genen (o.a. ANKRD30BL, MT-ND6, IGHV3-53 en STAT4) zijn gelabeld.*

---

## GO-enrichmentanalyse: oververtegenwoordigde immuun- en signaalprocessen in RA
GO-analyse laat zien dat immuunprocessen sterk oververtegenwoordigd zijn in RA ten opzichte van controles **(Figuur 3C–D)**, waaronder immune system process en leukocyte activation. Daarnaast komen signaaltransductie en celcommunicatie vaker voor in de RA-genen. De dot plot bevestigt dit en laat zien dat deze processen zowel een hoge significantie als gene ratio hebben.

<img width="1196" height="624" alt="image" src="https://github.com/user-attachments/assets/eddbd4c7-a3d7-4e07-8482-314254e7f488" />

***Figuur 3. Gene Ontology (GO) enrichmentanalyse van differentieel tot expressie gebrachte genen (RA versus gezonde controles).*** 
***(C)*** *Barplot van de top verrijkte GO Biological Process-termen op basis van statistische significantie. De x-as toont de negatieve logaritme van de p-waarde.*
***(D)*** *Dot plot van de verrijkte GO-termen. De x-as toont de *GeneRatio* (de verhouding van betrokken genen per term). De grootte van de punten representeert het aantal genen (*Count*) en de kleur geeft de adjusted p-waarde (*p.adjust*) weer. De analyses zijn uitgevoerd met `goseq` en `clusterProfiler` om RA-monsters te vergelijken met gezonde controles.*

---

# KEGG pathway enrichment: verrijkte immuun- en signaalroutes in RA
KEGG-analyse toont meerdere verrijkte pathways in de opgereguleerde genen tussen RA-patiënten en controles **(Figuur 4)**. Dit betreft vooral immuun- en signaalgerelateerde routes die significant oververtegenwoordigd zijn in de dataset.

<img width="3000" height="2400" alt="image" src="https://github.com/user-attachments/assets/c8141e9c-ceaf-4100-9830-a8071e4ea22e" />

***Figuur 4. KEGG pathway enrichment analyse van opgereguleerde differentieel tot expressie komende genen (DEGs) tussen de RA-groep en de controlegroep.*** *De x-as geeft de Gene Ratio weer (het aandeel DEGs binnen een pathway), de grootte van de cirkels correspondeert met het aantal genen (Count) en de kleur geeft de aangepaste p-waarde (padj) weer.*

---

# Pathview analyse: verstoring van de Rheumatoid arthritis pathway
De Pathview-analyse van de KEGG rheumatoid arthritis pathway laat zien dat meerdere ontstekingsgerelateerde genen verhoogd tot expressie komen in RA ten opzichte van controles **(Figuur 5)**. Dit wijst op verstoring van immuun- en ontstekingsprocessen binnen deze pathway.

<img width="1492" height="859" alt="image" src="https://github.com/user-attachments/assets/506d6725-5945-43a3-a867-beffca704d70" />


***Figuur 5. Pathview-visualisatie van de KEGG Rheumatoid arthritis-pathway voor de vergelijking tussen de RA-groep en de controlegroep.*** *De kleur van de genen geeft de relatieve genexpressie weer: paars duidt op een hogere expressie en roze op een lagere expressie in de RA-groep ten opzichte van de controlegroep. Witte vakken geven genen weer waarvoor geen differentiële expressie is gedetecteerd.*

---

# Conclusie

In dit onderzoek zijn verschillen in genexpressie tussen patiënten met reumatoïde artritis (RA) en gezonde controles geanalyseerd met RNA-seq data uit literatuur. De resultaten laten een duidelijke scheiding zien tussen beide groepen en tonen dat RA sterk wordt gekenmerkt door grootschalige veranderingen in genexpressie.

GO- en pathway-analyses laten zien dat vooral immuun- en ontstekingsprocessen sterk oververtegenwoordigd zijn in RA. Hierbij spelen processen zoals leukocyte activation, cytokine signaling en signaaltransductie een centrale rol. Ook KEGG- en Pathview-analyses bevestigen dat de rheumatoid arthritis pathway verstoord is, met veranderde expressie van genen zoals IL6, TNF, CCL2 en MMP13. Dit wijst op actieve immuunresponsen, ontsteking en weefselschade in het synovium.

Op basis van deze resultaten kan geconcludeerd worden dat RA wordt aangedreven door een sterk geactiveerd immuunsysteem met duidelijke verstoring van ontstekings- en signaalroutes. Dit ondersteunt het beeld van RA als een systemische auto-immuunziekte met complexe genregulatie.

Voor vervolgonderzoek wordt aanbevolen om meer individuele datasets te analyseren en integratie met single-cell RNA-seq toe te passen om celtype-specifieke effecten beter te begrijpen. Daarnaast kan focus op specifieke kandidaatgenen bijdragen aan het identificeren van potentiële therapeutische targets.

---

# AI-disclaimer

Bij dit project is gebruikgemaakt van kunstmatige intelligentie (AI) ter ondersteuning van het programmeerwerk, debugging, de structuur van de GitHub repository, controle en tekstverbetering. Alle inhoudelijke analyses, interpretaties en de eindcontrole zijn zelfstandig uitgevoerd en gecontroleerd.

---
# [Bronnen](Bronnen)

* Begovich, A. B., Carlton, V. E., Honigberg, L. A., Schrodi, S. J., Chokkalingam, A. P., Alexander, H. C., Ardlie, K. G., Huang, Q., Smith, A. M., Spoerke, J. M., Conn, M. T., Chang, M., Chang, S. Y., Saiki, R. K., Catanese, J. J., Leong, D. U., Garcia, V. E., McAllister, L. B., Jeffery, D. A., Lee, A. T., … Gregersen, P. K. (2004). A missense single-nucleotide polymorphism in a gene encoding a protein tyrosine phosphatase (PTPN22) is associated with rheumatoid arthritis. American journal of human genetics, 75(2), 330–337. https://doi.org/10.1086/422827
* Gabriel S. E. (2001). The epidemiology of rheumatoid arthritis. Rheumatic diseases clinics of North America, 27(2), 269–281. https://doi.org/10.1016/s0889-857x(05)70201-5
* Google. (2026, 19 juni). Gemini (Versie Gemini 1.5 Pro) [Groot taalmodel]. google.com
* Jang, S., Kwon, E. J., & Lee, J. J. (2022). Rheumatoid Arthritis: Pathogenic Roles of Diverse Immune Cells. International journal of molecular sciences, 23(2), 905. https://doi.org/10.3390/ijms23020905
* Kanehisa, M., Furumichi, M., Sato, Y., Ishiguro-Watanabe, M., & Tanabe, M. (2021). KEGG: integrating viruses and cellular organisms. Nucleic acids research, 49(D1), D545–D551. https://doi.org/10.1093/nar/gkaa970
* Liu, F., Huang, Y., Liu, F., & Wang, H. (2023). Identification of immune-related genes in diagnosing atherosclerosis with rheumatoid arthritis through bioinformatics analysis and machine learning. Frontiers in immunology, 14, 1126647. https://doi.org/10.3389/fimmu.2023.1126647
* Love, M. I., Huber, W., & Anders, S. (2014). Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. Genome biology, 15(12), 550. https://doi.org/10.1186/s13059-014-0550-8
* Majithia, V., & Geraci, S. A. (2007). Rheumatoid arthritis: diagnosis and management. The American journal of medicine, 120(11), 936–939. https://doi.org/10.1016/j.amjmed.2007.04.005
* NCBI. (2026). *Homo sapiens genome assembly GRCh38.p14*. NCBI Dataset.
* OpenAI. (2026, 19 juni). ChatGPT (Versie GPT-4o) [Groot taalmodel]. openai.com
* Paroli, M., & Sirinian, M. I. (2023). When Autoantibodies Are Missing: The Challenge of Seronegative Rheumatoid Arthritis. Antibodies (Basel, Switzerland), 12(4), 69. https://doi.org/10.3390/antib12040069
* Platzer, A., Nussbaumer, T., Karonitsch, T., Smolen, J. S., & Aletaha, D. (2019). Analysis of gene expression in rheumatoid arthritis and related conditions offers insights into sex-bias, gene biotypes and co-expression patterns. PloS one, 14(7), e0219698. https://doi.org/10.1371/journal.pone.0219698
* Radu, A. F., & Bungau, S. G. (2021). Management of Rheumatoid Arthritis: An Overview. Cells, 10(11), 2857. https://doi.org/10.3390/cells10112857
* Sahin, D., Di Matteo, A., & Emery, P. (2025). Biomarkers in the diagnosis, prognosis and management of rheumatoid arthritis: A comprehensive review. Annals of clinical biochemistry, 62(1), 3–21. https://doi.org/10.1177/00045632241285843
* Gene Ontology Consortium (2021). The Gene Ontology resource: enriching a GOld mine. Nucleic acids research, 49(D1), D325–D334. https://doi.org/10.1093/nar/gkaa1113
* World Health Organization. (2023, 28 juni). *Rheumatoid arthritis*. [https://who.int](https://who.int)
* Yu, F., Hu, G., Li, L., Yu, B., & Liu, R. (2022). Identification of key candidate genes and biological pathways in the synovial tissue of patients with rheumatoid arthritis. Experimental and therapeutic medicine, 23(6), 368. https://doi.org/10.3892/etm.2022.11295
* Yu, G., Wang, L. G., Han, Y., & He, Q. Y. (2012). clusterProfiler: an R package for comparing biological themes among gene clusters. Omics : a journal of integrative biology, 16(5), 284–287. https://doi.org/10.1089/omi.2011.0118
* Zhang, F., Wei, K., Slowikowski, K., Fonseka, C. Y., Rao, D. A., Kelly, S., Goodman, S. M., Tabechian, D., Hughes, L. B., Salomon-Escoto, K., Watts, G. F. M., Jonsson, A. H., Rangel-Moreno, J., Meednu, N., Rozo, C., Apruzzese, W., Eisenhaure, T. M., Lieb, D. J., Boyle, D. L., Mandelin, A. M., 2nd, … Raychaudhuri, S. (2019). Defining inflammatory cell states in rheumatoid arthritis joint synovial tissues by integrating single-cell transcriptomics and mass cytometry. Nature immunology, 20(7), 928–942. https://doi.org/10.1038/s41590-019-0378-1 
