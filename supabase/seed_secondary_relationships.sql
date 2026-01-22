-- ============================================
-- SECONDARY RELATIONSHIPS SEED DATA
-- ============================================
-- This file contains medically-documented secondary condition relationships
-- based on VA disability claim research and medical literature.
--
-- Run this script after seed.sql to populate secondary relationships.
--
-- Connection Strength Definitions:
-- - 'strong': Well-established medical connection with substantial evidence
-- - 'moderate': Documented connection with good supporting evidence
-- - 'weak': Possible connection with limited or emerging evidence
--
-- Evidence levels are based on medical research and VA claim precedents.
-- ============================================

-- ============================================
-- PTSD SECONDARY CONDITIONS
-- ============================================
-- PTSD is known to cause or aggravate numerous mental and physical conditions

INSERT INTO secondary_relationships (primary_condition_id, secondary_condition_id, connection_strength, potential_rating_range, explanation, evidence_level) VALUES

-- PTSD → Major Depressive Disorder
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'strong', 
 '0-100%', 
 'PTSD frequently co-occurs with depression due to shared neurobiological pathways, chronic stress, and trauma processing difficulties. Studies show 50-80% of veterans with PTSD also experience major depression.',
 'High - Multiple peer-reviewed studies'),

-- PTSD → Generalized Anxiety Disorder
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'strong', 
 '0-100%', 
 'Anxiety disorders commonly develop alongside PTSD as both involve heightened fear responses, hypervigilance, and stress regulation problems. The conditions share overlapping diagnostic criteria and treatment approaches.',
 'High - Established comorbidity'),

-- PTSD → Insomnia
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9435'), 
 'strong', 
 '0-100%', 
 'Sleep disturbances including insomnia, nightmares, and poor sleep quality are core symptoms of PTSD. Hyperarousal and intrusive memories significantly disrupt normal sleep patterns.',
 'High - Core PTSD symptom'),

-- PTSD → Panic Disorder
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9412'), 
 'strong', 
 '0-100%', 
 'PTSD-related hyperarousal and trauma triggers can precipitate panic attacks. Both conditions involve dysregulated fear responses and heightened anxiety sensitivity.',
 'High - Well-documented association'),

-- PTSD → Irritable Bowel Syndrome
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7319'), 
 'moderate', 
 '0-30%', 
 'Chronic stress from PTSD affects the gut-brain axis, leading to IBS symptoms. Studies show veterans with PTSD have significantly higher IBS rates than general population.',
 'Moderate - Growing research evidence'),

-- PTSD → Migraine Headaches
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8100'), 
 'moderate', 
 '0-50%', 
 'PTSD-related stress, muscle tension, and sleep disruption can trigger or worsen migraines. Shared neurobiological factors include serotonin dysregulation and central sensitization.',
 'Moderate - Multiple studies'),

-- PTSD → Erectile Dysfunction
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7522'), 
 'moderate', 
 '0-20%', 
 'PTSD medications (SSRIs), psychological stress, depression, and relationship difficulties can all contribute to erectile dysfunction. Studies show 2-3x higher rates in veterans with PTSD.',
 'Moderate - Well-documented in veteran populations'),

-- PTSD → Sleep Apnea
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 'moderate', 
 '0-100%', 
 'PTSD-related sleep fragmentation, nightmares, and chronic stress may contribute to sleep apnea development. Some research suggests shared risk factors and bidirectional relationship.',
 'Moderate - Emerging evidence'),

-- PTSD → Hypertension
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 'moderate', 
 '10-60%', 
 'Chronic stress and hyperarousal from PTSD activate the sympathetic nervous system, leading to sustained elevation in blood pressure. PTSD is recognized as a cardiovascular risk factor.',
 'Moderate - Cardiovascular research'),

-- PTSD → GERD
((SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7346'), 
 'weak', 
 '10-60%', 
 'Stress from PTSD can increase stomach acid production and affect esophageal sphincter function. Some medications for PTSD may also contribute to GERD symptoms.',
 'Low - Limited direct evidence'),

-- ============================================
-- TRAUMATIC BRAIN INJURY (TBI) SECONDARY CONDITIONS
-- ============================================

-- TBI → Migraine Headaches
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8100'), 
 'strong', 
 '0-50%', 
 'Post-traumatic headaches and migraines are among the most common sequelae of TBI, occurring in 30-90% of cases. Brain injury can cause chronic changes to pain processing and vascular regulation.',
 'High - Extremely common post-TBI'),

