-- Seed data for VetBens Foundation
-- Run this script after running 001_initial_schema.sql

-- ============================================
-- CATEGORIES
-- ============================================
-- Insert 15 comprehensive disability categories

INSERT INTO categories (name, slug, description) VALUES
  ('Autoimmune', 'autoimmune', 'Conditions where the immune system attacks the body''s own tissues'),
  ('Cardiovascular', 'cardiovascular', 'Heart and blood vessel related conditions'),
  ('Neurological', 'neurological', 'Conditions affecting the brain, spinal cord, and nervous system'),
  ('Musculoskeletal', 'musculoskeletal', 'Conditions affecting bones, muscles, joints, and connective tissues'),
  ('Mental Health', 'mental-health', 'Psychiatric and psychological conditions including PTSD, depression, and anxiety'),
  ('Respiratory', 'respiratory', 'Conditions affecting lungs and breathing'),
  ('Endocrine', 'endocrine', 'Hormonal and metabolic disorders including diabetes and thyroid conditions'),
  ('Gastrointestinal', 'gastrointestinal', 'Digestive system conditions affecting stomach, intestines, and related organs'),
  ('Dermatological', 'dermatological', 'Skin conditions and disorders'),
  ('Genitourinary', 'genitourinary', 'Conditions affecting kidneys, bladder, and reproductive organs'),
  ('Auditory', 'auditory', 'Hearing loss, tinnitus, and ear-related conditions'),
  ('Visual', 'visual', 'Eye conditions and vision impairments'),
  ('Cancer', 'cancer', 'Malignant neoplasms and cancer-related conditions'),
  ('Infectious Disease', 'infectious-disease', 'Conditions caused by bacterial, viral, or parasitic infections'),
  ('Other', 'other', 'Conditions not classified in other categories')
ON CONFLICT (slug) DO NOTHING;

-- ============================================
-- VSO ORGANIZATIONS
-- ============================================
-- Insert major Veteran Service Organizations

INSERT INTO vso_organizations (name, abbreviation, description, website_url, logo_url) VALUES
  (
    'Disabled American Veterans',
    'DAV',
    'The DAV provides free, professional assistance to veterans and their families in obtaining benefits and services earned through military service. With a nationwide network of service officers, DAV helps veterans file claims, gather evidence, and navigate the VA system.',
    'https://www.dav.org',
    NULL
  ),
  (
    'The American Legion',
    'TAL',
    'The American Legion is the nation''s largest wartime veterans service organization, committed to mentoring youth and sponsorship of wholesome programs in communities, advocating patriotism and honor, promoting strong national security, and continued devotion to fellow servicemembers and veterans.',
    'https://www.legion.org',
    NULL
  ),
  (
    'Veterans of Foreign Wars',
    'VFW',
    'The VFW is dedicated to ensuring that veterans are respected for their service, always receive their earned entitlements, and are recognized for the sacrifices they and their loved ones have made on behalf of this great country. VFW provides claims assistance and representation.',
    'https://www.vfw.org',
    NULL
  ),
  (
    'American Veterans',
    'AMVETS',
    'AMVETS has been helping veterans since 1944, providing support for veterans and their families through service programs, legislative advocacy, and community outreach. They offer free assistance with VA claims and benefits.',
    'https://www.amvets.org',
    NULL
  ),
  (
    'Veterans of America',
    'VVA',
    'Vietnam Veterans of America is the only national Vietnam veterans organization chartered by Congress. VVA is dedicated to the needs of Vietnam-era veterans and their families, offering claims assistance and advocacy.',
    'https://vva.org',
    NULL
  ),
  (
    'Paralyzed Veterans of America',
    'PVA',
    'PVA is the only congressionally chartered veterans service organization dedicated solely to the benefit and representation of veterans with spinal cord injury or disease. They provide free claims assistance and advocacy.',
    'https://www.pva.org',
    NULL
  )
ON CONFLICT (abbreviation) DO NOTHING;

