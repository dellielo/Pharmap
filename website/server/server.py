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
    request.args['lattitudeMin'] or -90,
    request.args['lattitudeMax'] or 90,
    request.args['longitudeMin'] or -180,
    request.args['longitudeMax'] or 180
    )
    return jsonify(result)


@app.route("/")
def hello():
    return "Hello World!"
