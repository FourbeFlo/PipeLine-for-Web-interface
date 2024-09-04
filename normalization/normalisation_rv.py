#normalisation_rv.py
import re
def replace_symbol(text):
    # Replace specific symbols and patterns
    # concerne any exception that have to be done at first befor any transformation (add tamen)
    replacements = {
        r'¬': '-',     # Replace ¬ with -
        r'nõ': 'non',  # Replace nõ with non
        r'&amp;': 'et' , # Normalize '&amp;' to 'et'
    }
     # Apply each replacement
    for pattern, replacement in replacements.items():
        text = re.sub(pattern, replacement, text)
    
    return text

def replace_tilde(text):
    # Replace ã followed by optional ¬ and d or t with an, preserving the d or t
    text = re.sub(r'ã¬?([dt])', r'an\1', text)
    # Replace ã followed by optional ¬ and any other character with am, preserving that character
    text = re.sub(r'ã¬?([^\S\r\n<]|.)', lambda m: 'am ' if m.group(1).isspace() else 'am' + m.group(1), text)
    # Replace ã at the end of a line with am
    text = re.sub(r'ã¬?$', 'am', text, flags=re.MULTILINE)
    
    # Replace ẽ followed by optional ¬ and d or t with en, preserving the d or t
    text = re.sub(r'ẽ¬?([dt])', r'en\1', text)
    # Replace ẽ at the end of a line with em
    text = re.sub(r'ẽ¬?$', 'em', text, flags=re.MULTILINE)
    # Replace ẽ followed by optional ¬ and any other character with em, preserving that character
    text = re.sub(r'ẽ¬?([^\S\r\n<]|.)', lambda m: 'em ' if m.group(1).isspace() else 'em' + m.group(1), text)

    # Replace õ followed by optional ¬ and p or b with om, preserving the p or b
    text = re.sub(r'õ¬?([pb])', r'om\1', text)
    # Replace õ followed by optional ¬ and any other character with on, preserving that character
    text = re.sub(r'õ¬?([^pb])', r'on\1', text)
    # Replace õ at the end of a line with on
    text = re.sub(r'õ¬?$', 'on', text, flags=re.MULTILINE)
    
    # Replace ũ followed by optional ¬ and t with un, preserving the t
    text = re.sub(r'ũ¬?(t)', r'un\1', text)
    # Replace ũ followed by optional ¬ and any other character with um, preserving that character
    text = re.sub(r'ũ¬?([^\S\r\n<]|.)', lambda m: 'um ' if m.group(1).isspace() else 'um' + m.group(1), text)
    # Replace ũ at the end of a line with um
    text = re.sub(r'ũ¬?$', 'um', text, flags=re.MULTILINE)
    
    return text
# Replace v followed by a consonant with u
def replace_u_consonant(text):
    text = re.sub(r'v([bcdfghjklmnpqrstvwxyz])', lambda m: 'u' + m.group(1), text, flags=re.IGNORECASE)
    return text
# Define common Latin normalization patterns and replacements
def normalize_latin_text(text):
    # Apply complex replacement rules
    text = replace_symbol(text)
    text = replace_tilde(text)
    text = replace_u_consonant(text)
    # Define additional normalization patterns and replacements
    replacements = {
        r'ſ': 's',  # Old 'long s' to modern 's'
        r'&amp;': 'et' , # Normalize '&amp;' to 'et'
        r'œ': 'oe', # 'œ'  replaced by 'oe'
        r'æ': 'ae', # 'æ'  replaced by 'ae'
        r'ę': 'ae', # 'ę'  replaced by 'ae'
        r'ā': 'a',  # Replace 'ā' with 'a'
        r'à': 'a',  # Replace 'à' with 'a'
        r'á': 'a',  # Replace 'â' with 'a'
        r'è': 'e',  # Replace 'è' with 'e'
        r'ī': 'i',  # Replace 'ī' with 'i'
        r'í': 'i',  # Replace 'í' with 'i'
        r'î': 'i',  # Replace 'î' with 'i'
        r'ĩ': 'i',   # Replace 'ĩ' with 'i'
        r'ij': 'ii', # Replace 'ij' with 'ii'
        r'ō': 'o',  # Replace 'ō' with 'o'
        r'ò': 'o',  # Replace 'ò' with 'o'
        r'ó': 'o',  # Replace 'ó' with 'o'
        r'ū': 'u',  # Replace 'ū' with 'u'
        r'ú': 'u',  # Replace 'ú' with 'u'
        r'ù': 'u',  # Replace 'ù' with 'u'
        r'¬': '-',  # Replace '¬' with '-'
        r'q;':'que', # Replace 'q;' with 'que'
    }
    # Apply each replacement
    for pattern, replacement in replacements.items():
         text = re.sub(pattern, replacement, text)
    return text
    
 """Use the main function to implement the code for processing an XML or TXT file."""
   
