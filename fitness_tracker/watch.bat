@echo off
setlocal EnableDelayedExpansion

echo Running chrome
call flutter run -d chrome
if not errorlevel 0 (
echo Error running chrome
exit /b errorlevel
)