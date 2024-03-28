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
server_ip=$(ip addr show | grep -oE 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -oE '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1) 
cd ~ 
sudo apt-get install -y git 
cd ~ 
git clone https://p_denezhko:1dzQEC@git.head-point.ru/p_denezhko/Selenium_tests_UI.git
sudo apt update
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb 
wget https://storage.googleapis.com/chrome-for-testing-public/123.0.6312.86/linux64/chromedriver-linux64.zip  
unzip chromedriver-linux64.zip 
sudo mv chromedriver-linux64 /usr/local/bin/ 
sudo chmod +x /usr/local/bin/chromedriver-linux64 
cd ~ 
pip install --ignore-installed -r /home/inone/Selenium_tests_UI/requirements.txt 
pip install pytest 
export PATH="$HOME/.local/bin:$PATH" 
which pytest 
export PATH="$PATH:/home/inone/.local/bin" 
sudo apt-get update 
cd /home/inone/Selenium_tests_UI/tools 
sleep 3 
if pytest upload_license_and_confirm.py --headless --url=$server_ip; then
    echo "Тест upload_license_and_confirm.py завершился успешно"
else
    echo "Тест upload_license_and_confirm.py завершился с ошибкой, продолжаем выполнение скрипта"
fi
cd /home/inone/Selenium_tests_UI/autofilling/api 
sleep 5
echo "IP-адрес сервера: $server_ip" 
pytest autofillingAPI.py --headless --url=$server_ip
exit 0
