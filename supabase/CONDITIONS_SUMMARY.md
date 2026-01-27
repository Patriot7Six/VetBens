# VetBens Foundation - Conditions Database Summary

## Overview

This document summarizes the 100 VA disability conditions seeded into the database.

## Total Conditions: 100

### Breakdown by Category

#### Autoimmune (7 conditions)
1. Lupus (Systemic Lupus Erythematosus) - DC 6350
2. Rheumatoid Arthritis - DC 5002
3. Multiple Sclerosis - DC 8018
4. Crohn's Disease - DC 7323
5. Ulcerative Colitis - DC 7324
6. Psoriasis - DC 7816
7. Graves Disease - DC 7900

#### Cardiovascular (8 conditions)
1. Ischemic Heart Disease - DC 7005
2. Hypertension (High Blood Pressure) - DC 7101
3. Heart Failure - DC 7007
4. Arrhythmia - DC 7010
5. Peripheral Vascular Disease - DC 7117
6. Deep Vein Thrombosis - DC 7121
7. Varicose Veins - DC 7120
8. Atherosclerosis - DC 7115

#### Neurological (9 conditions)
1. Traumatic Brain Injury (TBI) - DC 8045
2. Migraine Headaches - DC 8100
3. Peripheral Neuropathy - DC 8520
4. Radiculopathy - DC 8610
5. Epilepsy - DC 8910
6. Parkinson's Disease - DC 8004
7. Bell's Palsy - DC 8207
8. Vertigo (Vestibular Disorder) - DC 6204
9. Trigeminal Neuralgia - DC 8210

#### Musculoskeletal (14 conditions)
1. Lumbar Strain (Lower Back) - DC 5237
2. Cervical Strain (Neck) - DC 5290
3. Degenerative Disc Disease - DC 5242
4. Knee Condition (General) - DC 5257
5. Shoulder Condition (General) - DC 5201
6. Hip Condition - DC 5252
7. Ankle Condition - DC 5271
8. Fibromyalgia - DC 5025
9. Sciatica - DC 5293
10. Carpal Tunnel Syndrome - DC 8515
11. Plantar Fasciitis - DC 5276
12. Rotator Cuff Tear - DC 5203
13. Tendonitis - DC 5270
14. Scoliosis - DC 5291

#### Mental Health (10 conditions)
1. Post-Traumatic Stress Disorder (PTSD) - DC 9411
2. Major Depressive Disorder - DC 9434
3. Generalized Anxiety Disorder - DC 9400
4. Bipolar Disorder - DC 9432
5. Panic Disorder - DC 9412
6. Obsessive-Compulsive Disorder (OCD) - DC 9404
7. Insomnia (Sleep Disorder) - DC 9435
8. Adjustment Disorder - DC 9440
9. Social Anxiety Disorder - DC 9413
10. Eating Disorder - DC 9520

#### Respiratory (8 conditions)
1. Asthma - DC 6602
2. Chronic Obstructive Pulmonary Disease (COPD) - DC 6604
3. Sleep Apnea - DC 6847
4. Sinusitis (Chronic) - DC 6510
5. Rhinitis (Allergic) - DC 6522
6. Bronchitis (Chronic) - DC 6600
7. Pulmonary Fibrosis - DC 6825
8. Sarcoidosis - DC 6845

#### Endocrine (5 conditions)
1. Diabetes Mellitus Type II - DC 7913
2. Hypothyroidism - DC 7903
3. Diabetes Mellitus Type I - DC 7914
4. Addison's Disease - DC 7911
5. Cushing's Syndrome - DC 7907

#### Gastrointestinal (6 conditions)
1. Gastroesophageal Reflux Disease (GERD) - DC 7346
2. Irritable Bowel Syndrome (IBS) - DC 7319
3. Gastritis - DC 7304
4. Peptic Ulcer Disease - DC 7305
5. Diverticulitis - DC 7327
6. Hemorrhoids - DC 7336

#### Dermatological (5 conditions)
1. Eczema (Atopic Dermatitis) - DC 7806
2. Acne (Severe) - DC 7800
3. Scars (Disfiguring) - DC 7805
4. Vitiligo - DC 7823
5. Rosacea - DC 7828

#### Genitourinary (6 conditions)
1. Chronic Kidney Disease - DC 7507
2. Erectile Dysfunction - DC 7522
3. Interstitial Cystitis - DC 7515
4. Prostatitis - DC 7527
5. Urinary Incontinence - DC 7542
6. Kidney Stones - DC 7508

#### Auditory (4 conditions)
1. Tinnitus - DC 6260
2. Hearing Loss (Sensorineural) - DC 6100
3. Meniere's Disease - DC 6205
4. Otitis Media (Chronic) - DC 6201

#### Visual (5 conditions)
1. Cataracts - DC 6025
2. Glaucoma - DC 6067
3. Macular Degeneration - DC 6077
4. Retinal Detachment - DC 6080
5. Diabetic Retinopathy - DC 6066

#### Cancer (5 conditions)
1. Prostate Cancer - DC 7528
2. Lung Cancer - DC 6819
3. Breast Cancer - DC 7626
4. Colon Cancer - DC 7343
5. Melanoma - DC 7829

#### Infectious Disease (4 conditions)
1. Hepatitis C - DC 7354
2. Tuberculosis - DC 6730
3. HIV/AIDS - DC 6351
4. Lyme Disease (Chronic) - DC 6329

#### Other (4 conditions)
1. Gulf War Syndrome - DC 6354
2. Burn Injuries - DC 7801
3. Agent Orange Exposure Effects - DC 6320
4. Chronic Fatigue Syndrome - DC 6355

## Data Quality

✅ **All DC codes are unique**  
✅ **All conditions have valid category associations**  
✅ **All rating percentages are valid integer arrays**  
✅ **Comprehensive descriptions for each condition**  

## Next Steps

1. Run the seed file in Supabase (see `README.md`)
2. Generate vector embeddings for semantic search (Step 5)
3. Create secondary condition relationships (Step 6)
