sudo apt update
sudo apt-get install -y postgis 
sudo apt-get install -y liblua5.4-0 
sudo apt-get install -y gpac 
sudo apt-get remove -y --auto-remove python3 
sudo apt-get autoremove 
sudo apt-get clean 
sudo apt install build-essential -y
wget https://www.python.org/ftp/python/3.11.8/Python-3.11.8.tgz 
tar -xvf Python-3.11.8.tgz
cd Python-3.11.8 
./configure 
make 
sudo make install 
cd ~ 
sleep 3
sudo apt-get install -y python3-pip 
pip install -U pip 
cd ~ 
sudo apt update
sudo apt install -y ruby
sudo gem install lolcat
sudo apt-get install figlet
cd ~
server_ip=$(ip addr show | grep -oE 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -oE '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1) 
cd ~ 
sudo apt-get install -y git 
cd ~ 
git clone https://p_denezhko:1dzQEC@git.head-point.ru/p_denezhko/Selenium_tests_UI.git
sudo apt update
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
sleep 1
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb 
sleep 1
wget https://storage.googleapis.com/chrome-for-testing-public/123.0.6312.86/linux64/chromedriver-linux64.zip  
unzip chromedriver-linux64.zip 
sleep 1
sudo mv chromedriver-linux64 /usr/local/bin/ 
sudo chmod +x /usr/local/bin/chromedriver-linux64 
cd ~ 
sleep 1
pip install --ignore-installed -r /home/inone/Selenium_tests_UI/requirements.txt 
cd ~
pip install pytest
sleep 1
export PATH="$HOME/.local/bin:$PATH" 
sleep 1
which pytest 
sleep 1
export PATH="$PATH:/home/inone/.local/bin"
cd ~
sudo apt-get update
wget https://github.com/allure-framework/allure2/releases/download/2.27.0/allure_2.27.0-1_all.deb
sudo dpkg -i allure_2.27.0-1_all.deb
sudo apt-get update
cd /home/inone/Selenium_tests_UI/tools 
sleep 3 
if pytest /home/inone/Selenium_tests_UI/tools/upload_license_and_confirm.py --headless --url=$server_ip; then
    echo "Script upload_license_and_confirm.py succesfull"
else
    echo "Script upload_license_and_confirm.py was terminated with an error, continue script execution"
fi
cd /home/inone/Selenium_tests_UI/autofilling/api 
sleep 5
echo "IP-address server: $server_ip"
pytest autofillingAPI.py --headless --url=$server_ip
cd /home/inone/Selenium_tests_UI
if pytest autofilling/test/autofilling_test.py --headless --url=$server_ip --alluredir=./allure-results; then
    figlet "ALL SUCCESFULL" | lolcat
    cd ~
else
    server_ip=$(ip addr show | grep -oE 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -oE '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1) 
    figlet "CHECK TEST RESULTS ON $server_ip:1448" | lolcat
    echo "CHECK TEST RESULTS ON $server_ip:1448 and message to @p_denezhko"
    allure serve --host $server_ip --port 1448 ./allure-results
fi
