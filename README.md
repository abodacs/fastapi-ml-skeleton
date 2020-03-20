# FastAPI Model Server Skeleton

Serving machine learning models production-ready, fast, easy and secure powered by the great FastAPI by [Sebastián Ramírez]([)](https://github.com/tiangolo).

This repository contains a skeleton app which can be used to speed-up your next machine learning project. The code is fully tested and provides a preconfigured `tox` to quickly expand this sample code.

To experiment and get a feeling on how to use this skeleton, a sample regression model for house price prediction is included in this project. Follow the installation and setup instructions to run the sample model and serve it aso RESTful API.

## Requirements

* Docker
* Docker Compose

## Installation
* Start the stack with Docker Compose:

```bash
make build
```` 

## Setup
1. Duplicate the `.env.example` file and rename it to `.env` 


2. In the `.env` file configure the `API_KEY` entry. The key is used for authenticating our API. <br>
   A sample API key can be generated using Python REPL:
```python
import uuid
print(str(uuid.uuid4()))
```

## Run It

1. Start your  app with: 
```bash
make up
```

2. Go to [http://localhost:8888/docs](http://localhost:8888/docs).
   
3. Click `Authorize` and enter the API key as created in the Setup step.
![Authroization](backend/docs/authorize.png)
   
4. You can use the sample payload from the `docs/sample_payload.json` file when trying out the house price prediction model using the API.
   ![Prediction with example payload](backend/docs/sample_payload.png)

## Run Tests

If you're not using `tox`, please install with:
```bash
pip install tox
```

Run your tests with: 
```bash
tox
```

This runs tests and coverage for Python 3.6 and Flake8, Autopep8, Bandit.
