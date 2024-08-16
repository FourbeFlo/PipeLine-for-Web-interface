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

# Parse the XML file add your file name .xml
tree = ET.parse('3.TEI_edited.xml')
root = tree.getroot()

# Remove the namespace prefixes
remove_namespace(root)

# Define the tag you're interested in
target_tag = 'reg'

# Iterate over each element with the target tag
for elem in root.iter(target_tag):
    original_text = elem.text
    if original_text:
        # Normalize text, including replacing '&' with 'et' add this line because the logical structure of xml &amp; = & 
        normalized_text = normalize_latin_text(original_text.replace('&', 'et'))
        elem.text = normalized_text

# Write the normalized XML to a file, with pretty-printing
with open("normalized_tei5.xml", "w", encoding="utf-8") as f:
    f.write(prettify(root))