-- TBI → PTSD
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 'strong', 
 '0-100%', 
 'TBI and PTSD frequently co-occur in combat veterans and share overlapping symptoms. Brain injury can impair emotional regulation and increase vulnerability to trauma-related disorders.',
 'High - Common comorbidity in veterans'),

-- TBI → Major Depressive Disorder
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'strong', 
 '0-100%', 
 'Depression occurs in 25-50% of TBI patients due to neurological damage affecting mood regulation, as well as psychological adjustment to injury-related changes.',
 'High - Well-established'),

-- TBI → Tinnitus
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6260'), 
 'moderate', 
 '10%', 
 'TBI can damage auditory processing centers in the brain, leading to tinnitus even without direct ear injury. Common in blast-related TBI.',
 'Moderate - Documented in blast injuries'),

-- TBI → Sleep Apnea
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 'moderate', 
 '0-100%', 
 'TBI can affect brainstem areas controlling breathing during sleep. Studies show higher sleep apnea rates in TBI patients compared to general population.',
 'Moderate - Research evidence'),

-- TBI → Vertigo
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6204'), 
 'strong', 
 '10-100%', 
 'Vestibular dysfunction is common after TBI due to damage to inner ear structures or central vestibular processing areas. Dizziness and balance problems are frequent post-TBI complaints.',
 'High - Common post-TBI symptom'),

-- TBI → Epilepsy
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8910'), 
 'moderate', 
 '10-100%', 
 'Post-traumatic epilepsy can develop after moderate to severe TBI due to scarring and structural brain changes. Risk increases with severity of initial injury.',
 'Moderate - Documented risk factor'),

-- TBI → Insomnia
((SELECT id FROM conditions WHERE dc_code = 'DC 8045'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9435'), 
 'strong', 
 '0-100%', 
 'Sleep disturbances affect 30-70% of TBI patients due to disruption of circadian rhythms, pain, and neurological changes affecting sleep architecture.',
 'High - Very common post-TBI'),

-- ============================================
-- DIABETES MELLITUS SECONDARY CONDITIONS
-- ============================================

-- Diabetes Type II → Peripheral Neuropathy
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8520'), 
 'strong', 
 '10-60%', 
 'Diabetic neuropathy is one of the most common complications of diabetes, affecting 50% of diabetics. High blood sugar damages nerves, particularly in feet and legs.',
 'High - Major diabetic complication'),

-- Diabetes Type II → Erectile Dysfunction
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7522'), 
 'strong', 
 '0-20%', 
 'Diabetes damages blood vessels and nerves necessary for erections. Studies show 35-75% of diabetic men experience ED, often appearing 10-15 years earlier than non-diabetics.',
 'High - Well-established complication'),

-- Diabetes Type II → Chronic Kidney Disease
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7507'), 
 'strong', 
 '10-100%', 
 'Diabetic nephropathy is a leading cause of chronic kidney disease. Diabetes damages kidney blood vessels and filtering units, progressively reducing kidney function.',
 'High - Leading cause of CKD'),

-- Diabetes Type II → Hypertension
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 'strong', 
 '10-60%', 
 'Diabetes and hypertension commonly co-exist and share risk factors. Diabetes damages blood vessels, increasing blood pressure. Together they significantly increase cardiovascular risk.',
 'High - Common comorbidity'),

-- Diabetes Type II → Peripheral Vascular Disease
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7117'), 
 'strong', 
 '10-100%', 
 'Diabetes accelerates atherosclerosis, leading to reduced blood flow to extremities. Diabetics have 2-4x higher risk of peripheral vascular disease.',
 'High - Major vascular complication'),

-- Diabetes Type II → Ischemic Heart Disease
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7005'), 
 'strong', 
 '10-100%', 
 'Diabetes is a major risk factor for coronary artery disease due to accelerated atherosclerosis, vessel damage, and metabolic changes. Diabetics have 2-4x higher heart disease risk.',
 'High - Major cardiovascular risk factor'),

