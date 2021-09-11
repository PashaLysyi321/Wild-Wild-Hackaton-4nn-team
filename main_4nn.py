"""
MODULE FOR TEXT SUMMARIZATION
"""

__all__ = ['summary1', 'summary2', 'compare_stemmer_and_lemmatizer', 'get_tags']
__version__ = '0.1'
__author__ = '4nn (pashy)'


import torch
from transformers import AutoTokenizer, AutoModelWithLMHead, pipeline
import re

def summary1(english_text):
    
    english_text = re.sub(r'\([^)]*\)', '', english_text)
    english_text = re.sub(r'\[[^\]]+\]', '', english_text)
    tokenizer = AutoTokenizer.from_pretrained('t5-base')
    model = AutoModelWithLMHead.from_pretrained('t5-base', return_dict=True)
    inputs = tokenizer.encode("summarize: " + english_text,return_tensors='pt',max_length=512,truncation=True)
    summary_ids = model.generate(inputs, max_length=150, min_length=50, length_penalty=5., num_beams=2)
    summary = tokenizer.decode(summary_ids[0])
    return (summary)

def summary2(english_text):
    
    english_text = re.sub(r'\([^)]*\)', '', english_text)
    english_text = re.sub(r'\[[^\]]+\]', '', english_text)
    summarization = pipeline("summarization")
    summary_text = summarization(english_text)[0]['summary_text']
    return (summary_text.replace(' .','.'))

english_text = "Henry Ford (July 30, 1863 – April 7, 1947) was an American industrialist, business magnate, and founder of the Ford Motor Company, and chief developer of the assembly line technique of mass production. By creating the first automobile that middle-class Americans could afford, he converted the automobile from an expensive curiosity into an accessible conveyance that profoundly impacted the landscape of the 20th century.His introduction of the Ford Model T automobile revolutionized transportation and American industry. As the Ford Motor Company owner, he became one of the richest and best-known people in the world. He is credited with Fordism, the mass production of inexpensive goods coupled with high wages for workers. Ford had a global vision, with consumerism as the key to peace. His intense commitment to systematically lowering costs resulted in many technical and business innovations, including a franchise system that put dealerships throughout North America and major cities on six continents. Ford left most of his vast wealth to the Ford Foundation and arranged for his family to permanently control it.Ford was also widely known for his pacifism during the first years of World War I, and for promoting antisemitic content, including The Protocols of the Elders of Zion, through his newspaper The Dearborn Independent, and the book The International Jew."

summary_text = summary2(english_text)
summary_text

import en_core_web_lg
import jellyfish
from nltk.stem import PorterStemmer, WordNetLemmatizer

def compare_stemmer_and_lemmatizer(stemmer, lemmatizer, word, pos):
    return lemmatizer.lemmatize(word, pos)

def get_tags(english_text):
    lemmatizer = WordNetLemmatizer()
    nlp = en_core_web_lg.load()  
    HighPrior = []
    entt = []
    doc = nlp(english_text)
    try:
        for ent in doc.ents:
            if ent.label_ !='DATE' and ent.label_ !='PRODUCT' and ent.label_ !='NORP' and ent.label_ !='WORK_OF_ART' and ent.label_ !='ORDINAL' and ent.label_ !='CARDINAL' and ent.label_ !='TIME' and ent.label_ !='QUANTITY':
                HighPrior.append(lemmatizer.lemmatize(ent.text.lower()))
                entt.append(ent.label_)

    except Exception as e: print(e)

    HighPrior = list(set(HighPrior))
    HighPrior = [lemmatizer.lemmatize(j) for j in HighPrior]

    for i in HighPrior:
        for j in HighPrior:
            if jellyfish.jaro_distance(i,j) > 0.8 and jellyfish.jaro_distance(i,j) <= 0.999:
                try:
                    if len(i)>len(j):
                        HighPrior.remove(i)
                    else:
                        HighPrior.remove(j)
                except Exception as e: print(e)

    for i in HighPrior:
        for j in HighPrior:
            try:
                if i in j and i != j :
                    HighPrior.remove(i)
                elif j in i and i != j :
                    HighPrior.remove(j)
            except: pass
    return HighPrior

