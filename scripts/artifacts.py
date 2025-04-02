import json

with open('../artifacts/manifest.json', 'r') as f:
    data = json.load(f)

    for model in data['nodes'].values():
        print(model['name'], model['checksum']['checksum'])