-- Diabetes Type II → Cataracts
((SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6025'), 
 'moderate', 
 '10-30%', 
 'Diabetes increases cataract risk 2-5 fold due to metabolic changes in the lens. Diabetics develop cataracts earlier and more rapidly than non-diabetics.',
 'Moderate - Established association'),

-- Diabetes Type I → Peripheral Neuropathy
((SELECT id FROM conditions WHERE dc_code = 'DC 7914'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8520'), 
 'strong', 
 '10-60%', 
 'Type I diabetes causes nerve damage through prolonged high blood sugar. Risk increases with duration of disease and poor glycemic control.',
 'High - Common long-term complication'),

-- Diabetes Type I → Chronic Kidney Disease
((SELECT id FROM conditions WHERE dc_code = 'DC 7914'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7507'), 
 'strong', 
 '10-100%', 
 'Diabetic kidney disease develops in 20-40% of Type I diabetics, usually after 15-25 years of disease. Earlier onset and more aggressive management needed than Type II.',
 'High - Significant complication'),

-- ============================================
-- SPINE CONDITIONS → SECONDARY CONDITIONS
-- ============================================

-- Lumbar Strain → Radiculopathy
((SELECT id FROM conditions WHERE dc_code = 'DC 5237'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8610'), 
 'strong', 
 '10-60%', 
 'Lumbar spine injury can lead to nerve root compression from disc herniation, spinal stenosis, or scar tissue formation, causing radiating pain and neurological symptoms.',
 'High - Common progression'),

-- Lumbar Strain → Sciatica
((SELECT id FROM conditions WHERE dc_code = 'DC 5237'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5293'), 
 'strong', 
 '10-100%', 
 'Lower back injury frequently causes sciatic nerve irritation or compression, leading to characteristic leg pain, numbness, and tingling down the sciatic nerve pathway.',
 'High - Direct anatomical relationship'),

-- Lumbar Strain → Knee Condition
((SELECT id FROM conditions WHERE dc_code = 'DC 5237'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5257'), 
 'moderate', 
 '10-60%', 
 'Chronic lower back pain causes altered gait mechanics and compensatory movement patterns, leading to increased knee stress and degenerative changes.',
 'Moderate - Biomechanical relationship'),

-- Lumbar Strain → Hip Condition
((SELECT id FROM conditions WHERE dc_code = 'DC 5237'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5252'), 
 'moderate', 
 '10-60%', 
 'Lower back dysfunction affects pelvic alignment and hip mechanics. Compensatory patterns and referred pain can lead to hip joint problems.',
 'Moderate - Biomechanical connection'),

-- Degenerative Disc Disease → Radiculopathy
((SELECT id FROM conditions WHERE dc_code = 'DC 5242'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8610'), 
 'strong', 
 '10-60%', 
 'Disc degeneration commonly leads to disc herniation, bulging, and spinal stenosis, all of which can compress nerve roots causing radiculopathy.',
 'High - Natural disease progression'),

-- Degenerative Disc Disease → Sciatica
((SELECT id FROM conditions WHERE dc_code = 'DC 5242'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5293'), 
 'strong', 
 '10-100%', 
 'Lumbar disc degeneration frequently compresses or irritates the sciatic nerve through disc herniation or foraminal narrowing.',
 'High - Common complication'),

-- Cervical Strain → Migraine Headaches
((SELECT id FROM conditions WHERE dc_code = 'DC 5290'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8100'), 
 'moderate', 
 '0-50%', 
 'Cervical spine dysfunction can trigger cervicogenic headaches and migraines through muscle tension, nerve irritation, and altered proprioception.',
 'Moderate - Documented trigger'),

-- Cervical Strain → Radiculopathy
((SELECT id FROM conditions WHERE dc_code = 'DC 5290'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 8610'), 
 'strong', 
 '10-60%', 
 'Neck injury can lead to cervical disc herniation or stenosis, compressing nerve roots and causing arm pain, weakness, and numbness.',
 'High - Common progression'),

-- Cervical Strain → Shoulder Condition
((SELECT id FROM conditions WHERE dc_code = 'DC 5290'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5201'), 
 'moderate', 
 '10-50%', 
 'Cervical spine problems affect shoulder mechanics through altered muscle activation, referred pain, and compensatory movement patterns.',
 'Moderate - Biomechanical relationship'),

-- ============================================
-- SLEEP APNEA SECONDARY CONDITIONS
-- ============================================

-- Sleep Apnea → Hypertension
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 'strong', 
 '10-60%', 
 'Sleep apnea causes intermittent hypoxia and sympathetic nervous system activation, leading to sustained blood pressure elevation. 50-70% of sleep apnea patients have hypertension.',
 'High - Well-established mechanism'),

-- Sleep Apnea → Heart Failure
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7007'), 
 'strong', 
 '10-100%', 
 'Repetitive oxygen desaturation and increased cardiac workload from sleep apnea contribute to heart failure development and progression.',
 'High - Recognized cardiovascular complication'),

-- Sleep Apnea → Arrhythmia
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7010'), 
 'strong', 
 '10-100%', 
 'Sleep apnea increases risk of atrial fibrillation and other arrhythmias through autonomic nervous system dysfunction and cardiac remodeling.',
 'High - Established association'),

-- Sleep Apnea → GERD
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7346'), 
 'moderate', 
 '10-60%', 
 'Negative intrathoracic pressure during apneas can promote acid reflux. GERD and sleep apnea frequently co-exist and may have bidirectional relationship.',
 'Moderate - Research evidence'),

-- Sleep Apnea → Type II Diabetes
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7913'), 
 'moderate', 
 '10-100%', 
 'Sleep apnea disrupts glucose metabolism and insulin sensitivity through sleep fragmentation and intermittent hypoxia, increasing diabetes risk.',
 'Moderate - Growing evidence'),

-- Sleep Apnea → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic sleep disruption from sleep apnea significantly impacts mood regulation. Studies show 2-5x higher depression rates in sleep apnea patients.',
 'Moderate - Well-documented comorbidity'),

-- Sleep Apnea → Erectile Dysfunction
((SELECT id FROM conditions WHERE dc_code = 'DC 6847'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7522'), 
 'moderate', 
 '0-20%', 
 'Sleep apnea reduces testosterone levels, disrupts sleep quality, and affects vascular function, all contributing to erectile dysfunction.',
 'Moderate - Multiple mechanisms'),

-- ============================================
-- TINNITUS SECONDARY CONDITIONS
-- ============================================

-- Tinnitus → PTSD
((SELECT id FROM conditions WHERE dc_code = 'DC 6260'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9411'), 
 'moderate', 
 '0-100%', 
 'Chronic tinnitus can be psychologically distressing and may contribute to PTSD development or exacerbation. Some research suggests bidirectional relationship.',
 'Moderate - Complex relationship'),

-- Tinnitus → Insomnia
((SELECT id FROM conditions WHERE dc_code = 'DC 6260'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9435'), 
 'strong', 
 '0-100%', 
 'Tinnitus frequently disrupts sleep onset and maintenance. Studies show 50-70% of tinnitus patients report significant sleep difficulties.',
 'High - Very common complaint'),

-- Tinnitus → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 6260'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic tinnitus distress, sleep disruption, and quality of life impact can lead to depression. 25-50% of severe tinnitus patients experience depression.',
 'Moderate - Well-documented association'),

-- Tinnitus → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 6260'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Persistent tinnitus can cause chronic worry, fear of worsening, and hypervigilance to the sound, contributing to anxiety disorder development.',
 'Moderate - Common psychological impact'),

-- ============================================
-- GERD SECONDARY CONDITIONS
-- ============================================

-- GERD → Asthma
((SELECT id FROM conditions WHERE dc_code = 'DC 7346'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6602'), 
 'moderate', 
 '10-100%', 
 'Acid reflux can trigger bronchospasm and airway inflammation. 30-90% of asthma patients have GERD, which can worsen asthma control.',
 'Moderate - Bidirectional relationship'),

-- GERD → Chronic Sinusitis
((SELECT id FROM conditions WHERE dc_code = 'DC 7346'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 6510'), 
 'weak', 
 '0-50%', 
 'Laryngopharyngeal reflux can irritate upper airways and contribute to chronic sinusitis. Evidence is emerging but not yet definitive.',
 'Low - Limited evidence'),

-- ============================================
-- AUTOIMMUNE CONDITION SECONDARY CONDITIONS
-- ============================================

-- Rheumatoid Arthritis → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 5002'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic pain, disability, and inflammatory cytokines from RA contribute to depression. Studies show 2-3x higher depression rates in RA patients.',
 'Moderate - Common comorbidity'),

-- Rheumatoid Arthritis → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 5002'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Living with progressive RA, treatment uncertainty, and functional limitations commonly lead to anxiety disorders.',
 'Moderate - Documented association'),

-- Rheumatoid Arthritis → Fibromyalgia
((SELECT id FROM conditions WHERE dc_code = 'DC 5002'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5025'), 
 'moderate', 
 '10-40%', 
 'Central pain sensitization from chronic RA inflammation can lead to fibromyalgia. 15-20% of RA patients also have fibromyalgia.',
 'Moderate - Research evidence'),

-- Lupus → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 6350'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Lupus-related inflammation, chronic illness burden, and direct CNS involvement contribute to depression. Rates significantly higher than general population.',
 'Moderate - Common in lupus'),

-- Lupus → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 6350'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Unpredictable disease flares, serious potential complications, and chronic illness stress contribute to anxiety disorders in lupus patients.',
 'Moderate - Well-documented'),

-- Multiple Sclerosis → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 8018'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'strong', 
 '0-100%', 
 'MS directly affects brain regions involved in mood regulation. Depression occurs in 50% of MS patients and can be from disease process itself or psychological adjustment.',
 'High - Very common in MS'),

-- Multiple Sclerosis → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 8018'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Uncertainty of MS progression, cognitive changes, and functional decline contribute to anxiety. More common than in general population.',
 'Moderate - Common comorbidity'),

-- ============================================
-- CHRONIC PAIN → MENTAL HEALTH
-- ============================================

-- Fibromyalgia → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 5025'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'strong', 
 '0-100%', 
 'Chronic widespread pain, fatigue, and functional impairment from fibromyalgia commonly lead to depression. 50-90% of fibromyalgia patients experience depression.',
 'High - Extremely common'),

-- Fibromyalgia → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 5025'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'strong', 
 '0-100%', 
 'Chronic pain unpredictability, symptom severity fluctuations, and life impact contribute to anxiety. Rates much higher than general population.',
 'High - Very common comorbidity'),

-- Fibromyalgia → Insomnia
((SELECT id FROM conditions WHERE dc_code = 'DC 5025'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9435'), 
 'strong', 
 '0-100%', 
 'Non-restorative sleep is a core feature of fibromyalgia. Pain, hyperarousal, and altered sleep architecture contribute to severe sleep problems.',
 'High - Core fibromyalgia symptom'),

-- Migraine → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 8100'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic migraine burden, disability, and shared neurobiological factors contribute to depression. Migraine patients have 2-4x higher depression risk.',
 'Moderate - Well-documented'),

-- Migraine → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 8100'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Fear of attacks, trigger avoidance, and chronic pain contribute to anxiety. Anxiety and migraine share neurobiological pathways.',
 'Moderate - Common comorbidity'),

-- ============================================
-- CARDIOVASCULAR DISEASE PROGRESSIONS
-- ============================================

-- Hypertension → Heart Failure
((SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7007'), 
 'strong', 
 '10-100%', 
 'Chronic high blood pressure causes heart muscle thickening and stiffening, leading to heart failure. Hypertension is a leading cause of heart failure.',
 'High - Major cause of heart failure'),

-- Hypertension → Ischemic Heart Disease
((SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7005'), 
 'strong', 
 '10-100%', 
 'Hypertension accelerates atherosclerosis and increases cardiac workload, contributing to coronary artery disease development.',
 'High - Major risk factor'),

-- Hypertension → Chronic Kidney Disease
((SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7507'), 
 'strong', 
 '10-100%', 
 'High blood pressure damages kidney blood vessels and filtering units. Hypertension is the second leading cause of CKD.',
 'High - Leading cause of kidney damage'),

-- Hypertension → Erectile Dysfunction
((SELECT id FROM conditions WHERE dc_code = 'DC 7101'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7522'), 
 'moderate', 
 '0-20%', 
 'Hypertension damages blood vessels needed for erections and many blood pressure medications cause ED as side effect.',
 'Moderate - Vascular complication'),

-- Peripheral Vascular Disease → Erectile Dysfunction
((SELECT id FROM conditions WHERE dc_code = 'DC 7117'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 7522'), 
 'strong', 
 '0-20%', 
 'Reduced blood flow from peripheral vascular disease directly impairs erectile function. PVD is a common organic cause of ED.',
 'High - Direct vascular mechanism'),

-- ============================================
-- HEARING CONDITIONS → MENTAL HEALTH
-- ============================================

-- Hearing Loss → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 6100'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Hearing loss leads to social isolation, communication difficulties, and reduced quality of life, increasing depression risk 2-5 fold.',
 'Moderate - Well-established association'),

-- Hearing Loss → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 6100'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Communication challenges, fear of misunderstanding, and social anxiety are common in hearing loss patients.',
 'Moderate - Common psychological impact'),

-- ============================================
-- RESPIRATORY CONDITIONS
-- ============================================

-- COPD → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 6604'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic breathing difficulties, activity limitations, and progressive disease burden contribute to depression in 40-50% of COPD patients.',
 'Moderate - Very common comorbidity'),

-- COPD → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 6604'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Dyspnea (shortness of breath) causes fear and panic. Anxiety occurs in 30-50% of COPD patients and can worsen breathing symptoms.',
 'Moderate - Common comorbidity'),

-- Asthma → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 6602'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Fear of asthma attacks, breathing difficulties, and trigger avoidance contribute to anxiety. Anxiety can also trigger asthma symptoms.',
 'Moderate - Bidirectional relationship'),

-- ============================================
-- JOINT CONDITIONS → COMPENSATORY PROBLEMS
-- ============================================

-- Knee Condition → Hip Condition
((SELECT id FROM conditions WHERE dc_code = 'DC 5257'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5252'), 
 'moderate', 
 '10-60%', 
 'Knee pain causes altered gait and hip mechanics, leading to compensatory hip stress and degenerative changes over time.',
 'Moderate - Biomechanical chain'),

-- Knee Condition → Lumbar Strain
((SELECT id FROM conditions WHERE dc_code = 'DC 5257'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5237'), 
 'moderate', 
 '10-100%', 
 'Knee dysfunction affects posture and gait, increasing stress on lower back. Compensatory patterns can cause or worsen back pain.',
 'Moderate - Kinetic chain dysfunction'),

-- Hip Condition → Lumbar Strain
((SELECT id FROM conditions WHERE dc_code = 'DC 5252'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5237'), 
 'moderate', 
 '10-100%', 
 'Hip problems alter pelvic mechanics and load distribution, commonly causing lower back pain and dysfunction.',
 'Moderate - Biomechanical relationship'),

-- Shoulder Condition → Cervical Strain
((SELECT id FROM conditions WHERE dc_code = 'DC 5201'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5290'), 
 'moderate', 
 '10-60%', 
 'Shoulder dysfunction causes compensatory neck muscle overuse and altered mechanics, contributing to cervical strain.',
 'Moderate - Biomechanical connection'),

-- Ankle Condition → Knee Condition
((SELECT id FROM conditions WHERE dc_code = 'DC 5271'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 5257'), 
 'moderate', 
 '10-60%', 
 'Ankle instability or pain alters gait mechanics and increases stress on knee joint, leading to degenerative changes.',
 'Moderate - Kinetic chain effect'),

-- ============================================
-- INFLAMMATORY BOWEL DISEASE
-- ============================================

-- Crohn's Disease → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 7323'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic illness burden, unpredictable symptoms, and lifestyle limitations contribute to depression in 15-40% of IBD patients.',
 'Moderate - Common comorbidity'),

-- Crohn's Disease → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 7323'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Fear of flares, bathroom access concerns, and social limitations contribute to anxiety in 20-35% of IBD patients.',
 'Moderate - Well-documented'),

-- Ulcerative Colitis → Depression
((SELECT id FROM conditions WHERE dc_code = 'DC 7324'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9434'), 
 'moderate', 
 '0-100%', 
 'Chronic symptoms, potential for surgery, and quality of life impact contribute to depression rates higher than general population.',
 'Moderate - Common psychological impact'),

-- Ulcerative Colitis → Anxiety
((SELECT id FROM conditions WHERE dc_code = 'DC 7324'), 
 (SELECT id FROM conditions WHERE dc_code = 'DC 9400'), 
 'moderate', 
 '0-100%', 
 'Symptom unpredictability, urgency concerns, and disease progression worry contribute to anxiety in UC patients.',
 'Moderate - Well-documented comorbidity')

ON CONFLICT (primary_condition_id, secondary_condition_id) DO NOTHING;
