from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

# Sample pricing model
class PricingModel:
    def __init__(self):
        self.season_weights = [1.0, 1.2, 1.5, 1.3]  # Seasonal multipliers
        self.base_price = 100.0
    
    def predict(self, season, demand):
        return self.base_price * self.season_weights[season] * (1 + demand/100)

model = PricingModel()

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    season = data['season']
    demand = data['demand']
    price = model.predict(season, demand)
    return jsonify({'price': round(price, 2)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
