# Transcriptomicsanalyse van Reumatoïde Artritis (RA) (beschrijvend makend, met conclusie)

# Introdcutie

Reumatoïde (RA) is een chronische, systematische auto-immuunziekte die voornamelijk gewrichten en omliggend weefsel aantast. In 2019 leefde er wereldbreed 18 miljoen mensen met RA, dit bedraagt ​​ongeveer 1% in de volwassene bevolking. Vrouwen worden vaker getroffen dan mannen, ongveer 70% meer waarvan 55% ouder als 55 is. Patiënten wie leven met RA ervaren een aanzienlijke negatieve impact op hun kwaliteit van leven. Zonder behandeling kan de systemische ontsteking zich via de bloedbaan door het lichaam verspreiden. Dit leidt bij RA tot onomkeerbare gewrichtsschade, de ontwikkeling van extra-articulaire manifestaties, invaliditeit en een verhoogd mortaliteitsrisico (Sahin et al., 2025; World Health Organization, 2023).

Om meer inzicht te krijgen in de onderliggende mechanismen van deze ziekte, is in dit project een transcriptomicsanalyse uitgevoerd met behulp van RNA-seq data. Het hoofddoel van deze analyse is om de verschillen in genexpressie tussen gezonde controlemonsters en RA-monsters nauwkeurig te onderzoeken. Hierbij wordt gebruikgemaakt van een verzameling genexpressie-informatie uit gepubliceerde studies die verschillende klinische condities omvatten, waaronder vroege en gevestigde reumatoïde artritis (Platzer et al., 2019). Door deze data te vergelijken met gezonde controles, worden de specifieke biologische pathways en genen geïdentificeerd die verantwoordelijk zijn voor de pathologische processen en ziektemechanismen bij RA.

---

# Methoden

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
Alle analyses volgden de workflow in R (**Figuur 1**). Reads werden gemapt tegen het humane referentiegenoom GRCh38.p14 (NCBI, 2026). Hiervoor werd een genoomindex gebouwd met `buildindex()` en uitgelijnd met `align()` via `Rsubread` (v2.22.1). Na sortering met `Rsamtools` (v2.24.0) telde `featureCounts()` de reads per gen tot een countmatrix.

## Differentiële expressieanalye sen visualisatie
Expressieverschillen tussen RA en controle werden berekend met `DESeq2` (v1.48.1). Genen waren significant bij een adjusted p-waarde < 0,05 en |log2FoldChange| > 1. Dit filter garandeert statistische en biologische relevantie. De data werden gevisualiseerd in een PCA-plot (`ggplot2` v4.0.2) en volcano plot (`EnhancedVolcano` v1.26.0) (**Figuur 1**).


<img width="2286" height="3851" alt="image" src="https://github.com/user-attachments/assets/05dc722c-f9a8-45c7-9ee2-1a1263f31fbb" />

***Figuur 1. Workflow voor de RNA-seq data-analyse bij reumatoïde artritis (RA). Deze afbeelding toont de stappen van ruwe data naar de resultaten.*** *In het midden staan de processtappen (rechthoeken). De workflow begint met het voorbereiden van de data. Daarna worden de reads gemapt op het referentiegenoom en geteld tot een countmatrix (bovenste blokken). Vervolgens wordt de metadata toegevoegd en start de differentiële expressieanalyse met DESeq2 (middelste blokken). De resultaten worden daarna gevisualiseerd met een PCA-plot en volcano plot (linksonder). Tot slot worden de belangrijkste genen functioneel geïnterpreteerd met een GO-enrichment en een KEGG pathway-analyse (rechtsonder). De invoerbestanden staan links en de gemaakte tussenbestanden staan rechts (parallellogrammen). Het eindresultaat bestaat uit de grafieken en pathway-visualisaties onderaan.*

## Functionele interpretatie en software
De biologische betekenis werd bepaald met GO-enrichment via `goseq` (v1.60.0) en `clusterProfiler` (v4.16.0) (**Figuur 1**). Daarnaast toonde `pathview` (v1.48.0) de genexpressie in de relevante KEGG-pathway hsa05323 (Rheumatoid arthritis). Alle overige softwaregegevens staan in `sessionInfo()` in de bijlage voor de reproduceerbaarheid.

---

# Resultaten: +- 200 woorden, inclusief correcte verwijzingen. beschrijf wat je afleest van uit figuur niet de details dat staat in het bijschrift. gebruik tussenkopjes, begin met doel, wat voor analyse heb je gedaan wat wil je eruit halen aan informatie beschrijf dan de belangrijkste bevindingen en verwijs naar het figuur, zet gresnwaarde voor volcano in tekst. in bijscrift welke groepen je met elkaar vergelijkt ra vs controle. Teskt boven figuur (bijschrift natuurlijk wel onder en voor een tabel er boven duh).