english_text = "Vladimir Sviatoslavich (Old East Slavic:, Volodiměrъ Svętoslavičь;[a] Old Norse Valdamarr gamli;[6] c. 958 – 15 July 1015), called the Great, was Prince of Novgorod, Grand Prince of Kiev, and ruler of Kievan Rus' from 980 to 1015.[7][8]Vladimir's father was Prince Sviatoslav I of Kiev of the Rurik dynasty.[9] After the death of his father in 972, Vladimir, who was then prince of Novgorod, was forced to flee to Scandinavia in 976 after his brother Yaropolk murdered his other brother Oleg of Drelinia and conquered Rus'. In Sweden, with the help of his relative Ladejarl Håkon Sigurdsson, ruler of Norway, he assembled a Varangian army and reconquered Novgorod from Yaropolk.[10] By 980, Vladimir had consolidated the Rus realm from modern-day Belarus, Russia and Ukraine to the Baltic Sea and had solidified the frontiers against incursions of Bulgarians, Baltic tribes and Eastern nomads. Originally a follower of Slavic paganism, Vladimir converted to Christianity in 988[11][12][13] and Christianized the Kievan Rus'.[9] He is thus also known as Saint Vladimir."
summary_text = summary2(english_text)
get_tags(summary_text)

summary_text = " Vladimir Sviatoslavich was Prince of Novgorod, Grand Prince of Kiev, and ruler of Kievan Rus' from 980 to 1015. Originally a follower of Slavic paganism, Vladimir converted to Christianity in 988 and Christianized the Rus'. He is thus also known as Saint Vladimir."
tags = get_tags(summary_text)
tags
from urllib.parse import urlparse

def get_image(tags):
    links = []
    for i in tags:
        url = "https://www.google.com/search?q="+i+"&tbm=isch"
        domain = urlparse(url).netloc
        req = requests.get(url)
        soup = BeautifulSoup(req.text, "html.parser")
        raw_links = soup.find_all("img")
        photo = raw_links[1]
        photo = str(photo).split('src="')[1].replace('"/>','')
        links.append(photo)
    return links

get_image(tags)

import requests 
import io 
import soundfile as sf 
import numpy as np 
 
def get_audio(sentence, output_file): 
    endpoint = 'https://api.wildwildhack.ai/api/tts' 
    data = {"input_text": sentence, "voice_id": "ljspeech", "title": "title", "output_format": "wav"} 
    headers = {"Authorization": "Bearer c5b13ce59b12407988d82469792920e5"} 
    object_id_dict = requests.post(endpoint, data=data, headers=headers).json() 
    endpoint = f'https://api.wildwildhack.ai/api/audio/{object_id_dict["object_id"]}' 
    audio_url_dict = requests.get(endpoint, headers=headers) 
    audio_url_dict = audio_url_dict.json() 
    endpoint = audio_url_dict["origin_path"] 
    audio = requests.get(endpoint) 
    return audio.content 
 
def get_sentences_smaller_than_200(sentence): 
    word_list = sentence.split(' ') 
    sentence_len = 0 
    sentences_list = [[]] 
    for word_idx in range(len(word_list)): 
        if word_idx==0 or word_idx==len(word_list)-1: 
            sentence_len += len(word_list[word_idx]) + 1 
        else: 
            sentence_len += len(word_list[word_idx])+2 
        if sentence_len>=200: 
            sentences_list.append([word_list[word_idx]]) 
            sentence_len = len(word_list[word_idx])+2 
        else: 
            sentences_list[-1].append(word_list[word_idx]) 
    for sentence_part_idx, sentence_part in enumerate(sentences_list): 
        sentences_list[sentence_part_idx] = " ".join(sentence_part) 
    return sentences_list 
 
 
 
def save_audio_from_all_text(input_text, output_file): 
    audio_list = [] 
    for sentence in input_text.split("."): 
        if len(sentence) > 200: 
            sentence_parts = get_sentences_smaller_than_200(sentence) 
            for sentence_part in sentence_parts: 
                audio_list.append(get_audio(sentence_part, output_file)) 
        elif len(sentence)!=0: 
            audio_list.append(get_audio(sentence, output_file)) 
    data1, samplerate1 = sf.read(io.BytesIO(audio_list[0])) 
    del audio_list[0] 
    for audio in audio_list: 
        data, samplerate = sf.read(io.BytesIO(audio)) 
        data1 = np.concatenate((data1, data)) 
 
    sf.write(output_file, data1, samplerate=samplerate1, format="wav") 


save_audio_from_all_text(english_text, "audio.wav")
