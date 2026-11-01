# Reconnaissance Vocale de la Langue Fon

GbeCé est une application de reconnaissance automatique de la parole conçue pour la langue fon. Le projet vise à faciliter la transcription automatique d'enregistrements audio en texte tout en contribuant à la valorisation des langues africaines à faibles ressources numériques.

## Objectifs

- Développer un système capable de convertir la parole en langue fon en texte.
- Comparer des approches classiques et modernes de reconnaissance vocale.
- Proposer une interface simple permettant l'utilisation du modèle par les utilisateurs.

## Fonctionnalités

- Transcription automatique d'audios en langue fon.
- Comparaison de plusieurs modèles de reconnaissance vocale.
- Interface web intuitive pour le téléversement et l'analyse des fichiers audio.
- API dédiée pour l'exécution des modèles et le retour des résultats.

## Technologies Utilisées

### Intelligence Artificielle & Traitement de la Parole

- Python
- SpeechBrain
- Wav2Vec2
- Hidden Markov Models (HMM)
- PyTorch

### Backend

- FastAPI

### Frontend

- Next.js
- React
- Tailwind CSS

## Architecture du Projet

```text
Utilisateur
      |
      v
 Interface Web (Next.js)
      |
      v
 API FastAPI
      |
      v
 Modèle de Reconnaissance Vocale
(HMM ou Wav2Vec2/SpeechBrain)
      |
      v
 Texte transcrit
```

## Méthodologie

1. Collecte et préparation des données audio en langue fon.
2. Prétraitement des signaux audio.
3. Entraînement et évaluation des modèles HMM et Wav2Vec2.
4. Comparaison des performances des modèles.
5. Déploiement via une API FastAPI et une interface Next.js.

## Résultats Attendus

- Amélioration de l'accessibilité numérique de la langue fon.
- Production automatique de transcriptions textuelles.
- Contribution au développement des technologies de traitement automatique des langues africaines.

## Installation

### Cloner le projet

```bash
git clone https://github.com/votre-utilisateur/gbecé.git
cd gbece
```

### Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```

