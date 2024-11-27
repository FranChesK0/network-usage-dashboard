.PHONY: help install shell test lint format check clean pre-commit-install pre-commit run debug show-routes

# Default target
.DEFAULT_GOAL := help

# Default Python interpreter
PYTHON = python

help:
	@echo "Available commands:"
	@echo "  help               - Display this help message"
	@echo "  install            - Install project dependencies using Poetry"
	@echo "  shell              - Open a shell with the virtual environment activated"
	@echo "  test               - Run tests using pytest"
	@echo "  lint               - Run code quality checks (flake8, mypy)"
	@echo "  format             - Format code using black and isort"
	@echo "  check              - Run all quality checks (lint + test)"
	@echo "  clean              - Remove build artifacts and cache files"
	@echo "  pre-commit-install - Install pre-commit hooks"
	@echo "  pre-commit         - Run pre-commit hooks on all files"
	@echo "  run                - Run the application"
	@echo "  debug              - Run the application in debug mode"
	@echo "  show-routes        - Show all routes in the application"

install:
	poetry install

shell:
	poetry shell

test:
	pytest

lint:
	flake8 .
	mypy .

format:
	isort .
	black .

check:
	format
	lint
	test

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name "*.egg" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	find . -type d -name ".coverage" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name "htmlcov" -exec rm -rf {} +
	find . -type d -name ".tox" -exec rm -rf {} +
	find . -type d -name "dist" -exec rm -rf {} +
	find . -type d -name "build" -exec rm -rf {} +

pre-commit-install:
	pre-commit install

pre-commit:
	pre-commit run --all-files --hook-stage pre-push

run:
	flask --app network_usage_dashboard/main run

debug:
	flask --app network_usage_dashboard/main --debug run

show-routes:
	flask --app network_usage_dashboard/main.py routes --sort domain
