"""script for nomalize the scripture in a txt or a xml file. The xml file must have the same structure 
as my file : the normalization is implement on the <reg> elements. """ 

import sys
import os
import xml.etree.ElementTree as ET
from normalisation_rv import normalize_latin_text
from xml.dom import minidom

# Helper function to remove namespaces
def remove_namespace(tree):
    for elem in tree.iter():
        if '}' in elem.tag:
            elem.tag = elem.tag.split('}', 1)[1]  # Remove namespace

# Pretty-print the XML
def prettify(elem):
    rough_string = ET.tostring(elem, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    # Remove extra newlines and unnecessary spaces
    return '\n'.join([line for line in reparsed.toprettyxml(indent="  ").splitlines() if line.strip()])

def normalize_text_file(input_file, output_file):
    """Normalize a plain text file."""
    try:
        with open(input_file, 'r', encoding='utf-8') as file:
            text = file.read()

        # Apply the normalization
        normalized_text = normalize_latin_text(text)

        with open(output_file, 'w', encoding='utf-8') as file:
            file.write(normalized_text)

        print(f"Normalization complete. Output saved to {output_file}")

    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

def normalize_xml_file(input_file, output_file):
    """Normalize an XML file."""
    try:
        # Parse the XML file
        tree = ET.parse(input_file)
        root = tree.getroot()

        # Remove the namespace prefixes
        remove_namespace(root)

        # Define the tag you're interested in
        target_tag = 'reg'

        # Iterate over each element with the target tag
        for elem in root.iter(target_tag):
            original_text = elem.text
            if original_text:
                # Normalize text, including replacing '&' with 'et'
                normalized_text = normalize_latin_text(original_text.replace('&', 'et'))
                elem.text = normalized_text

        # Write the normalized XML to a file, with pretty-printing
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(prettify(root))

        print(f"XML normalization complete. Output saved to {output_file}")

    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")
    except ET.ParseError:
        print(f"Error: Failed to parse XML file '{input_file}'.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python main.py <input_file> <output_file>")
    else:
        input_file = sys.argv[1]
        output_file = sys.argv[2]

        # Determine the file type by extension
        file_extension = os.path.splitext(input_file)[1].lower()

        if file_extension == ".xml":
            normalize_xml_file(input_file, output_file)
        else:
            normalize_text_file(input_file, output_file)
