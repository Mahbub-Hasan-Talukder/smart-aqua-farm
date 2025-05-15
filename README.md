# Smart Aqua Farm 🐟📱

Smart Aqua Farm is a mobile application designed to assist fish farmers and aquaculture enthusiasts in detecting fish diseases using deep learning. With just a fish image, the app can classify the fish as healthy or detect one of several common diseases, and also provide detailed information on each disease.

## 🔑 Key Features

- 🔐 **Authentication**: User sign-up and login powered by [Supabase](https://supabase.io/).
- 🧠 **Fish Disease Detection**: Upload a fish image and instantly classify it using a deep learning model.
  - Disease Categories:
    - Aeromoniasis
    - Bacterial Gill Disease
    - Bacterial Red Disease
    - Saprolegniasis
    - Healthy Fish
    - Parasitic Diseases
    - White Tail Disease
- 📚 **Disease Library**: Browse a list of fish diseases. Tap on any to see:
  - Disease image
  - Description
  - Symptoms
  - Treatment
- 👤 **User Profile**: View user account information.

## 🛠 Tech Stack

| Tech           | Purpose                        |
|----------------|--------------------------------|
| Flutter        | Frontend development           |
| Supabase       | Authentication & database      |
| EfficientNet-B0| Deep learning classification   |
| BLoC           | State management               |
| Clean Architecture | Project structure and scalability |

## 🧪 Model Details

The app uses a trained **EfficientNet-B0** model to classify fish images into 7 categories. The model was trained offline and integrated into the app using Flutter's image classification APIs.

## 📸 Screenshots
<p align="center">
  <img src="https://github.com/user-attachments/assets/bf97c33c-db5a-443a-a994-9ee6f0db0ff4" alt="Sign In Screen" width="200"/>
  <img src="https://github.com/user-attachments/assets/34b9049a-2ff1-407d-9d7c-cc8fa6fb05e9" alt="Sign Up Screen" width="200"/>
  <img src="https://github.com/user-attachments/assets/84f65d5e-7af8-4779-b699-e3553338bb96" alt="Home Screen" width="200"/>
  <img src="https://github.com/user-attachments/assets/2faebf8d-15a3-4071-a231-6d322246623f" alt="Disease Classes Screen" width="200"/>
  <img src="https://github.com/user-attachments/assets/57c2af91-9d1e-49bb-b411-ec0d473f0b7b" alt="Disease Details Screen" width="200"/>
</p>

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.x.x)
- Dart (>= 3.x.x)
- Supabase account with authentication and database configured

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/smart-aqua-farm.git
   cd smart-aqua-farm
