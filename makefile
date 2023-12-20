ifeq ($(OS),Windows_NT)
    BUILD_CMD=.\build_and_run_app.bat
    METRICS_CMD=.\tools\dart_code_metrics.bat
    COMMIT_CHECK_CMD=.\tools\check_commit_message.bat
else
    BUILD_CMD=./build_and_run_app.sh
    METRICS_CMD=./tools/dart_code_metrics.sh
    COMMIT_CHECK_CMD=./tools/check_commit_message.sh
endif

get:
	flutter pub get

clean:
	flutter clean

reload_package:
	flutter clean && flutter pub get

run:
	flutter packages pub run build_runner build

run_watch:
	flutter packages pub run build_runner watch

run_watch_delete_conflict:
	fvm flutter packages pub run build_runner watch --delete-conflicting-outputs

build_apk_dev:
	flutter build apk --dart-define=DART_DEFINES_BASE_URL="https://core.kafa.pro"

build_apk_pro:
	fvm flutter build apk --dart-define=DART_DEFINES_APP_NAME="Mykiot" --dart-define=DART_DEFINES_BASE_URL="https://api.kafa.pro"

build_appbundle:
	fvm flutter build appbundle --dart-define=DART_DEFINES_APP_NAME="Mykiot" --dart-define=DART_DEFINES_BASE_URL="https://api.kafa.pro"

build_ios:
	flutter build ios --dart-define=DART_DEFINES_BASE_URL="https://api.kafa.pro"

build_runner:
	flutter packages pub run build_runner watch --delete-conflicting-outputs
