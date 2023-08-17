# Makefile for run application local and run tests

# Work only run in virtualenv (make run_app) only in command line
run_app:
				uvicorn app.main:app --reload

# Work only run in virtualenv (make unit_tests) only in command line
unit_tests:
				pytest

# Work only run in virtualenv (make freeze) only in command line
freeze:
				pip freeze > requirements.txt
