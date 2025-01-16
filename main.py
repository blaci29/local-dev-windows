from dotenv import load_dotenv
import os

# Betöltjük a környezeti változókat
load_dotenv('api_keys.env')

# API kulcsok elérése
openai_api_key = os.getenv('OPENAI_API_KEY')
another_api_key = os.getenv('ANOTHER_API_KEY')

# Példa használat
if __name__ == "__main__":
    print(f"OpenAI API Key: {openai_api_key}")
    print(f"Another API Key: {another_api_key}")
