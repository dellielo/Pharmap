from flask import Flask, request, abort
from flask.json import jsonify
import sql
app = Flask(__name__)

@app.route("/getSpecies", methods=['GET'])
def getSpecies():
    return "incoming"

@app.route("/species/<int:specieId>/prediction", methods=['GET'])
def getSpeciesPrediction(specieId):
    result = sql.getSpeciePredict(specieId,
    request.args.get('lattitudeMin', -90),
    request.args.get('lattitudeMax', 90),
    request.args.get('longitudeMin', -180),
    request.args.get('longitudeMax', 180)
    )
    return jsonify(result)


@app.route("/")
def hello():
    return "Hello World!"