## PCA + volcano


<img width="1198" height="626" alt="image" src="https://github.com/user-attachments/assets/63d3d089-f0c2-481f-bffe-eefadfe06f46" />

***Figuur 2. Genexpressieprofielen van reumatoïde artritis (RA) patiënten vergeleken met gezonde controles.***
***(A)*** *PCA-plot waarbij PC1 (74% variantie) en PC2 (10% variantie) de monsters van RA-patiënten (paars) volledig scheiden van de gezonde controles (grijs).*
***(B)*** *Volcano plot van 29.407 genen (RA versus gezonde controles). De paarse punten voldoen aan de drempelwaarden voor significantie ($-\log_{10} P$) en expressieverandering ($\log_2\text{fold change}$). Sterk veranderde genen (o.a. ANKRD30BL, MT-ND6, IGHV3-53 en STAT4) zijn gelabeld.*

***Figuur 2. Principal Component Analysis (PCA) van genexpressiegegevens (RA vs. Normaal).*** *Deze puntenwolk toont de verdeling van de monsters op basis van de eerste twee hoofdcomponenten (PC's). De x-as representeert PC1, die 74% van de totale variantie verklaart, terwijl de y-as PC2 representeert, die verantwoordelijk is voor 10% van de variantie.*

Er is een duidelijke scheiding zichtbaar langs de PC1-as tussen de monsters van de patiënten met Reumatoïde Artritis (RA, paarse stippen) en de gezonde controlegroep (Normal, grijze stippen). De 'Normale' monsters clusteren hoofdzakelijk aan de linkerzijde van de grafiek (negatieve PC1-waarden), terwijl de 'RA' monsters zich aan de rechterzijde bevinden (positieve PC1-waarden). Dit suggereert dat het grootste deel van de variatie in genexpressie tussen deze monsters direct gerelateerd is aan de ziektetoestand.

---

## Volcano plot
<img width="945" height="1181" alt="image" src="https://github.com/user-attachments/assets/76c8418a-e346-4dc8-819d-aeb2c038e252" />

***Figuur 3. Volcano plot van differentiële genexpressie tussen RA-patiënten en gezonde controles.*** *Deze grafiek visualiseert de statistische significantie (\(-\log_{10} P\)) uitgezet tegen de mate van verandering in expressie (-log10^2) voor 29.407 variabelen (genen).*

De paarse punten vertegenwoordigen genen die zowel statistisch significant zijn als een substantiële verandering in expressie laten zien. Punten aan de rechterkant van de centrale nullijn duiden op genen die 'upregulated' zijn bij RA-patiënten (zoals IGHV3-53 en STAT4), terwijl punten aan de linkerkant 'downregulated' genen aangeven (zoals ANKRD30BL en MT-ND6). De horizontale stippellijn markeert de drempelwaarde voor statistische significantie, en de verticale stippellijnen geven de grenzen aan voor de fold change.

---

## GO-analyse: Enrichment
<img width="945" height="756" alt="image" src="https://github.com/user-attachments/assets/48e7d210-8f49-4fcd-9976-f07777fd8bfe" />

***Figuur 4. Top 10 verrijkte Gene Ontology (GO) termen.*** *De staafdiagram toont de tien meest significante biologische processen en moleculaire functies die geassocieerd zijn met de differentieel tot expressie gebrachte genen, geanalyseerd met goseq. De x-as geeft de negatieve logaritme van de p-waarde weer (\(-\log_{10} P\)), waarbij een langere staaf duidt op een hogere statistische significantie.*

De termen zijn sterk gerelateerd aan het immuunsysteem, met 'immunoglobulin complex' als de meest significante term. Andere prominente categorieën zijn 'immune system process', 'adaptive immune response' en 'leukocyte activation'. Deze resultaten bevestigen dat de geobserveerde genexpressie-verschillen in de RA-patiënten primair gedreven worden door actieve immuunresponsen en ontstekingsprocessen.


---
## GO-analyse: Dotplot
<img width="753" height="603" alt="image" src="https://github.com/user-attachments/assets/ad988223-587d-40de-ab1e-e1a9bba4b330" />

***Figuur 5. Dot plot van de Gene Ontology (GO) Biological Process verrijkingsanalyse.*** *Deze grafiek toont de verrijkte biologische processen op basis van de genexpressiedata. De x-as geeft de 'GeneRatio' weer, wat de verhouding is van genen uit de dataset die betrokken zijn bij een specifieke term ten opzichte van het totaal aantal genen in die term.*

De grootte van de cirkels (Count) representeert het absolute aantal genen dat geassocieerd is met de betreffende GO-term. De kleur van de cirkels geeft de aangepaste p-waarde (p.adjust) aan, waarbij rood staat voor een hogere significantie en blauw voor een lagere significantie binnen deze topselectie. Opvallende processen in deze analyse zijn onder andere 'signal release', 'axonogenesis' en verschillende ontwikkelingsprocessen zoals 'embryonic organ development'.



---

## KEGG Rheumatoid Arthritis pathway (hsa05323)
<img width="746" height="429" alt="image" src="https://github.com/user-attachments/assets/ae227dcf-2646-4f8c-81fb-0360212fac19" />

***Figuur 6. KEGG-pathway visualisatie van Reumatoïde Artritis.*** *Dit diagram (gegenereerd met Pathview) projecteert de genexpressiegegevens op de officiële KEGG-pathway voor RA. Het brengt de interacties in kaart tussen verschillende celtypen in het synovium, zoals T-cellen, B-cellen, macrofagen en fibroblasten.*

De kleuren van de genen/eiwitten geven de mate van expressie aan: paars duidt op een hogere expressie (upregulated) en roze/rood op een lagere expressie (downregulated) in de RA-groep vergeleken met de controles. De figuur visualiseert hoe deze expressieverschillen bijdragen aan pathologische processen zoals: Leukocyte migration & Inflammation: Door verhoogde expressie van cytokines (zoals IL-6 en IL-15) en chemokines (zoals CCL2 en CXCL1). Joint destruction & Bone resorption: Door de activatie van osteoclasten (o.a. via de RANKL-pathway) en de productie van matrix-afbrekende enzymen (MMP's).



---

# Conclusie: +- 200 woorden, inclusief aanbevelingen en onderzoek in context plaatsen (andere genen nog erbij in verwerken). dit kan bondig als resultaten goed beschreven zijn, wat beketkent de conclusie wat zegt het grotebeeld of ziektebeeld

Dit onderzoek bevestigt dat Reumatoïde Artritis gepaard gaat met een grootschalige herprogrammering van het transcriptoom in het synovium. De belangrijkste bevinding is de sterke activering van het adaptieve immuunsysteem, wat overeenkomt met de aanwezigheid van ACPA-autoantistoffen in de RA-monsters (pp. 1, 12). De resultaten, specifiek de verhoogde expressie van STAT4 en ontstekingscytokines in de KEGG-pathway, sluiten aan bij de literatuur die de rol van chronische synovitis bij gewrichtsschade beschrijft (Radu & Bungau, 2021).

De biologische betekenis van de gevonden genen zoals IL-6 en MMP's onderstreept het destructieve karakter van de ziekte op het gewrichtsslijmvlies en botweefsel (p. 7). Hoewel de immuunrespons dominant is, suggereren de GO-termen uit Figuur 5 ook betrokkenheid van neurologische signaalroutes, wat mogelijk gerelateerd is aan pijnreceptie in ontstoken gewrichten.
Aanbevelingen: Toekomstig onderzoek zou zich kunnen richten op de vroege stadia van RA (diagnose <12 maanden) om te bepalen of deze genexpressieprofielen bruikbaar zijn als vroege diagnostische biomarkers (p. 1). Daarnaast is validatie van de gevonden genen via qPCR in een groter cohort aanbevolen om de robuustheid van deze resultaten te verifiëren.


---

# AI-disclaimer

Bij dit project is gebruikgemaakt van **kunstmatige intelligentie (AI)** ter ondersteuning van programmeerwerk, debugging, structuur van de GitHub repository en tekstuele ondersteuning. Alle analyses, interpretaties en eindcontrole zijn zelfstandig uitgevoerd en gecontroleerd.

---

# Bronnen (nog aanvullen en goed neerzetten)

Begovich, A. B., Carlton, V. E., Honigberg, L. A., Schrodi, S. J., Chokkalingam, A. P., Alexander, H. C., ... & Gregersen, P. K. (2004). A missense single-nucleotide polymorphism in a gene encoding a protein tyrosine phosphatase (PTPN22) is associated with rheumatoid arthritis. American Journal of Human Genetics, 75(2), 330–337. doi.org

Jang S, Kwon EJ, Lee JJ. Rheumatoid Arthritis: Pathogenic Roles of Diverse Immune Cells. Int J Mol Sci. 2022 Jan 14;23(2):905. doi: 10.3390/ijms23020905. PMID: 35055087; PMCID: PMC8780115.

Padyukov, L. (2022). Genetics of rheumatoid arthritis. Seminars in Immunopathology, 44(1), 47–62. doi.org

Paroli, M., & Sirinian, M. I. (2023). When Autoantibodies Are Missing: The Challenge of Seronegative Rheumatoid Arthritis. Antibodies, 12(4), 69. doi.org

Platzer, A., Nussbaumer, T., Karonitsch, T., Smolen, J. S., & Aletaha, D. (2019). Analysis of gene expression in rheumatoid arthritis and related conditions offers insights into sex-bias, gene biotypes and co-expression patterns. PloS one, 14(7), e0219698. https://doi.org/10.1371/journal.pone.0219698

Sahin, D., Di Matteo, A., & Emery, P. (2025). Biomarkers in the diagnosis, prognosis and management of rheumatoid arthritis: A comprehensive review. Annals of clinical biochemistry, 62(1), 3–21. https://doi.org/10.1177/00045632241285843

World Health Organization. (2023, 28 juni). Rheumatoid arthritis. https://www.who.int/news-room/fact-sheets/detail/rheumatoid-arthritis (als artikel nog juist zeten)

Gabriel, S. E. (2001). The epidemiology of rheumatoid arthritis. Rheumatic Disease Clinics of North America, 27(2), 269–281. https://doi.org/10.1016/s0889-857x(05)70201-5

Kanehisa, M., Furumichi, M., Sato, Y., Ishiguro-Watanabe, M., & Tanabe, M. (2023). KEGG: integrating viruses and cellular organisms. Nucleic Acids Research, 51(D1), D587–D592. https://doi.org/10.1093/nar/gkac963

Liu, F., Huang, Y., Liu, F., & Wang, H. (2023). Identification of immune-related genes in diagnosing atherosclerosis with rheumatoid arthritis through bioinformatics analysis and machine learning. Frontiers in Immunology, 14. https://doi.org/10.3389/fimmu.2023.1126647

Love, M. I., Huber, W., & Anders, S. (2014). Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. Genome Biology, 15(12), 550. https://doi.org/10.1186/s13059-014-0550-8

Majithia, V., & Geraci, S. A. (2007). Rheumatoid Arthritis: Diagnosis and Management. The American Journal of Medicine, 120(11), 936–939. https://doi.org/10.1016/j.amjmed.2007.04.005

NCBI. (2026). Homo sapiens genome assembly GRCh38.p14. NCBI. Retrieved from NCBI Dataset

Radu, A.-F., & Bungău, S. G. (2021). Management of Rheumatoid Arthritis: An Overview. Cells, 10(11), 2857. https://doi.org/10.3390/cells10112857

The Gene Ontology Consortium. (2021). The Gene Ontology resource: enriching a GOld mine. Nucleic Acids Research, 49(D1), D325–D334. https://doi.org/10.1093/nar/gkaa1113

Yu, F., Hu, G., Li, L., Yu, B., & Liu, R. (2022). Identification of key candidate genes and biological pathways in the synovial tissue of patients with rheumatoid arthritis. Experimental and Therapeutic Medicine, 23(6). https://doi.org/10.3892/etm.2022.11295

Yu, G., Wang, L.-G., Han, Y., & He, Q.-Y. (2012). clusterProfiler: an R package for comparing biological themes among gene clusters. OMICS: A Journal of Integrative Biology, 16(5), 284–287. https://doi.org/10.1089/omi.2011.0118

Zhang, F., Wei, K., Slowikowski, K., Fonseka, C. Y., Rao, D. A., Kelly, S., Goodman, S. M., Tabechian, D., Hughes, L. B., Salomon-Escoto, K., Watts, G. F. M., Jonsson, A. H., Rangel-Moreno, J., Meednu, N., Rozo, C., Apruzzese, W., Eisenhaure, T. M., Lieb, D. J., Boyle, D. L., & Mandelin, A. M. (2019). Defining inflammatory cell states in rheumatoid arthritis joint synovial tissues by integrating single-cell transcriptomics and mass cytometry. Nature Immunology, 20(7), 928–942. https://doi.org/10.1038/s41590-019-0378-1


---

**Geeske de Boer**
NHL Stenden Hogeschool
Biologie en Medisch Laboratoriumonderzoek
25-26 J2P4 – Innovatieve Diagnostiek
Transcriptomics


voor het beheren gebruik voorbeelden om je beheren naar voren te laten komen
