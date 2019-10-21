# Example of Crawler

Use Virtual Box to build an environment that can execute the rentea-crawler.

Execute the crawler and get a rent house record to understand the format and value. 

## Environment

```
Ubuntu 18.04 on the Virtual Box
```

## Manual installation

```bash
sudo apt-get update

sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y openssh-server

sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https
sudo apt-get install -y ca-certificates
sudo apt-get install -y curl
sudo apt-get install -y gnupg-agent
sudo apt-get install -y software-properties-common

sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa
sudo apt-get install -y python3.7
cd
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python3.7 get-pip.py
pip3.7 --version

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo docker-compose --version

cd
git clone https://github.com/rentea-tw/rentea-crawler.git
cd rentea-crawler
sudo docker-compose build crawler

cd
cd rentea-crawler
sudo pip3.7 install virtualenv
virtualenv -p /usr/bin/python3.7 .venv
source .venv/bin/activate
sudo pip install -r requirements.txt --ignore-installed

scrapy crawl periodic591 -a minuteago=60 -a target_cities='台南市,屏東縣' -s JOBDIR=data/spider-1
# 2019-00-00 00:00:00 [root] INFO: [台南市] total 10 house to crawl!
# 2019-00-00 00:00:00 [root] INFO: [屏東縣] total 20 house to crawl!
# After displaying the above message, press Ctrl-C
cat ./data/20190000-000000.jsonl 
```

## Data

```
{"vendor": "租屋網", "vendor_house_id": 000000, "monthly_price": 1000, "imgs": ["XXX", "XXX", "XXX", "XXX", "XXX", "XXX"], "deposit_type": 2, "n_month_deposit": null, "deposit": null, "is_require_management_fee": true, "monthly_management_fee": 550, "has_parking": true, "is_require_parking_fee": true, "monthly_parking_fee": 0, "per_ping_price": 910.0, "top_region": 9, "sub_region": 906, "rough_address": "XXX", "deal_status": 0, "building_type": 2, "property_type": 1, "floor": 2, "total_floor": 4, "is_rooftop": false, "dist_to_highest_floor": 2, "floor_ping": 5, "additional_fee": {"eletricity": true, "water": true, "gas": true, "internet": true, "cable_tv": true}, "living_functions": {"school": true, "park": false, "dept_store": true, "conv_store": true, "traditional_mkt": true, "night_mkt": true, "hospital": true, "police_office": false}, "transportation": {}, "has_tenant_restriction": true, "has_gender_restriction": false, "gender_restriction": 0, "can_cook": false, "allow_pet": false, "has_perperty_registration": true, "facilities": {"桌子": true, "椅子": true, "衣櫃": true, "床": true, "沙發": true, "熱水器": true, "電視": true, "冰箱": true, "冷氣": true, "洗衣機": true, "網路": true, "第四台": true, "天然瓦斯": false}, "contact": 1, "author": "XXX", "rough_coordinate": ["XX.XXXXXXX", "XXX.XXXXXXX"]}
```