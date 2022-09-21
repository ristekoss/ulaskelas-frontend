validate:
	@echo -e "\033[33mValidating... wait a minute\033[m"
	flutter analyze; flutter test
	@echo -e "*\n*\033[m\n\033[34mCompleted ya, thank you for waiting. Make sure you happy.\033[m"

build_runner:
	@echo -e "\033[33mI Will Generate code for you\033[m\n\033[34mPlease Wait for\033[m\n\033[32m30 seconds\033[m\n*\n*"
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs
	@echo -e "*\n*\033[m\n\033[34mCompleted ya, thank you for waiting\033[m"
