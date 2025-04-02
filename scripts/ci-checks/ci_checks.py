import yaml
import os

# Get the script's directory
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the absolute path to the YAML file
file_path = os.path.join(script_dir, "../../dbt/analytics_data_stack/models/staging/_stg__sources.yml")

# Open and read the YAML file
with open(file_path, 'r') as f:
    data = yaml.safe_load(f)

    source = data.get("sources")
    print(data)
    for table in source:
        print(table.get('tables'))