-- ============================================
-- CONDITIONS
-- ============================================
-- Insert comprehensive VA disability conditions with DC codes

-- AUTOIMMUNE CONDITIONS
INSERT INTO conditions (name, dc_code, description, category_id, rating_percentages) VALUES
  ('Lupus (Systemic Lupus Erythematosus)', 'DC 6350', 'Chronic autoimmune disease that can affect multiple organ systems including skin, joints, kidneys, brain, heart, and lungs. Characterized by periods of illness (flares) and remission.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 30, 60, 100]),
  ('Rheumatoid Arthritis', 'DC 5002', 'Chronic inflammatory disorder affecting joints, causing painful swelling that can result in bone erosion and joint deformity. Can also affect other body systems.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 20, 40, 60, 100]),
  ('Multiple Sclerosis', 'DC 8018', 'Autoimmune disease affecting the brain and spinal cord where the immune system attacks the protective sheath (myelin) covering nerve fibers. Causes communication problems between brain and body.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 30, 50, 70, 100]),
  ('Crohn''s Disease', 'DC 7323', 'Type of inflammatory bowel disease causing inflammation of the digestive tract, leading to abdominal pain, severe diarrhea, fatigue, weight loss, and malnutrition.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 30, 40, 60, 100]),
  ('Ulcerative Colitis', 'DC 7324', 'Inflammatory bowel disease causing long-lasting inflammation and ulcers in the digestive tract, affecting the innermost lining of the large intestine and rectum.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 20, 30, 40, 50, 60, 100]),
  ('Psoriasis', 'DC 7816', 'Chronic autoimmune condition causing rapid buildup of skin cells resulting in scaling on the skin surface. Inflammation and redness around the scales are common.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 20, 30, 60]),
  ('Graves Disease', 'DC 7900', 'Autoimmune disorder causing overactive thyroid (hyperthyroidism), leading to increased metabolism, weight loss, rapid heartbeat, and anxiety.', (SELECT id FROM categories WHERE slug = 'autoimmune'), ARRAY[10, 30, 60, 100]),

-- CARDIOVASCULAR CONDITIONS
  ('Ischemic Heart Disease', 'DC 7005', 'Reduced blood supply to the heart muscle, usually due to coronary artery disease. Can lead to chest pain (angina) and heart attacks.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 30, 60, 100]),
  ('Hypertension (High Blood Pressure)', 'DC 7101', 'Condition where blood pressure in arteries is persistently elevated, increasing risk of heart disease, stroke, and kidney disease.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 20, 40, 60]),
  ('Heart Failure', 'DC 7007', 'Chronic condition where the heart cannot pump enough blood to meet the body''s needs, causing fatigue, shortness of breath, and fluid retention.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 30, 60, 100]),
  ('Arrhythmia', 'DC 7010', 'Irregular heartbeat that can be too fast, too slow, or erratic, potentially affecting blood flow to organs and causing various symptoms.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 30, 60, 100]),
  ('Peripheral Vascular Disease', 'DC 7117', 'Circulatory condition where narrowed blood vessels reduce blood flow to limbs, causing pain, numbness, and increased risk of infection.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 20, 40, 60, 100]),
  ('Deep Vein Thrombosis', 'DC 7121', 'Blood clot formation in deep veins, usually in legs, potentially causing pain, swelling, and risk of pulmonary embolism if clot travels to lungs.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 40, 60, 100]),

-- NEUROLOGICAL CONDITIONS
  ('Traumatic Brain Injury (TBI)', 'DC 8045', 'Brain injury from external force causing temporary or permanent impairment of cognitive, physical, and psychosocial functions.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[0, 10, 40, 70, 100]),
  ('Migraine Headaches', 'DC 8100', 'Recurrent severe headaches often accompanied by nausea, vomiting, and sensitivity to light and sound, significantly impacting daily activities.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[0, 10, 30, 50]),
  ('Peripheral Neuropathy', 'DC 8520', 'Damage to peripheral nerves causing weakness, numbness, and pain, usually in hands and feet, often from diabetes or toxic exposures.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 20, 40, 60]),
  ('Radiculopathy', 'DC 8610', 'Nerve root compression causing radiating pain, numbness, tingling, and weakness along the affected nerve pathway, commonly in neck or lower back.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 20, 40, 60]),
  ('Epilepsy', 'DC 8910', 'Neurological disorder causing recurrent seizures due to sudden bursts of electrical activity in the brain, varying in severity and frequency.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 20, 40, 60, 80, 100]),
  ('Parkinson''s Disease', 'DC 8004', 'Progressive nervous system disorder affecting movement, causing tremors, stiffness, slowed movement, and balance problems.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 30, 50, 70, 100]),
  ('Bell''s Palsy', 'DC 8207', 'Sudden weakness or paralysis of facial muscles on one side of the face, usually temporary but can cause significant functional impairment.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 20, 30, 40, 50]),

-- MUSCULOSKELETAL CONDITIONS
  ('Lumbar Strain (Lower Back)', 'DC 5237', 'Injury to muscles and ligaments of the lower back causing pain, stiffness, and limited range of motion, often from lifting or trauma.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 40, 60, 100]),
  ('Cervical Strain (Neck)', 'DC 5290', 'Neck injury affecting muscles and ligaments, causing pain, stiffness, headaches, and reduced neck mobility.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40, 50, 60]),
  ('Degenerative Disc Disease', 'DC 5242', 'Age-related wear and tear on spinal discs causing chronic back pain, nerve compression, and reduced flexibility.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 40, 60, 100]),
  ('Knee Condition (General)', 'DC 5257', 'Various knee disorders including ligament damage, cartilage tears, and arthritis causing pain, instability, and limited mobility.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40, 50, 60]),
  ('Shoulder Condition (General)', 'DC 5201', 'Shoulder problems including rotator cuff tears, impingement, and arthritis causing pain, weakness, and limited range of motion.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40, 50]),
  ('Hip Condition', 'DC 5252', 'Hip joint problems including arthritis, labral tears, and bursitis causing pain, stiffness, and difficulty walking.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40, 50, 60]),
  ('Ankle Condition', 'DC 5271', 'Ankle injuries and disorders including sprains, fractures, and arthritis affecting mobility and stability.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40]),
  ('Fibromyalgia', 'DC 5025', 'Chronic widespread musculoskeletal pain accompanied by fatigue, sleep problems, memory issues, and mood disturbances.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 40]),
  ('Sciatica', 'DC 5293', 'Pain radiating along sciatic nerve from lower back through hips and down each leg, often caused by herniated disc or bone spur.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 40, 60, 80, 100]),
  ('Carpal Tunnel Syndrome', 'DC 8515', 'Nerve compression in wrist causing numbness, tingling, and weakness in hand and arm, often from repetitive motions.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30]),

-- MENTAL HEALTH CONDITIONS
  ('Post-Traumatic Stress Disorder (PTSD)', 'DC 9411', 'Mental health condition triggered by experiencing or witnessing traumatic events, causing flashbacks, nightmares, severe anxiety, and uncontrollable thoughts.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50, 70, 100]),
  ('Major Depressive Disorder', 'DC 9434', 'Persistent feeling of sadness and loss of interest affecting daily activities, sleep, appetite, energy, and concentration.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50, 70, 100]),
  ('Generalized Anxiety Disorder', 'DC 9400', 'Excessive, persistent worry about various aspects of life, causing physical symptoms like restlessness, fatigue, and difficulty concentrating.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50, 70, 100]),
  ('Bipolar Disorder', 'DC 9432', 'Mental illness causing extreme mood swings including emotional highs (mania) and lows (depression), affecting energy and judgment.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[10, 30, 50, 70, 100]),
  ('Panic Disorder', 'DC 9412', 'Recurrent unexpected panic attacks with intense fear and physical symptoms like rapid heartbeat, sweating, and trembling.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50, 70, 100]),
  ('Obsessive-Compulsive Disorder (OCD)', 'DC 9404', 'Characterized by unreasonable thoughts and fears (obsessions) leading to repetitive behaviors (compulsions) that interfere with daily activities.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[10, 30, 50, 70, 100]),
  ('Insomnia (Sleep Disorder)', 'DC 9435', 'Persistent difficulty falling asleep or staying asleep, leading to fatigue, mood disturbances, and impaired daytime functioning.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50, 70, 100]),
  ('Adjustment Disorder', 'DC 9440', 'Emotional or behavioral symptoms in response to identifiable stressor, causing significant distress disproportionate to the stressor.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50]),

-- RESPIRATORY CONDITIONS
  ('Asthma', 'DC 6602', 'Chronic condition causing inflammation and narrowing of airways, leading to wheezing, shortness of breath, chest tightness, and coughing.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[10, 30, 60, 100]),
  ('Chronic Obstructive Pulmonary Disease (COPD)', 'DC 6604', 'Progressive lung disease causing breathing difficulties due to airflow obstruction, including chronic bronchitis and emphysema.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[10, 30, 60, 100]),
  ('Sleep Apnea', 'DC 6847', 'Serious sleep disorder where breathing repeatedly stops and starts during sleep, leading to fatigue and other health complications.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[0, 30, 50, 100]),
  ('Sinusitis (Chronic)', 'DC 6510', 'Long-term inflammation of sinuses causing facial pain, nasal congestion, headaches, and reduced sense of smell.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[0, 10, 30, 50]),
  ('Rhinitis (Allergic)', 'DC 6522', 'Allergic inflammation of nasal passages causing sneezing, runny nose, congestion, and itchy eyes.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[10, 30]),
  ('Bronchitis (Chronic)', 'DC 6600', 'Long-term inflammation of bronchial tubes causing persistent cough with mucus production and breathing difficulties.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[10, 30, 60, 100]),

-- ENDOCRINE CONDITIONS
  ('Diabetes Mellitus Type II', 'DC 7913', 'Chronic condition affecting how body processes blood sugar (glucose), leading to high blood sugar levels and various complications.', (SELECT id FROM categories WHERE slug = 'endocrine'), ARRAY[10, 20, 40, 60, 100]),
  ('Hypothyroidism', 'DC 7903', 'Underactive thyroid gland not producing enough thyroid hormone, causing fatigue, weight gain, cold sensitivity, and depression.', (SELECT id FROM categories WHERE slug = 'endocrine'), ARRAY[10, 30, 60, 100]),
  ('Diabetes Mellitus Type I', 'DC 7914', 'Chronic autoimmune condition where pancreas produces little or no insulin, requiring lifelong insulin therapy and careful glucose monitoring.', (SELECT id FROM categories WHERE slug = 'endocrine'), ARRAY[10, 20, 40, 60, 80, 100]),
  ('Addison''s Disease', 'DC 7911', 'Rare disorder where adrenal glands don''t produce enough cortisol and aldosterone, causing fatigue, muscle weakness, and low blood pressure.', (SELECT id FROM categories WHERE slug = 'endocrine'), ARRAY[10, 30, 60, 100]),
  ('Cushing''s Syndrome', 'DC 7907', 'Condition caused by prolonged exposure to high cortisol levels, leading to weight gain, high blood pressure, and muscle weakness.', (SELECT id FROM categories WHERE slug = 'endocrine'), ARRAY[10, 30, 60, 100]),

-- GASTROINTESTINAL CONDITIONS
  ('Gastroesophageal Reflux Disease (GERD)', 'DC 7346', 'Chronic digestive condition where stomach acid flows back into esophagus, causing heartburn, chest pain, and difficulty swallowing.', (SELECT id FROM categories WHERE slug = 'gastrointestinal'), ARRAY[10, 30, 60]),
  ('Irritable Bowel Syndrome (IBS)', 'DC 7319', 'Common intestinal disorder causing cramping, abdominal pain, bloating, gas, diarrhea, and constipation.', (SELECT id FROM categories WHERE slug = 'gastrointestinal'), ARRAY[0, 10, 30]),
  ('Gastritis', 'DC 7304', 'Inflammation of stomach lining causing nausea, vomiting, and upper abdominal pain or discomfort.', (SELECT id FROM categories WHERE slug = 'gastrointestinal'), ARRAY[10, 30, 60]),
  ('Peptic Ulcer Disease', 'DC 7305', 'Open sores that develop on inner lining of stomach and upper portion of small intestine, causing abdominal pain and bleeding.', (SELECT id FROM categories WHERE slug = 'gastrointestinal'), ARRAY[10, 20, 40, 60, 100]),
  ('Diverticulitis', 'DC 7327', 'Inflammation or infection of small pouches (diverticula) in digestive tract, causing severe abdominal pain, fever, and nausea.', (SELECT id FROM categories WHERE slug = 'gastrointestinal'), ARRAY[10, 20, 30, 40, 50]),
  ('Hemorrhoids', 'DC 7336', 'Swollen veins in lower rectum and anus causing discomfort, bleeding, and pain during bowel movements.', (SELECT id FROM categories WHERE slug = 'gastrointestinal'), ARRAY[0, 10, 20]),

-- DERMATOLOGICAL CONDITIONS
  ('Eczema (Atopic Dermatitis)', 'DC 7806', 'Chronic skin condition causing itchy, red, inflamed skin patches that can crack and bleed.', (SELECT id FROM categories WHERE slug = 'dermatological'), ARRAY[10, 30, 60]),
  ('Acne (Severe)', 'DC 7800', 'Chronic inflammatory skin condition causing pimples, nodules, cysts, and scarring, primarily on face, chest, and back.', (SELECT id FROM categories WHERE slug = 'dermatological'), ARRAY[10, 30, 60]),
  ('Scars (Disfiguring)', 'DC 7805', 'Permanent marks on skin from injury, surgery, or burns that may cause functional or cosmetic impairment.', (SELECT id FROM categories WHERE slug = 'dermatological'), ARRAY[10, 20, 30, 40, 50, 60, 80]),
  ('Vitiligo', 'DC 7823', 'Condition causing loss of skin color in patches due to destruction of pigment-producing cells.', (SELECT id FROM categories WHERE slug = 'dermatological'), ARRAY[10, 20, 30, 40, 50, 60]),
  ('Rosacea', 'DC 7828', 'Chronic skin condition causing facial redness, visible blood vessels, and sometimes acne-like bumps.', (SELECT id FROM categories WHERE slug = 'dermatological'), ARRAY[10, 30]),

-- GENITOURINARY CONDITIONS
  ('Chronic Kidney Disease', 'DC 7507', 'Gradual loss of kidney function over time, affecting ability to filter waste and excess fluids from blood.', (SELECT id FROM categories WHERE slug = 'genitourinary'), ARRAY[10, 30, 60, 80, 100]),
  ('Erectile Dysfunction', 'DC 7522', 'Inability to achieve or maintain erection sufficient for sexual intercourse, affecting quality of life and relationships.', (SELECT id FROM categories WHERE slug = 'genitourinary'), ARRAY[0, 20]),
  ('Interstitial Cystitis', 'DC 7515', 'Chronic bladder condition causing bladder pressure, pelvic pain, and frequent urgent urination.', (SELECT id FROM categories WHERE slug = 'genitourinary'), ARRAY[10, 20, 30, 40, 50]),
  ('Prostatitis', 'DC 7527', 'Inflammation of prostate gland causing painful urination, pelvic pain, and flu-like symptoms.', (SELECT id FROM categories WHERE slug = 'genitourinary'), ARRAY[10, 20, 30, 40, 50]),
  ('Urinary Incontinence', 'DC 7542', 'Loss of bladder control leading to involuntary urine leakage, affecting daily activities and quality of life.', (SELECT id FROM categories WHERE slug = 'genitourinary'), ARRAY[10, 20, 40, 60]),
  ('Kidney Stones', 'DC 7508', 'Hard mineral deposits forming in kidneys causing severe pain, nausea, and blood in urine when passing through urinary tract.', (SELECT id FROM categories WHERE slug = 'genitourinary'), ARRAY[10, 20, 30]),

-- AUDITORY CONDITIONS
  ('Tinnitus', 'DC 6260', 'Perception of ringing, buzzing, or other sounds in ears without external source, ranging from mild annoyance to severe disability.', (SELECT id FROM categories WHERE slug = 'auditory'), ARRAY[0, 10]),
  ('Hearing Loss (Sensorineural)', 'DC 6100', 'Permanent hearing loss due to damage to inner ear or nerve pathways, affecting ability to understand speech and perceive sounds.', (SELECT id FROM categories WHERE slug = 'auditory'), ARRAY[0, 10, 30, 50, 70, 100]),
  ('Meniere''s Disease', 'DC 6205', 'Inner ear disorder causing episodes of vertigo, hearing loss, tinnitus, and feeling of fullness in the ear.', (SELECT id FROM categories WHERE slug = 'auditory'), ARRAY[30, 60, 100]),
  ('Otitis Media (Chronic)', 'DC 6201', 'Persistent or recurrent middle ear infection causing hearing loss, ear pain, and drainage.', (SELECT id FROM categories WHERE slug = 'auditory'), ARRAY[0, 10]),

-- VISUAL CONDITIONS
  ('Cataracts', 'DC 6025', 'Clouding of eye lens causing blurred vision, difficulty with night driving, and sensitivity to light and glare.', (SELECT id FROM categories WHERE slug = 'visual'), ARRAY[10, 30, 50]),
  ('Glaucoma', 'DC 6067', 'Group of eye conditions damaging optic nerve, often due to high eye pressure, potentially leading to vision loss.', (SELECT id FROM categories WHERE slug = 'visual'), ARRAY[10, 30, 50, 70, 100]),
  ('Macular Degeneration', 'DC 6077', 'Deterioration of central portion of retina affecting central vision, making it difficult to read, drive, or recognize faces.', (SELECT id FROM categories WHERE slug = 'visual'), ARRAY[10, 30, 50, 70, 100]),
  ('Retinal Detachment', 'DC 6080', 'Emergency condition where retina pulls away from supporting tissue, causing vision loss if not treated promptly.', (SELECT id FROM categories WHERE slug = 'visual'), ARRAY[30, 50, 100]),
  ('Diabetic Retinopathy', 'DC 6066', 'Diabetes complication affecting blood vessels in retina, potentially causing vision loss and blindness.', (SELECT id FROM categories WHERE slug = 'visual'), ARRAY[10, 30, 50, 70, 100]),

-- CANCER CONDITIONS
  ('Prostate Cancer', 'DC 7528', 'Cancer forming in prostate gland, potentially spreading to bones and other organs, requiring monitoring or aggressive treatment.', (SELECT id FROM categories WHERE slug = 'cancer'), ARRAY[30, 60, 100]),
  ('Lung Cancer', 'DC 6819', 'Malignant tumor in lungs causing cough, chest pain, shortness of breath, and potentially spreading to other parts of body.', (SELECT id FROM categories WHERE slug = 'cancer'), ARRAY[30, 60, 100]),
  ('Breast Cancer', 'DC 7626', 'Cancer forming in breast tissue, potentially requiring surgery, chemotherapy, and radiation treatment.', (SELECT id FROM categories WHERE slug = 'cancer'), ARRAY[30, 50, 80, 100]),
  ('Colon Cancer', 'DC 7343', 'Cancer of large intestine or rectum, potentially causing changes in bowel habits, bleeding, and abdominal pain.', (SELECT id FROM categories WHERE slug = 'cancer'), ARRAY[30, 60, 100]),
  ('Melanoma', 'DC 7829', 'Serious type of skin cancer developing in melanocytes, potentially spreading to other organs if not treated early.', (SELECT id FROM categories WHERE slug = 'cancer'), ARRAY[10, 30, 60, 100]),

-- INFECTIOUS DISEASE CONDITIONS
  ('Hepatitis C', 'DC 7354', 'Viral infection causing liver inflammation, potentially leading to cirrhosis and liver failure without treatment.', (SELECT id FROM categories WHERE slug = 'infectious-disease'), ARRAY[10, 20, 40, 60, 80, 100]),
  ('Tuberculosis', 'DC 6730', 'Bacterial infection primarily affecting lungs, causing cough, fever, weight loss, and potentially spreading to other organs.', (SELECT id FROM categories WHERE slug = 'infectious-disease'), ARRAY[10, 30, 50, 100]),
  ('HIV/AIDS', 'DC 6351', 'Virus attacking immune system, potentially progressing to AIDS if untreated, increasing susceptibility to infections and certain cancers.', (SELECT id FROM categories WHERE slug = 'infectious-disease'), ARRAY[10, 30, 60, 100]),
  ('Lyme Disease (Chronic)', 'DC 6329', 'Tick-borne illness potentially causing long-term symptoms including joint pain, neurological problems, and fatigue.', (SELECT id FROM categories WHERE slug = 'infectious-disease'), ARRAY[10, 40, 60, 100]),

-- ADDITIONAL MUSCULOSKELETAL CONDITIONS
  ('Plantar Fasciitis', 'DC 5276', 'Inflammation of thick band of tissue connecting heel bone to toes, causing stabbing heel pain especially with first steps in morning.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40]),
  ('Rotator Cuff Tear', 'DC 5203', 'Tear in shoulder tendons causing pain, weakness, and limited range of motion, often from injury or repetitive overhead motions.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40, 50]),
  ('Tendonitis', 'DC 5270', 'Inflammation or irritation of tendon causing pain and tenderness outside a joint, often from repetitive motion or sudden injury.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20]),
  ('Scoliosis', 'DC 5291', 'Sideways curvature of spine occurring during growth spurt before puberty, potentially causing back pain and breathing difficulties.', (SELECT id FROM categories WHERE slug = 'musculoskeletal'), ARRAY[10, 20, 30, 40, 50, 60, 100]),
  
-- ADDITIONAL MENTAL HEALTH CONDITIONS
  ('Social Anxiety Disorder', 'DC 9413', 'Intense fear of social situations where person may be judged, leading to avoidance of social interactions and significant distress.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[0, 10, 30, 50, 70]),
  ('Eating Disorder', 'DC 9520', 'Serious conditions related to persistent eating behaviors that negatively impact health, emotions, and ability to function.', (SELECT id FROM categories WHERE slug = 'mental-health'), ARRAY[10, 30, 60]),

-- ADDITIONAL RESPIRATORY CONDITIONS
  ('Pulmonary Fibrosis', 'DC 6825', 'Lung disease where lung tissue becomes damaged and scarred, making it difficult for lungs to work properly.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[10, 30, 60, 100]),
  ('Sarcoidosis', 'DC 6845', 'Inflammatory disease affecting multiple organs, most commonly lungs and lymph nodes, causing granulomas to form.', (SELECT id FROM categories WHERE slug = 'respiratory'), ARRAY[10, 30, 60, 100]),

-- ADDITIONAL NEUROLOGICAL CONDITIONS
  ('Vertigo (Vestibular Disorder)', 'DC 6204', 'Sensation of spinning or dizziness caused by inner ear or brain problems, affecting balance and coordination.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 30]),
  ('Trigeminal Neuralgia', 'DC 8210', 'Chronic pain condition affecting trigeminal nerve causing extreme, sudden facial pain triggered by mild stimulation.', (SELECT id FROM categories WHERE slug = 'neurological'), ARRAY[10, 30, 50, 70]),

-- ADDITIONAL CARDIOVASCULAR CONDITIONS
  ('Varicose Veins', 'DC 7120', 'Enlarged, twisted veins often in legs causing aching pain, heavy feeling, and swelling in lower legs.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[0, 10, 20, 30, 40, 50, 60, 100]),
  ('Atherosclerosis', 'DC 7115', 'Buildup of fats, cholesterol and other substances in and on artery walls, potentially restricting blood flow.', (SELECT id FROM categories WHERE slug = 'cardiovascular'), ARRAY[10, 20, 30, 40, 50, 60, 100]),

-- OTHER CONDITIONS
  ('Gulf War Syndrome', 'DC 6354', 'Cluster of medically unexplained symptoms affecting Gulf War veterans, including fatigue, headaches, joint pain, and cognitive problems.', (SELECT id FROM categories WHERE slug = 'other'), ARRAY[10, 30, 50, 70, 100]),
  ('Burn Injuries', 'DC 7801', 'Tissue damage from heat, chemicals, electricity, or radiation, potentially causing scarring, pain, and functional limitations.', (SELECT id FROM categories WHERE slug = 'other'), ARRAY[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]),
  ('Agent Orange Exposure Effects', 'DC 6320', 'Health conditions resulting from exposure to herbicide Agent Orange, including various cancers, diabetes, and other chronic diseases.', (SELECT id FROM categories WHERE slug = 'other'), ARRAY[10, 30, 60, 100]),
  ('Chronic Fatigue Syndrome', 'DC 6355', 'Complex disorder characterized by extreme fatigue not improved by rest, often worsened by physical or mental activity.', (SELECT id FROM categories WHERE slug = 'other'), ARRAY[10, 40, 60, 100])
ON CONFLICT (dc_code) DO NOTHING;

-- Verify the inserts
DO $$
DECLARE
  category_count INTEGER;
  vso_count INTEGER;
  condition_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO category_count FROM categories;
  SELECT COUNT(*) INTO vso_count FROM vso_organizations;
  SELECT COUNT(*) INTO condition_count FROM conditions;
  
  RAISE NOTICE 'Categories inserted: %', category_count;
  RAISE NOTICE 'VSO Organizations inserted: %', vso_count;
  RAISE NOTICE 'Conditions inserted: %', condition_count;
  
  IF category_count < 13 THEN
    RAISE WARNING 'Expected at least 13 categories, but found %', category_count;
  END IF;
  
  IF vso_count < 3 THEN
    RAISE WARNING 'Expected at least 3 VSO organizations, but found %', vso_count;
  END IF;
  
  IF condition_count < 50 THEN
    RAISE WARNING 'Expected at least 50 conditions, but found %', condition_count;
  END IF;
  
  -- Verify all conditions have valid category_id
  DECLARE
    invalid_category_count INTEGER;
  BEGIN
    SELECT COUNT(*) INTO invalid_category_count 
    FROM conditions 
    WHERE category_id IS NULL;
    
    IF invalid_category_count > 0 THEN
      RAISE WARNING 'Found % conditions with NULL category_id', invalid_category_count;
    END IF;
  END;
  
  -- Verify all DC codes are unique
  DECLARE
    duplicate_dc_codes INTEGER;
  BEGIN
    SELECT COUNT(*) INTO duplicate_dc_codes
    FROM (
      SELECT dc_code 
      FROM conditions 
      GROUP BY dc_code 
      HAVING COUNT(*) > 1
    ) duplicates;
    
    IF duplicate_dc_codes > 0 THEN
      RAISE WARNING 'Found % duplicate DC codes', duplicate_dc_codes;
    END IF;
  END;
  
  -- Show breakdown by category
  RAISE NOTICE '--- Conditions by Category ---';
  FOR rec IN 
    SELECT c.name, COUNT(co.id) as count 
    FROM categories c 
    LEFT JOIN conditions co ON c.id = co.category_id 
    GROUP BY c.name 
    ORDER BY count DESC
  LOOP
    RAISE NOTICE 'Category: % - Conditions: %', rec.name, rec.count;
  END LOOP;
END $$;
