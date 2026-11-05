@echo off
setlocal

set "PROJECT=%~dp0"
if not defined JAVA_HOME set "JAVA_HOME=C:\Program Files\Java\jdk-22"
if not defined CATALINA_HOME set "CATALINA_HOME=C:\xampp\tomcat"
set "SERVLET_API=%CATALINA_HOME%\lib\servlet-api.jar"
set "BUILD=%PROJECT%target\build"
set "CLASSES=%BUILD%\classes"
set "WAR_STAGE=%BUILD%\war"

if not exist "%JAVA_HOME%\bin\javac.exe" (
  echo Java compiler not found. Set JAVA_HOME to your JDK folder.
  exit /b 1
)
if not exist "%SERVLET_API%" (
  echo Servlet API not found at "%SERVLET_API%".
  echo Set CATALINA_HOME to your Apache Tomcat folder.
  exit /b 1
)

if exist "%BUILD%" rmdir /s /q "%BUILD%"
if not exist "%PROJECT%dist" mkdir "%PROJECT%dist"
mkdir "%CLASSES%"
mkdir "%WAR_STAGE%"
mkdir "%WAR_STAGE%\WEB-INF\classes"

pushd "%PROJECT%src\main\java"
"%JAVA_HOME%\bin\javac.exe" --release 11 -encoding UTF-8 -cp "%SERVLET_API%" -d "%CLASSES%" exception\InvalidUserException.java model\User.java service\UserOperations.java service\UserService.java web\AppContextListener.java web\AuthServlet.java web\DashboardServlet.java web\HomeServlet.java web\HtmlEscape.java web\LogoutServlet.java web\RegisterServlet.java
if errorlevel 1 (
  popd
  exit /b 1
)
popd

xcopy "%PROJECT%src\main\webapp\*" "%WAR_STAGE%\" /E /I /Y >nul
if errorlevel 2 (
  echo Could not stage the web application files.
  exit /b 1
)
xcopy "%CLASSES%\*" "%WAR_STAGE%\WEB-INF\classes\" /E /I /Y >nul
if errorlevel 2 (
  echo Could not stage the compiled Java classes.
  exit /b 1
)

if exist "%PROJECT%dist\GamingZonePhase4.war" del /q "%PROJECT%dist\GamingZonePhase4.war"
"%JAVA_HOME%\bin\jar.exe" --create --file "%PROJECT%dist\GamingZonePhase4.war" -C "%WAR_STAGE%" .
if errorlevel 1 exit /b 1

echo.
echo Phase 4 WAR created: "%PROJECT%dist\GamingZonePhase4.war"
