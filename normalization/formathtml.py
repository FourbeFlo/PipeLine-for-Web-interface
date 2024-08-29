""" format the html file, the script is note finish"""
import unicodedata

def normalize_file_to_nfc(input_file, output_file):
    # Read the content of the file
    with open(input_file, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Normalize the content to NFC
    normalized_content = unicodedata.normalize('NFC', content)
    
    # Write the normalized content back to a new file
    with open(output_file, 'w', encoding='utf-8') as file:
        file.write(normalized_content)

# Replace 'input.html' with your actual file path
input_file = 'test3 - Copy.html'
output_file = 'test3_normalized.html'

normalize_file_to_nfc(input_file, output_file)

print(f"Normalized content has been saved to {output_file}")
