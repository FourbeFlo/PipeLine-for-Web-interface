"""script to parse html bible and creat dictionary for tagging the xml-tei"""
import requests
from bs4 import BeautifulSoup

# List of URLs for the pages to scrape
urls = [
    'https://www.drbo.org/lvb/chapter/61001.htm',
    'https://www.drbo.org/lvb/chapter/61002.htm',
    'https://www.drbo.org/lvb/chapter/61003.htm',
    'https://www.drbo.org/lvb/chapter/61004.htm',
    'https://www.drbo.org/lvb/chapter/61005.htm',
    'https://www.drbo.org/lvb/chapter/61006.htm'
]

# Initialize a dictionary to hold the verses
timothy_dict_latin = {}

# Function to process a single page
def process_page(url):
    # Send a request to fetch the HTML content
    response = requests.get(url)
    html_content = response.text

    # Parse the HTML content using BeautifulSoup
    soup = BeautifulSoup(html_content, 'html.parser')

    # Find all verse links and their corresponding text
    verse_links = soup.find_all('a', class_='vn')

    for link in verse_links:
        verse_number = link.get_text(strip=True)
        # Get the following sibling text node
        verse_text = link.find_next_sibling(text=True).strip()
        
        # Combine verse number with text
        if verse_number and verse_text:
            # Extract chapter from the URL (assumes URL format like /61001.htm)
            chapter_number = url.split('/')[-1].split('.')[0][2:]
            # Remove leading zeros
            chapter_number = str(int(chapter_number))
            # Remove leading zeros from verse number if necessary
            verse_number = str(int(verse_number))
            timothy_dict_latin[f"{chapter_number}:{verse_number}"] = verse_text

# Process each URL
for url in urls:
    process_page(url)

# Create a Python script content with the dictionary
dict_lines = [f"    '{key}': '{value}'" for key, value in timothy_dict_latin.items()]
dict_script_content = "# Generated dictionary\n"
dict_script_content += "timothy_dict_latin = {\n"
dict_script_content += ",\n".join(dict_lines) + "\n"
dict_script_content += "}\n"

# Write the dictionary to a .py file
with open('timothy_dict_latin.py', 'w', encoding='utf-8') as file:
    file.write(dict_script_content)

print("Python script with dictionary has been written to 'timothy_dict_latin.py'.")
