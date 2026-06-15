# Inleiding: Transcriptomicsanalyse van Reumatoïde Artritis (RA)
Reumatoïde (RA) is een chronische, systematische auto-immuunziekte die voornamelijk gewrichten en omliggend weefsel aantast. In 2019 leefde er wereldbreed 18 miljoen mensen met RA, dit bedraagt ​​ongeveer 1% in de volwassene bevolking. Vrouwen worden vaker getroffen dan mannen, ongveer 70% meer waarvan 55% ouder als 55 is. Patiënten wie leven met RA ervaren een aanzienlijke negatieve impact op hun kwaliteit van leven. Zonder behandeling kan de systemische ontsteking zich via de bloedbaan door het lichaam verspreiden. Dit leidt bij RA tot onomkeerbare gewrichtsschade, de ontwikkeling van extra-articulaire manifestaties, invaliditeit en een verhoogd mortaliteitsrisico (Sahin et al., 2025; World Health Organization, 2023).

Om meer inzicht te krijgen in de onderliggende mechanismen van deze ziekte, is in dit project een transcriptomicsanalyse uitgevoerd met behulp van RNA-seq data. Het hoofddoel van deze analyse is om de verschillen in genexpressie tussen gezonde controlemonsters en RA-monsters nauwkeurig te onderzoeken. Hierbij wordt gebruikgemaakt van een verzameling genexpressie-informatie uit gepubliceerde studies die verschillende klinische condities omvatten, waaronder vroege en gevestigde reumatoïde artritis (Platzer et al., 2019). Door deze data te vergelijken met gezonde controles, worden de specifieke biologische pathways en genen geïdentificeerd die verantwoordelijk zijn voor de pathologische processen en ziektemechanismen bij RA.

---

# Methode: +- 200 woorden met methode, flowschema. Zie leerdoelen voor minimale inhoud. Scripts, data etc. kunnen in een aparte folder met verwijzing

<img width="945" height="1373" alt="image" src="https://github.com/user-attachments/assets/81ea3605-3667-4866-bc43-eb23049133a4" />
***Figuur 1. RNA-seq analysepipeline voor vergelijking tussen RA en gezonde controles.*** *De figuur toont de volledige workflow van ruwe RNA-seq data (FASTQ) tot biologische interpretatie. Dit omvat read mapping op het referentiegenoom, BAM-verwerking en genquantificatie (groen), toevoeging van metadata en differentiële expressieanalyse met DESeq2 (oranje), gevolgd door data visualisatie met PCA en volcano plots (rood). Vervolgens worden significante genen functioneel geïnterpreteerd via GO-enrichment (barplot en dotplot) en KEGG pathway-analyse (paars). Het eindresultaat bestaat uit genexpressieresultaten, statistische output en biologische pathway-visualisaties.*

Figuur 1 toont de volledige RNA-seq analyseworkflow voor de vergelijking tussen RA-patiënten en gezonde controles. De gebruikte dataset is afkomstig uit Platzer et al. (2019), waarin genexpressie in reumatoïde artritis en gerelateerde condities werd geanalyseerd. De analyse start met ruwe sequencingdata (FASTQ), een referentiegenoom en een GTF-annotatiebestand. Vervolgens wordt met Rsubread een genome index gebouwd en worden de reads gemapt op het referentiegenoom. De resulterende BAM-bestanden worden gesorteerd en geïndexeerd met Rsamtools om een gestandaardiseerde input voor verdere analyse te verkrijgen. Daarna worden de reads per gen gekwantificeerd met featureCounts, wat resulteert in een count matrix.

Op basis van deze matrix en metadata (RA versus Normal) wordt met DESeq2 een differentiële expressieanalyse uitgevoerd, waarbij log2 fold changes en statistische significantie worden berekend. De resultaten worden verkend via een PCA-analyse om clustering tussen groepen te visualiseren en via een volcano plot om significante genen te identificeren op basis van fold change, p-waarde en biologisch relevante RA-genen.

De significante genen worden gebruikt voor functionele interpretatie via GO-enrichmentanalyse (goseq/clusterProfiler) en KEGG-pathwayanalyse (pathview), wat inzicht geeft in verrijkte biologische processen en signaalroutes.

---

# Resultaten: +- 200 woorden, inclusief correcte verwijzingen.

## PCA
<img width="945" height="709" alt="image" src="https://github.com/user-attachments/assets/4cb135d2-04d3-4204-9710-f1bafe855329" />

***Figuur 2. Principal Component Analysis (PCA) van genexpressiegegevens (RA vs. Normaal).*** *Deze puntenwolk toont de verdeling van de monsters op basis van de eerste twee hoofdcomponenten (PC's). De x-as representeert PC1, die 74% van de totale variantie verklaart, terwijl de y-as PC2 representeert, die verantwoordelijk is voor 10% van de variantie.*

Er is een duidelijke scheiding zichtbaar langs de PC1-as tussen de monsters van de patiënten met Reumatoïde Artritis (RA, paarse stippen) en de gezonde controlegroep (Normal, grijze stippen). De 'Normale' monsters clusteren hoofdzakelijk aan de linkerzijde van de grafiek (negatieve PC1-waarden), terwijl de 'RA' monsters zich aan de rechterzijde bevinden (positieve PC1-waarden). Dit suggereert dat het grootste deel van de variatie in genexpressie tussen deze monsters direct gerelateerd is aan de ziektetoestand.

---

## Volcano plot
<img width="945" height="1181" alt="image" src="https://github.com/user-attachments/assets/76c8418a-e346-4dc8-819d-aeb2c038e252" />

***Figuur 3. Volcano plot van differentiële genexpressie tussen RA-patiënten en gezonde controles.*** *Deze grafiek visualiseert de statistische significantie (\(-\log_{10} P\)) uitgezet tegen de mate van verandering in expressie (\(\log_2 \text{fold change}\)) voor 29.407 variabelen (genen).*

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

# Conclusie: +- 200 woorden, inclusief aanbevelingen en onderzoek in context plaatsen (andere genen nog erbij in verwerken)

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

World Health Organization. (2023, 28 juni). Rheumatoid arthritis. https://www.who.int/news-room/fact-sheets/detail/rheumatoid-arthritis

---

**Geeske de Boer**
NHL Stenden Hogeschool
Biologie en Medisch Laboratoriumonderzoek
25-26 J2P4 – Innovatieve Diagnostiek
Transcriptomics
